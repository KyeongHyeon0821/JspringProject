show tables;


/* 신고테이블(complaint) */
create table complaint(
  idx  int not null auto_increment,	/* 신고 테이블 고유번호 */
  part varchar(15) not null,				/* 신고 분류(게시판:board, 자료실:pds, 방명록:guest) */
  boardIdx int default 1,						/* 신고 분류 항목(게시판:board) 글의 고유 번호 (게시판 번호, 자료실 번호, 방명록 번호) */
  pdsIdx int default 1,							/* 신고 분류 항목(자료실:pds) 글의 고유 번호 (게시판 번호, 자료실 번호, 방명록 번호) */
  cpMid varchar(20) not null,				/* 신고자 아이디 */
  cpContent text not null,					/* 신고 사유 */
  cpDate datetime default now(),		/* 신고한 날짜 */
  primary key(idx),
  foreign key(cpMid) references member(mid),
  foreign key(boardIdx) references board(idx),
  foreign key(pdsIdx) references pds(idx)
);
/* 신고 처리 테이블 : boardIdx필드와 pdsIdx필드 삭제 후, partIdx필드(해당 part의 고유번호)추가, progress 필드 추가
 * 신고 처리 하기
 * complaintSw : H(감추기 - board 테이블의 complaint 필드값을 'HI', complaint 테이블의 progress 필드값을 '처리완료(H)')
 * complaintSw : S(보이기 - 신고해제 - board 테이블의 complaint 필드값을 'NO', complaint 테이블의 progress 필드값을 '처리완료(S)')
 * complaintSw : D(삭제하기 - board 테이블의 해당 레코드 삭제처리, complaint 테이블의 progress 필드값을 '처리완료(D)')
*/
drop table complaint;

desc complaint;

insert into complaint values(default, 'board', 58, 1, 'kms1234', '불법정보', default);
update board set complaint = 'OK' where idx = 58;

select  * from board order by idx desc;

select * from complaint;


select c.*,date_format(cpDate, '%Y-%m-%d %H:%i') as cpDate from complaint c, board b, pds p where c.boardIdx=b.idx and c.pdsIdx=p.idx order by c.idx desc;
