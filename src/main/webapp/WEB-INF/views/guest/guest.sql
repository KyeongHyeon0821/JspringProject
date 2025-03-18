show tables;

create table guest (
  idx  int not null auto_increment,	/* 고유번호 */
  name varchar(20) not null,				/* 성명 */
  content text not null, 						/* 방명록 내용 */
  email varchar(60),								/* 메일주소 */
  homePage varchar(60),							/* 홈페이지(블로그) 주소 */
  hostIp varchar(30) not null,			/* 방문자 IP */
  visitDate datetime default now(),	/* 방문한 날짜 */
  primary key(idx)
);

drop table guest;


insert into guest values (default,'관리자','방명록 서비스를 시작합니다.','yd12321@naver.com','blog.naver.com/yd12321','192.168.50.57',now());
select * from guest;
