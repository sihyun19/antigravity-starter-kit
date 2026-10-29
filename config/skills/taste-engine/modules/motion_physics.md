# 🖥️ Domain 3: 스프링 물리 & 3D 틸트 모션 엔진 (Motion-Physics)

이 모듈은 `emilkowalski/skill`의 핵심 철학을 바탕으로, 고정된 시간($t$) 기반의 딱딱한 애니메이션을 탈피하여 **질량($m$), 강도($k$), 감쇠($c$) 기반의 자연스러운 유기체 모션**을 C++, Web, Python 환경에 제공합니다.

---

## 1. 물리 코어: 반암시적 오일러 스프링-댐퍼 (Semi-implicit Euler)

> [!NOTE]
> 단순 명시적 오일러(Explicit Euler)는 프레임 드랍이나 큰 $\Delta t$ 발생 시 진동이 폭발(Divergence)합니다.  
> Gemini 4 Argon 권고에 따라 **에너지 보존성이 뛰어난 반암시적 오일러(Semi-implicit Euler)** 방식을 표준 공식으로 채택합니다.

### 수학적 공식
$$\begin{aligned}
a &= -\frac{k}{m} (x - x_{\text{target}}) - \frac{c}{m} v \\
v_{\text{new}} &= v + a \cdot \Delta t \\
x_{\text{new}} &= x + v_{\text{new}} \cdot \Delta t
\end{aligned}$$

* $k$ (Stiffness / 강도): 목표 위치로 끌어당기는 복원력
* $c$ (Damping / 감쇠): 진동 에너지를 흡수하여 멈추게 하는 마찰력
* $m$ (Mass / 질량): 관성의 크기 (무게감)

---

## 2. C++ 네이티브 단일 헤더 스니펫 (`SpringCore.h`)

`charcoal_native.cpp` 등 Win32/GDI+ 프로젝트에 바로 포함하여 사용할 수 있는 초경량 인라인 구조체입니다. 외부 종속성 0(Zero Dependency)을 보장합니다.

```cpp
#pragma once
#include <cmath>

struct Spring1D {
    float x = 0.0f;
    float v = 0.0f;
    float target = 0.0f;
    float stiffness = 220.0f; // k
    float damping   = 14.0f;  // c
    float mass      = 1.0f;   // m

    void Update(float dt) {
        if (dt <= 0.0f) return;
        if (dt > 0.064f) dt = 0.064f; // 15fps 이하 저프레임 안전 클램프

        float fSpring = -stiffness * (x - target);
        float fDamper = -damping * v;
        float a = (fSpring + fDamper) / mass;

        v += a * dt;        // 1. 속도 먼저 업데이트 (Semi-implicit)
        x += v * dt;        // 2. 새로운 속도로 위치 업데이트

        // 마이크로 진동 정지 (Settle Threshold)
        if (std::abs(v) < 0.005f && std::abs(x - target) < 0.005f) {
            x = target;
            v = 0.0f;
        }
    }
};

struct Spring2D {
    Spring1D x;
    Spring1D y;

    void SetTarget(float tx, float ty) { x.target = tx; y.target = ty; }
    void SetParams(float k, float c, float m) {
        x.stiffness = y.stiffness = k;
        x.damping   = y.damping   = c;
        x.mass      = y.mass      = m;
    }
    void Update(float dt) { x.Update(dt); y.Update(dt); }
};
```

---

## 3. 3D 입체감 연출: 3축 오일러 틸트 & 동적 림라이트

2D 평면 이미지/스프라이트를 화면 밖으로 튀어나와 마우스를 쳐다보는 3D 입체물처럼 렌더링하는 기법입니다.

### ① 3축 오일러 틸트 (Pitch & Yaw 원근 투영)
마우스 위치 $(M_x, M_y)$와 펫/요소 중심점 $(C_x, C_y)$의 거리 벡터를 계산합니다:
$$\Delta x = M_x - C_x, \quad \Delta y = M_y - C_y$$
* **Yaw (좌우 고개 회전)**: $\theta_{\text{yaw}} = \text{clamp}(\Delta x \cdot 0.08^\circ, -25^\circ, +25^\circ)$
* **Pitch (위아래 끄덕임)**: $\theta_{\text{pitch}} = \text{clamp}(-\Delta y \cdot 0.08^\circ, -20^\circ, +20^\circ)$
* **스케일 압축 매핑**: 
  * $S_x = \cos(\theta_{\text{yaw}} \cdot \frac{\pi}{180})$ (고개를 돌린 방향으로 가로 폭 압축)
  * $S_y = \cos(\theta_{\text{pitch}} \cdot \frac{\pi}{180})$ (위를 쳐다볼 때 세로 높이 압축)

### ② 동적 림라이트 (Dynamic Rim Light)
* 마우스 방향으로 각도 $\alpha = \text{atan2}(\Delta y, \Delta x)$를 구합니다.
* GDI+ `LinearGradientBrush`의 각도를 $\alpha$로 실시간 동기화하여, 마우스와 마주보는 펫의 외곽선에 황금빛/순백색 하이라이트가 맺히게 합니다.

---

## 4. Verlet Integration 꼬리/지느러미 연쇄 관절 물리

꼬리가 뻣뻣한 막대기가 아니라 물고기나 가오리처럼 출렁이도록 만드는 3관절 로프 공식입니다.

```cpp
struct VerletNode {
    float x, y;
    float oldX, oldY;
};

void UpdateVerletTail(VerletNode nodes[4], float headX, float headY, float segLen, float dt) {
    nodes[0].x = headX;
    nodes[0].y = headY;

    for (int i = 1; i < 4; ++i) {
        // 1. 관성 이동 (Inertia)
        float vx = (nodes[i].x - nodes[i].oldX) * 0.92f; // 감쇠
        float vy = (nodes[i].y - nodes[i].oldY) * 0.92f;
        nodes[i].oldX = nodes[i].x;
        nodes[i].oldY = nodes[i].y;
        nodes[i].x += vx;
        nodes[i].y += vy;

        // 2. 거리 제약조건 (Distance Constraint)
        float dx = nodes[i].x - nodes[i - 1].x;
        float dy = nodes[i].y - nodes[i - 1].y;
        float dist = std::sqrt(dx * dx + dy * dy);
        if (dist > 0.001f) {
            float diff = (dist - segLen) / dist;
            nodes[i].x -= dx * diff;
            nodes[i].y -= dy * diff;
        }
    }
}
```
이 4개 노드의 좌표를 `DrawTaperedTail`의 3차 베지에 제어점($P_0, P_1, P_2, P_3$)으로 연결하면 완벽한 생체 지느러미 유영 모션이 완성됩니다.
