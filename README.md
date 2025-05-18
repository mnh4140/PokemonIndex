# 포켓몬 도감 앱

## 📋 프로젝트 개요
pokemon API 를 이용한 포켓몬 도감 앱 개발
- 프로젝트 명 : Pokemon Index
- 프로젝트 기간 : 2025.05.09 ~ 2025.05.18
---

## 🛠️ 기술 스택
- Language : Swift
- IDE : Xcode
- 버전 : iOS 16
- 라이브러리 : SnapKit, RxSwift
- 네트워크 : URLSession
- 사용 API : Kakao Rest API (도서 검색)
- UI 구현 : UIKit
- 아키텍처 : MVVM
- 디자인 패턴 : Delegate 패턴, 싱글턴 패턴, 옵저버 패턴
- 형상 관리 : Github
- 스크럼 및 마일스톤 : Notion

---

## 📱 주요 기능
### 1. 포켓몬 리스트 보기
- pokemon Rest API 를 이용하여 포켓몬 이미지를 사용하며 도감 목록을 표현
### 2. 포켓몬 상세 보기
- 특정 포켓몬을 클릭 시, 상세 페이지를 보여줌
### 3. 무한 스크롤
- 스크롤을 아래로 당기면 포켓몬 도감 목록을 업데이트하여, 포켓못 리스트를 보여줌
---

## 📋 커밋 컨벤션 (PR 시 동일하게 적용)
- Commit Message 규칙
  - 💡 [Issue 종류] #Issue 번호 - 한 줄 정리
    - 예시) [Feat] #22 - 탭바 추가

---

## 📌 브렌치 룰 & 전략
- 브랜치 전략
    - github flow를 따르되, main과 개인 작업 브랜치 사이에 Develop를 만들어서 좀 더 안전하게 공동작업을 보호.
        - main: Develop 브랜치에서 하나의 Issue에 생성된 브랜치가 안전하게 머지 되었을 때 푸시
        - Develop: 새로운 Issue가 완료되었을 때 푸시 앤 머지
        - Issue 할당 브랜치: 개인 작업용
        
- 브랜치 네이밍
    - 이슈 종류/#이슈 번호
 
---

## 📦 설치 및 실행 방법
- 이 저장소를 클론
  ```bash
  https://github.com/mnh4140/PokemonIndex.git
  ```
- Xcode로 프로젝트 파일을 실행 후 빌드!
