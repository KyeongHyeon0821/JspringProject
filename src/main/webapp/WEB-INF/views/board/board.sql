show tables;

create table board (
  idx		int not null auto_increment,	/* 게시글의 고유번호 */
  mid		varchar(20) not null,					/* 게시글 올린이의 아이디 */
  nickName varchar(20) not null,			/* 게시글 올린이의 닉네임 */
  title varchar(100) not null,				/* 글 제목 */
  content text not null,							/* 글 내용 */
  hostIp  varchar(40) not null,				/* 글 올린이 IP */
  openSw  char(2) default 'OK',				/* 게시글 공개여부(OK:공개, NO:비공개) */
  readNum int default 0,							/* 글 조회수 */
  wDate		datetime default now(),			/* 글쓴 날짜 */
  good		int default 0,							/* '좋아요' 클릭횟수 누적 */
  complaint char(2) default 'NO',			/* 신고글 유무(신고당한글:OK, 정상글:NO) */
  primary key (idx),
  foreign key (mid) references member(mid)
);

desc board;

insert into board values(default,'admin','관리자','테스트24','테스트중입니다.', '192.168.50.57' ,default,default,default,default,default)
insert into board values(default,'atom1234','에이톰맨','에이톰 다녀갑니다.','잘 부탁드려요', '192.168.50.57' ,default,default,default,default,default)

select *,timestampdiff(hour, wDate, now()) AS hoursDiff from board;

