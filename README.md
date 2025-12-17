# BNK CARD part2P
부산은행 국비 과정의 본 프로젝트 2차(Flutter)

---

## 1. 프로젝트 개요

본 프로젝트는 **Part 1(웹 기반 기획·설계·구현)**과 **Part 2(모바일 앱 구현 중심)**로 나누어 진행된 팀 프로젝트입니다.

본 저장소는 **Part 2 (Flutter / Mobile)** 구현 내용을 중심으로 관리하며, Part 1(Web) 결과물은 별도 Git 저장소로 연결합니다.

### 전체 일정 요약

| 구분              | 기간                      | 계산 기준 총 일수 | 비고                 |
| --------------- |-------------------------| ---------- | ------------------ |
| 전체 기간           | 2025.11.06 ~ 2026.01.09 | 65일        | Part 1 + Part 2 포함 |
| Part 1 (Web)    | 2025.11.06 ~ 2025.12.08 | 30일        | 기획 · 설계 · 웹 구현     |
| Part 2 (Mobile) | 2025.12.09 ~ 2026.01.09 | 32일        | Flutter 기반 모바일 구현  |

---

## 2. 프로젝트 목표

* 기획한 기능을 **끝까지 완수**한다
* **완벽보다 완료**를 우선한다
* 팀 내 **화합과 협업**을 최우선 가치로 둔다

---

## 3. 팀 구성 및 역할

### 역할 구조 개요

* **Part 2 (Mobile)**
  | 팀원  | Part2 내 역할 및 기여                | 주요 기여 내용                                       |
  | --- | ------------------------------ | ---------------------------------------------- |
  | 이수연 | 팀장 · PM · Part2 기획 총괄 및 산출물 관리 | Part2 범위 기획 주도<br>기능 흐름 정리 및 의사결정<br>산출물 구조 관리 |
  | 박요셉 | Part2 기획 및 기능 구현 설계            | 아이디어의 기능 구조화<br>UI/UX 흐름을 기능 단위로 구체화           |
  | 박효빈 | Part2 기획 및 데이터 구조 설계           | 기능 요구사항 기반 테이블 설계                              |
  | 한탁원 | 기술 고문 (Technical Advisor)      | 테이블 설계 검토 및 컨펌<br>기술적 타당성 검증                   |
  | 고정현 | 인증·계정 기능 구현 담당                 | 로그인 기능 구현<br>회원정보 찾기 기능 구현                     |

---

## 4. 기술 스택

### Part 1 – Web (기획 · 설계 · 구현)

| 구분           | 기술                   |
| ------------ |----------------------|
| Language     | Java, JavaScript     |
| Backend      | Spring, Spring Boot  |
| Frontend     | Web (HTML/CSS/JS 기반) |
| Database     | Oracle (SQL)         |
| Architecture | MVC, REST API        |

### Part 2 – Mobile (구현 중심)

| 구분               | 기술                     |
| ---------------- | ---------------------- |
| Client           | Flutter                |
| State Management | Provider               |
| Backend          | Spring Boot (REST API) |
| Database         | Oracle (SQL)           |
| Communication    | JSON 기반 API 통신         |

---

## 5. 협업 툴

| 도구                       | 용도                   |
| ------------------------ | -------------------- |
| KakaoTalk / Slack        | 실시간 커뮤니케이션           |
| Notion                   | 진행 현황, 역할 분담, 회의록 관리 |
| Google Sheet             | 엑셀 기반 문서 관리          |
| Figma Jam / Figma Design | UI/UX 시안 및 디자인 협업    |

---

## 6. 프로젝트 구조 (Flutter)

```text
lib/
├─ config/        # 환경 설정, 상수, 공통 설정
├─ models/        # 데이터 모델 (DTO)
├─ providers/     # 상태 관리 (Provider)
├─ services/      # API 통신 및 비즈니스 로직
├─ screens/       # 화면(UI) 단위 위젯
└─ main.dart      # 앱 시작 지점
```

### 구조 설계 기준

* **UI / 상태 / 로직 분리**를 명확히 한다
* API 통신 로직은 `services`에서만 처리한다
* 화면은 `screens` 기준으로 기능 단위 분리한다

---

### 주요 산출물

| 구분         | 내용                 |
| ---------- |--------------------|
| 요구사항 정의서   | 회원 · 관리자 기능 정의     |
| 기능 명세서     | 기능별 상세 동작 정의     |
| 정보 구조도(IA) | 웹 화면 구조, 모바일 화면 구조 |
| ERD        | 데이터베이스 관계 설계       |
| 화면 설계서     | 모바일(My Page) 중     |

🔗 **Part 1 Web Git Repository**: *(추후 링크 추가)*

---

## 7. 진행 원칙

* 기능 단위로 명확한 역할 분담
* 변경 사항은 즉시 공유
* 일정 지연 시 팀 내 협의 후 조정
* 개인 완성도보다 **팀 결과물 우선**

---

## 8. 참고 사항

* 본 저장소는 **학습 및 포트폴리오 공개 목적**으로 관리됩니다.
* 일부 기능은 시연 또는 구조 구현에 초점을 맞추었습니다.

---
---



## (참고 / 2차 폴더 구조는 변동성 있음, 1차는 변동 없음.)
```text
lib/
├─ config/
│  ├─ api_config.dart     // API 기본 URL, 키 등
│  ├─ route_config.dart   // 라우트 이름 정의
│  └─ theme_config.dart   // 공통 테마 정의
│
├─ models/
│  ├─ user.dart           // 사용자 정보 모델
│  ├─ account.dart        // 계좌 정보 모델
│  ├─ benefit.dart        // 혜택 정보 모델
│  └─ chat_message.dart   // 챗봇 메시지 모델
│
├─ providers/
│  ├─ auth/               // 인증 관련 상태
│  │  └─ auth_provider.dart
│  ├─ benefit/            // 혜택 관련 상태
│  │  └─ benefit_provider.dart
│  └─ chatbot/            // 챗봇 관련 상태
│     └─ chatbot_provider.dart
│
├─ services/
│  ├─ auth/               // 로그인, 회원가입 등 인증 로직
│  │  └─ auth_service.dart
│  ├─ payment/            // 결제, 계좌 관리 등 로직
│  │  └─ payment_service.dart
│  ├─ benefit/            // 혜택 데이터 처리 로직
│  │  └─ benefit_service.dart
│  └─ chatbot/            // 챗봇과의 통신 및 처리 로직
│     └─ chatbot_service.dart
│
├─ screens/
│  ├─ auth/               // 인증 관련 화면
│  │  ├─ login_screen.dart
│  │  └─ find_pw_screen.dart
│  │
│  ├─ mypage/             // 마이페이지 관련 화면
│  │  └─ mypage_screen.dart
│  │
│  ├─ payment/            // 결제 계좌 관리 화면
│  │  ├─ account_register_screen.dart
│  │  └─ account_edit_screen.dart
│  │
│  ├─ benefit/            // 혜택 상세 화면
│  │  ├─ benefit_summary_screen.dart
│  │  └─ benefit_monthly_screen.dart
│  │
│  ├─ map/                // 지도 관련 화면
│  │  └─ payment_map_screen.dart
│  │
│  └─ chatbot/            // 챗봇 화면
│     └─ chatbot_screen.dart
│
└─ main.dart# BNK_Wave_Part2
```
