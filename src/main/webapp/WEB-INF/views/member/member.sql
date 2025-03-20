show tables;

create table member(
	idx			 int not null auto_increment,				/* 회원 고유번호 */
	mid			 varchar(20) not null,						 	/* 회원 아이디(중복불허) */
	pwd 		 varchar(100) not null,					 		/* 회원 비밀번호(BCryptPasswordEncoder) */
	nickName varchar(20) not null, 						 	/* 회원 별명(중복불허/수정가능)	*/
	name 		 varchar(20) not null,						 	/* 회원 성명 */
	gender   char(2) not null default '남자',		 	/* 회원 성별 */
	birthday datetime default now(),				 		/* 회원 생일 */
	tel 		 varchar(15),											 	/* 전화번호 : 010-1234-5678 */
	address  varchar(100),								 			/* 회원 주소(다음 우편번호 API 사용) */
	email		 varchar(60) not null,					 		/* 회원 이메일(회원가입시 인증 또는 '아이디/비밀번호' 분실시 사용 - 정규식 필수 체크 */
	job			 varchar(20),												/* 직업(회원 통계시 필요) */
	hobby		 varchar(100),											/* 취미(2개 이상 선택 가능, 구분자는 '/'로 처리하기로 한다. */
	photo		 varchar(100) default 'noimage.jpg',/* 회원 사진 */
	content  text,															/* 회원 소개 */
	userInfor char(3) default '공개',							/* 회원 정보 공개여부(공개/비공개) */
	userDel	 char(2) default 'NO',							/* 회원 탈퇴 신청여부(NO:현재 활동중, OK:탈퇴신청중) */
	point		 int default 100,										/* 회원 누적 포인트(가입포인트), 1회방문 시 10포인트 증가, 1일 최대 50포인트까지 허용, 물건구매시 100원당 1포인트 증가 */
	level 	 int default 3,											/* 회원등급(0:관리자, 1:우수회원, 2:정회원, 3:준회원), 99:비회원, 999:탈퇴신청회원 */
	visitCnt int default 0,											/* 총 방문수 */
	todayCnt int default 0,											/* 오늘 방문한 횟수 */
	startDate datetime default now(),						/* 최초 가입일 */
	lastDate datetime default now(),						/* 마지막 접속일 */
	primary key(idx),
	unique key(mid)
);

desc member;

select * from member order by idx desc;

update member set level=0 where mid='admin';
update member set level=2 where idx=2;

select count(*) 
from guest, member 
where member.name = '관리자' 
  and (guest.name = member.name or guest.name = member.nickName);