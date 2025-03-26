select count(*) from member where level = 3;

select * from guest;
desc guest;

select date_format(cpDate, '%Y-%m-%d %H:%i') as cpDate, b.title as title, b.nickName as nickName, b.complaint as complaint, c.* from complaint c, board b, pds p where c.boardIdx=b.idx and c.pdsIdx=p.idx order by c.idx desc;

select * from complaint;
delete from complaint;

select * from board order by idx desc;

delete from board where idx = 59;  
