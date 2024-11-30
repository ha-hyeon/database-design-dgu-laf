# 데이터베이스 설계 프로젝트
동국대 분실물센터 앱 / DGU Lost And Found (dgu_laf)
AI융합학부 2022113162 안하현

## Backend
#### 데이터베이스 스키마(schema.sql 참조)

Users

Items

Classrooms

Tags

ItemComments

ItemImages


#### php파일

db.php

items.php

comments.php

users.php

classrooms.php

images.php


## Frontend

#### 개발한 스크린과 기능
로그인(아이디, 비번, 회원가입 버튼)

회원가입(아이디, 비번, 전번)

홈화면(검색, 최근 게시물들(위젯 이용), 네비게이션바 : 홈, 검색, 내가쓴글, 글쓰기)

검색(타이틀, lost/found, 강의실 필터링 기능)

검색 결과 화면 (위젯 이용)

아이템 세부 화면(사진,  글쓴이, lost/found+제목, 시간, 강의실, 세부위치, 글, 댓글들(위젯이용), 댓글달기 버튼)

글쓰기 화면(lost/found 선택, 시간, 제목, 글, 사진, 강의실, 세부위치)

댓글달기 스크린(아이템 제목, 댓글 위젯, 텍스트필드, 등록 버튼)

내가 쓴 글(위젯이용, 수정/삭제 기능)

#### 개발한 위젯과 기능
아이템 위젯(사진, 제목, 시간, 강의실)

내가쓴 아이템 위젯(아이템 위젯 + 수정삭제버튼)

댓글 위젯(글쓴이 이름, 내용, 삭제버튼)


