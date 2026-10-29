# 🚀 Antigravity Starter Kit (안티그래비티 초보자용 스타터 팩)

안티그래비티(Google Antigravity)를 처음 설치한 사람을 위한 **Zero-Setup(추가 설치 0개) 공식 설정 팩**입니다.  
복잡한 파이썬 가상환경, Node 패키지 빌드, 외부 API 키 발급 없이 **설치 즉시 상용 수준의 AI 코딩 어시스턴트 환경**으로 업그레이드됩니다.

---

## 📦 포함된 구성 요소

### 1. 🎯 글로벌 시스템 규칙 (`GEMINI.md`)
- **정중하고 명확한 한국어 기술 존댓말** (하십시오체/해요체) 기본 탑재
- **위험 명령어 차단 가드레일**: `rm -rf`, `Format-Volume`, `git reset --hard`, `git push --force` 등 파괴적 명령 자동 차단
- **YAGNI & 외과수술적 코딩 원칙**: 불필요한 보일러플레이트, 오버엔지니어링, 무관한 코드 임의 수정 전면 차단
- **체계적 인지 프로세스**: `[현상/원인 분석] -> [조치 내용] -> [검증/다음 단계]` 순서의 직관적 피드백

### 2. ⚡ Zero-Setup 핵심 스킬 (7종)
어떤 추가 설치도 없이 대화창에서 슬래시(`/`) 명령이나 키워드로 즉시 호출할 수 있습니다.

| 스킬명 | 호출 명령어 | 주요 기능 |
| :--- | :--- | :--- |
| **`caveman`** | `/caveman` | 불필요한 미사여구를 제거하고 핵심 코드와 사실만 출력하여 토큰 60% 절약 |
| **`ponytail`** | `/ponytail` | 오버엔지니어링·불필요한 래퍼 함수를 제거하는 시니어 개발자 수준 코드 다이어트 |
| **`taste-engine`** | `/design` | 촌스러운 AI 기본 스타일(AI Slop)을 배제하고 상용급 UI/모션/디자인 적용 |
| **`ui-ux-pro-max`** | `/uipro` | 전문가 수준의 컬러 팔레트, 타이포그래피 계층, WCAG 접근성 가이드라인 주입 |
| **`handoff`** | `/handoff` | 긴 세션을 정리하고 다음 채팅이나 다른 모델이 바로 이어받을 수 있는 인수인계 문서 생성 |
| **`workflow_skill_creator`** | "이 작업 스킬로 만들어줘" | 방금 성공한 복잡한 작업을 다음에도 쓸 수 있는 나만의 커스텀 스킬로 자동 추출 |
| **`credentials`** | 자동 발동 | API 키나 시크릿 정보가 코드나 대화 로그에 유출되지 않도록 안전 보호 |

### 3. 🛡️ 플랫폼 설정 템플릿 (`config.json`)
- 아이보리/슬레이트 톤의 가독성 높은 라이트 테마
- 명령 자동 실행 최적화 정책
- OS 핵심 디렉터리 및 중요 파일 보호 필터 기본 적용

---

## 💻 신규 사용자를 위한 설치 순서 (3단계)

### 1단계: 터미널 열기
- **Windows**: `Win + X` 누른 후 **PowerShell** 또는 **터미널** 실행
- **macOS / Linux**: **Terminal** 실행

### 2단계: 저장소 클론 및 자동 설치 실행

#### Windows (PowerShell):
```powershell
git clone https://github.com/sihyun19/antigravity-starter-kit.git
cd antigravity-starter-kit
.\install.ps1
```

#### macOS / Linux:
```bash
git clone https://github.com/sihyun19/antigravity-starter-kit.git
cd antigravity-starter-kit
chmod +x install.sh
./install.sh
```

> **안전 보장**: 기존에 작성해둔 설정 파일이 있다면 `~/.gemini/backup_날짜` 폴더로 자동 백업된 후 안전하게 복사됩니다.

### 3단계: 안티그래비티 앱 재시작
안티그래비티를 완전히 종료했다가 다시 실행(또는 창 새로고침)합니다.

---

## 🎮 설치 후 바로 테스트해보기!

새 대화창을 열고 다음과 같이 입력해보세요:

1. **간결 모드 테스트**:
   > `/caveman 파이썬으로 현재 날짜 출력하는 코드 보여줘`
   > ➜ 군더더기 없는 초압축 답변 확인
2. **시니어 코드 리뷰 테스트**:
   > `/ponytail 이 함수 오버엔지니어링 된 부분 다이어트해줘`
3. **UI 디자인 모드 테스트**:
   > `/uipro 로그인 화면 깔끔하게 만들어줘`
4. **세션 정리 테스트**:
   > `/handoff 지금까지 진행 상황을 다음 작업자를 위해 정리해줘`
