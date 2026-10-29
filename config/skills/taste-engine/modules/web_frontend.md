# 🌐 Domain 2: 안티-슬롭 웹 & Image-to-Code 엔진 (Web-Frontend)

이 모듈은 `Leonxlnx/taste-skill`, `pbakaus/impeccable`, 그리고 `image-to-code`의 핵심 철학을 통합하여, AI가 웹 프론트엔드 코드를 작성할 때 뻔한 보일러플레이트를 탈피하고 세계적 수준의 마감을 보장하도록 강제합니다.

---

## 1. 안티-슬롭 7대 절대 금지 규칙 (Anti-Slop Web Rules)

1. **보라/청록 네온 그라데이션 금지**: 
   * `bg-gradient-to-r from-purple-600 to-indigo-600` 같은 전형적인 AI 웹 템플릿 색상을 사용하지 않습니다.
   * `tokens.json`에 정의된 깊이 있는 매트 캔버스(`neutral_canvas: #0D0F12`)와 절제된 테라코타/골드 악센트만 사용합니다.
2. **단조로운 3단 피처 카드 금지**:
   * 페이지 중앙에 똑같은 사각형 3개를 나란히 놓고 아이콘 하나씩 얹는 구조를 지양합니다.
   * 비대칭 그리드(Bento Grid), 시각적 밀도 차등(Primary vs Secondary Card), 디테일한 메타데이터 리스트를 활용합니다.
3. **붕 뜬 여백 & 애매한 정렬 금지**:
   * 무의미한 `my-24` 같은 과도한 여백 남발 금지.
   * 모든 여백은 4px / 8px 배수(8, 16, 24, 32, 48px) 그리드 시스템에 정밀하게 스냅(Snap)되어야 합니다.
4. **유행 지난 흐리멍텅한 글래스모피즘(Glassmorphism) 금지**:
   * 글자가 안 보일 정도로 투명한 `bg-white/10 backdrop-blur` 남발을 금지하고, 1px의 정교한 헤어라인 테두리(`border border-[#252B35]`)로 엣지를 살립니다.
5. **텍스트 대비(WCAG AA) 미달 금지**:
   * 본문 텍스트와 배경 간 명도 대비는 무조건 **4.5:1 이상**을 유지합니다. 흐릿한 회색 텍스트로 가독성을 해치는 행위를 엄단합니다.
6. **기계적 인터랙션 금지**:
   * 단순 `transition: all 0.2s` 대신 스프링 물리 기반 이징이나 마우스 오버 시 미세한 스케일(`hover:scale-[1.015]`), 림라이트 변화를 부여합니다.
7. **하드코딩 폰트/스타일 파편화 금지**:
   * 프로젝트 전반에서 `tokens.json`의 타이포 스케일(caption ~ display)을 일관되게 상속합니다.

---

## 2. Image-to-Code 정밀 역설계 지침

사용자가 핀터레스트, 드리블, 혹은 특정 웹사이트의 캡처 스크린샷을 제공하며 코드로 구현해달라고 요청할 때, 다음 4단계 프로토콜을 수행합니다:

```
[1. 비주얼 박스 분해] ──> [2. 토큰 역산출] ──> [3. 시맨틱 마크업] ──> [4. 마이크로 인터랙션 주입]
```

1. **비주얼 박스 분해 (Spatial Decomposition)**:
   * 이미지의 바운딩 박스를 계층별(Header, Hero Section, Bento Grid, Floating Controls)로 먼저 분석합니다.
   * 요소 간의 실제 여백 비율(Padding vs Gap)을 8px 그리드 단위로 환산합니다.
2. **토큰 역산출 (Token Extraction)**:
   * 이미지에 쓰인 가장 두드러진 키 컬러(Key Accent)와 배경 톤을 스포이드로 추출하듯 16진수(`hex`) 코드로 매핑합니다.
   * 타이포그래피의 계층(Display, Title, Body, Caption)과 두께(Weight: 400 vs 600 vs 700)를 역산출합니다.
3. **시맨틱 마크업 & Tailwind 구현**:
   * Flexbox와 CSS Grid(`grid-cols-1 md:grid-cols-12`)를 적절히 배합하여 모바일/데스크톱 완벽 반응형 구조를 도출합니다.
4. **마이크로 인터랙션 주입 (Impeccable Polish)**:
   * 정적인 코드에 Emil Kowalski식 스프링 모션(`tokens.json/physics`)과 호버 반응을 주입하여 살아있는 웹으로 완성합니다.

---

## 3. 2026 모던 웹 표준 기술 연계

* **View Transitions API**: 페이지 전환 시 뚝 끊기지 않고 공유 요소(Shared Element)가 부드럽게 유영하도록 지원.
* **Scroll-driven Animations**: 자바스크립트 스크롤 이벤트 리스너 없이 순수 CSS(`animation-timeline: scroll()`)로 60fps 무지연 패럴랙스 구현.
* **Container Queries**: 뷰포트 크기가 아니라 부모 컴포넌트 크기에 따라 자율 반응하는 진정한 모듈형 UI 작성.
