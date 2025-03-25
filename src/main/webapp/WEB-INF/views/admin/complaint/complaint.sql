show tables;


/* 신고테이블(complaint) */
create table complaint(
  idx  int not null auto_increment,	/* 신고 테이블 고유번호 */
  part varchar(15) not null,				/* 신고 분류(게시판:board, 자료실:pds, 방명록:guest) */
  partIdx int not null,							/* 신고 분류 항목 글의 고유 번호 (게시판 번호, 자료실 번호, 방명록 번호) */
  cpMid varchar(20) not null,				/* 신고자 아이디 */
  cpContent text not null,					/* 신고 사유 */
  cpDate datetime default now(),		/* 신고한 날짜 */
  primary key(idx),
  foreign key(cpMid) references member(mid)
);

desc complaint;

insert into complaint values(default, 'board', 58, 'kms1234', '불법정보', default);
update board set complaint = 'OK' where idx = 58;

select  * from board order by idx desc;

select * from complaint;