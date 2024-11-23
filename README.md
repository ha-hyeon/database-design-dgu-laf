# 데이터베이스 설계 프로젝트
## 동국대 분실물센터 앱 / DGU Lost And Found (dgu_laf)


# Backend

## 개발한 API 목록


## 데이터베이스 스키마

Users

LostItems

FoundItems

ItemLocation

Classrooms

ItemComments

ItemImages


## src/ 디렉토리

└── main/

    ├── java/

    │   └── com.example.laf/

    │       ├── LafApplication.java    // 메인 애플리케이션 파일

    │       ├── controller/

    │       │   └── ItemController.java    // 컨트롤러: 요청 처리

    │       ├── service/

    │       │   └── ItemService.java       // 서비스: 비즈니스 로직

    │       ├── repository/

    │       │   └── ItemRepository.java    // 레포지토리: 데이터베이스 처리

    │       ├── model/

    │       │   └── Item.java              // 엔터티 클래스: 데이터 구조

    │       └── dto/

    │           ├── ItemRequestDto.java    // DTO: 등록 요청 데이터

    │           └── ItemResponseDto.java   // DTO: 검색 응답 데이터

    └── resources/

        ├── application.properties         // 데이터베이스 설정

        └── schema.sql                     // 테이블 생성 SQL




# Frontend


## 개발한 스크린 목록


## 연동한 API 목록

