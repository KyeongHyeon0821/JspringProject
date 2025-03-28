select count(*) from member where level = 3;

select * from guest;
desc guest;

select date_format(cpDate, '%Y-%m-%d %H:%i') as cpDate, b.title as title, b.nickName as nickName, b.complaint as complaint, c.* from complaint c, board b, pds p where c.boardIdx=b.idx and c.pdsIdx=p.idx order by c.idx desc;

select * from complaint;
delete from complaint;

select * from board order by idx desc;

delete from board where idx = 59;  

/* 리뷰 테이블 */
create table review (
	idx int not null auto_increment,	/* 리뷰 고유번호 */
	part varchar(10) not null, 				/* 분야(board, pds, ...) */
	partIdx int not null,							/* 해당 분야의 고유번호 */
	mid varchar(20) not null,					
	nickName varchar(20) not null,
	star int not null default 0,			/* 별점 부여 점수 */
	content text,											/* 리뷰 내용 */
	rDate datetime default now(), 		/* 리뷰 등록날짜 */
	primary key(idx),
	foreign key(mid) references member(mid)       
);

/* 리뷰에 댓글 달기 */
create table reviewReply (
	replyIdx int not null auto_increment,	/* 댓글 고유번호 */
	reviewPart varchar(10) not null, 			/* 분야(board, pds, ...) */
	reviewIdx int not null,								/* 부모(리뷰) 고유번호 */
	replyMid varchar(20) not null,
	replyNickName varchar(20) not null,
	replyRDate datetime default now(),		/* 댓글 올린 날짜 */
	replyContent text not null,						/* 댓글 내용 */
	primary key(replyIdx),
	foreign key(reviewIdx) references review(idx),
	foreign key(replyMid) references member(mid)
);

insert into reviewReply values(default, 'pds', 2, 'admin', '관리자', default, '댓긅테스트');
insert into reviewReply values(default, 'pds', 3, 'admin', '관리자', default, '댓긅테스트12312');
select * from reviewReply where reviewPart = 'pds' and reviewIdx = (select idx = from review );

select  * from reviewReply where reviewIdx in (select review.idx from review where partIdx = 8 and part = 'pds') and reviewPart = 'pds';

