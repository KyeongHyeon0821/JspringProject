show tables;

create table user (
  idx  int  not null auto_increment, /* 고유번호 */
  mid  varchar(20) not null,				/* 아이디 */
  pwd  varchar(100) not null,				/* 비밀번호 */
  name varchar(20) not null,				/* 성명 */
  age  int default 20,							/* 나이 */
  gender char(2) default '여자',			/* 성별 */
  address varchar(10),							/* 주소 */
  primary key (idx),
  unique key (mid)
);

desc user;

insert into user values (default, 'admin', '1234', '관리자', default, default, '서울');

select * from user;
select * from user where mid like '%3%';
