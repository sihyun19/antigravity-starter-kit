# 🖼️ Domain 1: AI 이미지 생성 & 하이브리드 그래픽 엔진 (Image-Gen)

이 모듈은 AI가 생성한 이미지 특유의 '인공적인 냄새(AI Slop)'를 원천 차단하고, 상업적 품질의 고해상도 그래픽(카드뉴스, 광고 배너, 포스터, SVG)을 완성하기 위한 표준 파이프라인을 정의합니다.

---

## 1. 안티-AI 프롬프트 매트릭스 (Anti-Slop Matrix)

AI 이미지 생성 모델(Imagen, Midjourney, Flux, Stable Diffusion 등)에 프롬프트를 전달할 때 아래 규칙을 무조건 강제합니다.

### 🚫 절대 금지어 (Negative Keywords & Patterns)
* **질감**: `plastic skin, excessive skin smoothing, synthetic porcelain sheen, wax figure, CGI render look, unreal engine 5 bloom`
* **조명**: `cliché purple-cyan neon glow, saturated golden backlight, overdone lens flare, volumetric neon fog`
* **구도/포즈**: `generic centered stock photo, lifeless mannequin pose, floating random particles`
* **기본값 렌더링**: `3d render, octane render, trending on artstation` (전형적인 2022~2023년식 AI 슬롭 유발어)

### ✨ 필수 주입 지침 (Positive Directives)
* **카메라 & 렌즈**: `shot on 35mm f/2.4 or 50mm prime lens, natural optical depth of field, subtle film grain`
* **조명**: `diffused natural morning window light, directional soft daylight, organic shadows, true matte surfaces`
* **색채**: `tokens.json`의 `prompt_desc`에 기술된 색상 팔레트 직접 주입 (`deep obsidian matte canvas`, `muted warm terracotta`)
* **현실감 디테일**: `authentic surface imperfection, subtle environmental dust, tactile fabric texture, human skin micro-texture`

---

## 2. 하이브리드 상업 그래픽 파이프라인 (카드뉴스/배너/포스터)

> [!IMPORTANT]
> **순수 Diffusion 모델에게 텍스트(한글)나 정확한 그리드 배치를 직접 쓰게 하지 마십시오.**
> 상업용 그래픽은 100% **"AI 일러스트/배경 + HTML/CSS 타이포그래피 + Headless 캡처"** 하이브리드 방식으로 제작합니다.

```
[1. AI 배경/일러스트 생성] 
       │
       ▼
[2. OpenCV 여백(Negative Space) 탐지] ───> 텍스트를 배치할 안전 구역(Bounding Box) 좌표 추출
       │
       ▼
[3. HTML/CSS 타이포그래피 오버레이] ───> tokens.json 폰트/색상으로 칼같은 정렬 및 레이아웃
       │
       ▼
[4. Headless 브라우저 캡처 (Chrome DevTools / Playwright)]
       │
       ▼
[5. 무손실 고해상도 상업용 이미지 (PNG/SVG) 최종 출력]
```

### 텍스트 안전 구역 감지 원칙 (Negative Space Detection)
1. 이미지가 생성되면 이미지 렌더링 상태를 확인하여 명도와 복잡도(Edge Density)를 분석합니다.
2. 텍스트가 얹힐 영역의 복잡도가 높을 경우:
   * 이미지 자체를 다시 생성하거나,
   * CSS `backdrop-filter: blur(12px)` 또는 정교한 `LinearGradient` 딤드(Dimmed) 레이어를 자동으로 삽입하여 **WCAG 명도 대비 4.5:1 이상**을 보장합니다.

---

## 3. 실행 템플릿: HTML-to-Image 래퍼

상업용 배너나 카드뉴스 생성 시 아래 구조의 HTML/Tailwind 템플릿을 바탕으로 렌더링을 수행합니다:

```html
<!DOCTYPE html>
<html>
<head>
  <style>
    body { margin: 0; width: 1080px; height: 1080px; overflow: hidden; background: #0D0F12; font-family: system-ui, sans-serif; }
    .canvas { position: relative; width: 1080px; height: 1080px; }
    .bg-layer { position: absolute; inset: 0; width: 100%; height: 100%; object-fit: cover; }
    .scrim { position: absolute; inset: 0; background: linear-gradient(to top, rgba(13,15,18,0.92) 0%, rgba(13,15,18,0.3) 50%, transparent 100%); }
    .content-layer { position: absolute; bottom: 80px; left: 80px; right: 80px; z-index: 10; }
    .tag { display: inline-block; padding: 6px 14px; background: rgba(224,90,71,0.18); color: #E05A47; border: 1px solid rgba(224,90,71,0.35); border-radius: 9999px; font-size: 14px; font-weight: 600; text-transform: uppercase; letter-spacing: 0.05em; }
    h1 { color: #F0F4F8; font-size: 48px; line-height: 1.15; margin: 16px 0 12px; font-weight: 700; letter-spacing: -0.02em; }
    p { color: #8C9BAE; font-size: 20px; line-height: 1.5; margin: 0; max-width: 800px; }
  </style>
</head>
<body>
  <div class="canvas">
    <img src="ai_generated_background.png" class="bg-layer" />
    <div class="scrim"></div>
    <div class="content-layer">
      <span class="tag">Release Note</span>
      <h1>새로운 차원의 데스크톱 모션 엔진</h1>
      <p>질량과 감쇠 물리 기반의 자연스러운 생동감을 경험하십시오.</p>
    </div>
  </div>
</body>
</html>
```
이 템플릿을 `chrome-devtools` 또는 Playwright로 캡처하여 **1080x1080 정사각형 고화질 카드뉴스 PNG**로 즉시 배포합니다.
