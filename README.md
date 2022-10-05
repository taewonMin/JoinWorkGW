# JoinWorkGW
> 그룹웨어 프로젝트
   
실제 상용화되고 있는 그룹웨어 프로그램을 참고하여 기획하고 여러 기능을 추가하여 만들었습니다.

- 대시보드에서 사용자가 원하는 요약 테마를 선택하여 표시할 수 있습니다.
   
- 결재자 부재시 결재 권한을 위임하여 대결, 전결 처리를 할 수 있고 QR코드를 이용하여 모바일 결재를 할 수 있습니다.
   
- 업무 중 발생한 이슈를 공유하고 진행중인 이슈를 칸반 보드로 간단하게 확인할 수 있습니다.
   
   
## 개발 환경 & 사용 기술

#### 1. Tool
- eGovFrameWork 3.9
- Sql Developer 4.0
- maven 4.0

#### 2. Server (WAS)
- Apache Tomcat 8.5

#### 3. Language & Framework
- Java 1.8
- JSP 2.3
- Spring 4.2.3

#### 4. DB
- Oracle 11g XE

#### 5. 외부 API
- 카카오톡 메시지 - 모바일 전자 결재 메시지 전송
- ZXing - QR 출퇴근
- FullCalendar - 일정 관리
- OrgChart - 조직도
- JXLS, POI - 엑셀 다운로드

#### 6. ERD 설계
> https://www.erdcloud.com/d/zupWEWNb6JhpWzxsd
   
## 기능 소개
### 1. 대시보드
> 사용자별 커스텀 대시보드를 설정할 수 있습니다.
   
![image](https://user-images.githubusercontent.com/37923543/192958981-9ec6896b-d816-4ef7-876f-f077a5d96f77.png)

### 2. 업무관리
> 진행중인 업무를 조회하거나 새 업무를 지시할 수 있습니다. 
   
![image](https://user-images.githubusercontent.com/37923543/192960907-7f7c29ff-4b3a-43c3-a40a-176456096a73.png)

### 3. 이슈관리
> 업무 중 발생한 이슈를 공유하고 칸반 보드로 이슈를 관리할 수 있습니다.
   
![image](https://user-images.githubusercontent.com/37923543/192963961-0d3e38e8-ac40-433a-b1bd-0259a977d9b5.png)

### 4. 전자결재
> 자주 사용하는 양식과 결재 목록을 확인할 수 있고 새 결재를 진행할 수 있습니다.

![image](https://user-images.githubusercontent.com/37923543/192981511-d8873885-ebdd-45bb-8773-964c0900e240.png)

### 5. 시설예약
> 회의실의 예약 일정을 확인할 수 있습니다.

![image](https://user-images.githubusercontent.com/37923543/192982569-9c71f582-2652-4294-a9c7-2564cd72d480.png)

### 6. 일정관리
> 일정을 등록, 조회할 수 있고 중요 일정으로 변경할 수 있습니다.

![image](https://user-images.githubusercontent.com/37923543/192982861-2b0289a6-02a4-4e48-9fd1-092a25ac81f5.png)

### 7. 근태관리
> 월별 개인 또는 부서별 근태 통계를 확인할 수 있습니다.

![image](https://user-images.githubusercontent.com/37923543/192983243-e4bfc5de-9f1f-40e8-a579-c4fa6775c954.png)

### 8. 관리자 페이지
> 관리자는 새 직원, 직급, 부서를 추가하거나 각종 홈페이지 설정을 관리합니다.

![image](https://user-images.githubusercontent.com/37923543/192984078-7cc6588f-88e3-4cb8-9ec1-e517929c5d97.png)
   
   
## 담당 기능
> 해당 기능의 UI부터 비즈니스 로직을 포함한 백엔드까지 구현했습니다.
- 대시보드
  - 사용자 대시보드
  - 관리자 대시보드
  
- 업무관리 📌 [코드 보기](https://github.com/taewonMin/JoinWorkGW/tree/main/JoinWorkGW/src/main/java/com/joinwork/board/duty)
  - 새 업무 등록
  - 수신, 송신, 참조 업무 목록 조회
  - 첨부파일 업/다운로드
  
- 이슈관리 📌 [코드 보기](https://github.com/taewonMin/JoinWorkGW/tree/main/JoinWorkGW/src/main/java/com/joinwork/board/issue)
  - 새 이슈 등록
  - Open, Closed 이슈 목록 조회
  - 이슈 상태 변경
  - 관련 업무 번호 및 마일스톤 연결
  - 새 마일스톤 생성 및 조회, 수정
  - 칸반 보드로 이슈 관리
  
- 알림 📌 [코드 보기](https://github.com/taewonMin/JoinWorkGW/blob/main/JoinWorkGW/src/main/java/com/joinwork/common/controller/CommonController.java)
  - 업무 수신자로 등록 및 업무 삭제시 알림
  - 소속 부서 일정 추가시 알림
  - 관리자 메시지 수신시 알림
  
- 공지 게시판 📌 [코드 보기](https://github.com/taewonMin/JoinWorkGW/tree/main/JoinWorkGW/src/main/java/com/joinwork/board/notice)
  - 글 등록, 수정, 삭제, 목록 및 상세 페이지 조회
  
- 관리자 메시지 송수신 📌 [코드 보기](https://github.com/taewonMin/JoinWorkGW/blob/main/JoinWorkGW/src/main/java/com/joinwork/util/EchoHandler.java)
  - WebSocketSession으로 로그인된 사용자 관리
  - 실시간 메시지 전송
  
- Interceptor 설정 📌 [코드 보기](https://github.com/taewonMin/JoinWorkGW/tree/main/JoinWorkGW/src/main/java/com/joinwork/util/interceptor)
  - 로그인 체크
  - 관리자 로그인 체크
  - 로그인시 로그 파일 쓰기

- Exception 처리 📌 [코드 보기](https://github.com/taewonMin/JoinWorkGW/blob/main/JoinWorkGW/src/main/java/com/joinwork/util/ExceptionControllerAdvisor.java)
  - ExceptionHandler로 예외 처리
  - 에러 로그 파일 쓰기
