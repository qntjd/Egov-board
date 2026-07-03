# 📋 eGovFramework 기반 게시판 시스템

> 전자정부 표준 프레임워크(eGovFramework) 3.9를 활용한 회원관리 및 게시판 웹 애플리케이션

<br>

## 🔗 기술 스택

| 구분 | 기술 |
|------|------|
| **Framework** | eGovFramework 3.9, Spring 4.3.22 |
| **Language** | Java 1.8 |
| **Build** | Maven |
| **WAS** | Apache Tomcat 8.5 |
| **DB** | CUBRID 10.2 |
| **ORM** | MyBatis |
| **Security** | Spring Security 4.2.3, BCrypt |
| **View** | JSP, JSTL |
| **IDE** | Eclipse (Windows) |

<br>

## ✅ 구현 기능

### 회원 관리
- 회원가입 (아이디 중복확인 Ajax — async/await + JSON 응답)
- BCrypt를 활용한 비밀번호 암호화 (서비스 계층에서 처리)
- Spring Security 기반 로그인/로그아웃
- 로그인 실패 횟수 제한 및 계정 잠금 처리
- 권한/활성화 상태(`ROLE_USER`, `userEnabled`) 코드 기반 명시적 관리

### 게시판
- 게시글 CRUD (목록, 등록, 상세, 수정, 삭제)
- 파일 첨부 (eGov `EgovFileMngService` / `EgovFileMngUtil` 활용, `MultiSelector` 패턴)

### 댓글
- 댓글 등록 / 삭제
- 비밀댓글 (BCrypt 비밀번호 검증)

<br>

## 🏗 프로젝트 구조

```
src/main/java
├── boardApp.web              # Controller
├── boardApp.service          # Service 인터페이스
├── boardApp.service.impl     # Service 구현체
├── boardApp.mapper           # MyBatis Mapper 인터페이스
├── boardApp.VO               # Value Object (UserVO, BoardVO, CommentVO ...)
├── boardApp.security         # Spring Security 설정
│   ├── CustomAuthenticationProvider
│   ├── CustomUserDetailsService
│   └── UserDetailsImpl       # UserDetails 어댑터 (UserVO 분리)
└── boardApp.exception        # GlobalExceptionHandler (@ControllerAdvice)
```

<br>

## 🔐 Spring Security 적용 포인트

UserVO가 직접 `UserDetails`를 구현하면 도메인 객체에 Security 의존성이 생기는 문제가 있어, **어댑터 패턴**으로 `UserDetailsImpl`을 별도로 분리했습니다.

```
UserVO (도메인) ──────────> UserDetailsImpl (어댑터) ──> Spring Security
  userId, userPw,               UserVO를 감싸서
  userAuthority, userEnabled    UserDetails 인터페이스 구현
```

이를 통해 도메인 객체와 Security 로직의 결합도를 낮추고, 각 클래스의 단일 책임을 유지했습니다.

<br>


## 🛠 로컬 실행 방법

### 사전 조건
- JDK 1.8
- Apache Tomcat 8.5
- CUBRID 10.2
- Maven

### 설정

```bash
# 1. 저장소 클론
git clone https://github.com/[본인아이디]/egov-board.git

# 2. globals.properties 설정
# src/main/resources/egovframework/egovProps/globals.properties.template을 복사해
# globals.properties로 이름 변경 후 아래 값 입력
# - Globals.cubrid.Url
# - Globals.cubrid.UserName / Password
# - coolsms.api.key / api.secret / from.number (SMS 기능 사용 시)

# 3. Maven 빌드
mvn clean install

# 4. Tomcat에 배포 후 실행
```

### DB 초기화

CUBRID에서 아래 순서로 테이블 생성:
```
tb_user → tb_board → tb_file → tb_comment
```
> DDL 스크립트: `src/main/resources/sql/ddl.sql` *(준비 중)*



