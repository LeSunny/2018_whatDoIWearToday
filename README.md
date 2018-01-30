1. 힘들어도 게속 열심히 할 것
   알바, 다른 공부 외의 시간은 모두 여기에 쏟자

[일정]
~1월 중순 : 기획, 예제문제 완성
		Java의 Spring 환경
~2월 말 : 70~80%
개학 : 흐름대로
~5월 : 90%

[큰 그림]
IoT(사물인터넷) 플랫폼

============================================================

<1월 중순>
1. 기본 실력
* http://addio3305.tistory.com/ 로 기본 플랫폼 구현
Java Spring 환경에 대한 설명
이해가 중요!
* Spring이 뭔지, 일반적인 platform 을 만들면서 최소한의 수준을 충족 시키기
* 예지 문제를 풀면서 실력 향상, 기능의 변형이나 추가에 대한 task가 있을 수 있음

2. 기획
IoT에 대한 대략적인 이해 필요


============================================================
[Review]
<17-12-14>
1. Spring개발 입문사이트
	http://addio3305.tistory.com/category/Spring?page=2
        - 개발환경구축
        - 스프링프로젝트생성
        - 스프링MVC구조
        - 로그(Log4j), 인터셉터(Interceptor)
        - Mybatis연동
        - 게시판: 목록, 상세, 등록 기능구현
        - 파일 upload/download
        - AOP 설정
        - 페이징 by 전자정부프레임워크
        - 페이징 by jQuery/Ajax



<17-12-18>
1. ActiveMQ : IOT protocol
	http://activemq.apache.org/

2. ActiveMQ예제
	https://examples.javacodegeeks.com/enterprise-java/jms/apache-activemq-hello-world-example/



<17-12-21>
1. ActiveMQ예제를 이클립스에서 2개 독립프로젝트로 실행
     - 1개프로젝트(메시지생성-등록), 1개프로젝트(메시지수신-처리)
     - 별도로 ActiveMQ 브로커(메시지서버)가 백그라운드에서 실행됨
	https://examples.javacodegeeks.com/enterprise-java/jms/apache-activemq-hello-world-example/

2. 서울시 대중버스 시스템을 모델링하여 다음과 같이 시뮬레이션
   프로그램 작성
     - 서울시 대중교통시스템전용 ActiveMQ 브로커(메시지서버) 실행
     - 이클립스 프로젝트(KookminBusInformation) -> 국민대 정문 버스정류장 안내시스템 구현
                                                   위치정보구독 by receiving MQTT message
     - 이클립스 프로젝트(BusLocationNode) -> 3개노선(7211, 153, 110B) 각각 2개 쓰레드로 
                                             실시간위치정보 Publish by sending MQTT message


============================================================
[Homework / Review]

<17-12-15>
(12-18)
* http://addio3305.tistory.com/category/Spring (1),(2),(3) 읽고 해보기
* IoT에 대한 조사 해오기

Tomcat : 
Maven : 어떤 라이브러리를 사용하고 싶을 때 그 라이브러리를 자동으로 찾아줌
STS : Spring Tool Suit / 이클립스에서 spring을 사용할 수 있게 해줌
SVN : 여러명의 개발자가 함께 하는 프로젝트일 경우 꼭 필요
JSDT : jQuery는 이클립스 내에서 코드 어시스트 기능을 사용할 수 있게 해줌

<17-12-18>
(12-21)
* http://addio3305.tistory.com/category/Spring (4),(5),(6) 읽고 해보기
* http://activemq.apache.org/mqtt.html 사이트에서,
윈도우 버전으로 activemq 서버프로그램을 다운받아
ActiveMQ가 서버로 동작하니 서버프로그램을 실행해 이클립스 버전으로 테스트 해보자
(코드가 인터넷 상에 많이 떠돌아 다님)
* Subscribe/Publish 모델 (= 데이터교환 모델) 위에서 돌아가는 프로토콜에 대한 조사

<17-12-21>
(17-12-26)
* http://addio3305.tistory.com/category/Spring (7),(8),(9),(10) 읽고 해보기
 (spring(9)부터 DB는 Oracle이 아닌 MySQL로 할 것)
* ActiveMQ
=>  서울시 대중버스 시스템을 모델링하여 다음과 같이 시뮬레이션
   프로그램 작성
     - 서울시 대중교통시스템전용 ActiveMQ 브로커(메시지서버) 실행
     - 이클립스 프로젝트(KookminBusInformation) -> 국민대 정문 버스정류장 안내시스템 구현
                                                   위치정보구독 by receiving MQTT message
     - 이클립스 프로젝트(BusLocationNode) -> 3개노선(7211, 153, 110B) 각각 2개 쓰레드로 
                                             실시간위치정보 Publish by sending MQTT message
<12-26>
(12-28)
* spring (10) 마저 해오기
* 서울시 버스 시스템 프로그래밍 해오기

<12-28>
(1-2)
1. 본인의 스마트폰을 포함하여 3가지 폰이 가지고 있는 센서의 종류에
   대하여 조사하라.
=> Galaxy S7, Iphone 6S, Galaxy Tab

2. 대표적인 안드로이드앱 프로그램 개발환경인 Android Studio(IntelliJ기반)을
   설치하고 HelloWorld앱프로그램을 본인의 스마트폰에서 실행하도록 하라.
=> PC에서 안드로이드 스튜디오로 만든다음에 유선으로 메뉴를 누르면 다운로드가 됨!

3. 본인의 스마트폰이 가지고 있는 모든 센서의 동작여부를 확인하는
   앱을 구현하고 데모하라.

* http://addio3305.tistory.com/category/Spring (11),(12) 읽고 해보기
* 서울시 버스 시스템 보완해보기

<1-2>
(1-4)
* 15페이지까지
* spring -> 앞으로 5월까지 할 것
사용자 개념 추가 -> 로그인 기능, 게시물에 게시자 표시
SNS와 연동
* 2,3번 마저

<1-4>
(1-8)
* 앞으로 할 IoT 플랫폼 기획내용 -- 스마트폰의 어떤 센서를 특성화 시킨 것
* 180104 폴더 안, 더 나은 시스템 아키텍쳐를 찾아오기


<1-8>
(1-11)
* 프로그램구조토론 3 완성

<1-11>
(1-15)
* 프로그램구조토론 4 완성
* 스마트폰의 GPS 센서 3일간 테스트 하기
* 만들 것 다시 생각해보기

<1-15>
(1-17)
* 서비스 다시 구상
* user table 생각해 올것. 어떤 열? 어떤 타입? -> 완성하진 못해도 중간과정 발표할 것

<1-17>
(1-25)
* 기획한 것 스토리보드 완성
* user table 보완하기

<1-25>
* Singleton(bean) : 객체의 생성은 한번만 하고 요청이 있을때마다 주소값을 알려주어 메모리 소모를 줄이고 속도를 높인다. getBean()
* AOP : 모든 서비스 로직에선 인증(예) proxy를 거쳐야 해당 DAO로 접근할 수 있도록 한다. 새로운 코드를 추가했을 때 원래 코드를 건들이지 않아 위험이 작아진다.
* user table 에 회원레벨 column 추가
* 웹에서 사용 가능한 카메라 API 솔루션 컴포넌트 찾기
* DAO 전 인증하는 프록시 만들어 AOP 기능 완성하기 (spring 16 참고)