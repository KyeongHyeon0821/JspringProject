show tables;

create table pds(
	idx int not null auto_increment,		/* 자료실 고유번호 */
	mid varchar(20) not null,						/* 올린이 아이디	*/
	nickName varchar(20) not null,			/* 올린이 닉네임	*/
	fName varchar(200) not null,				/* 업로드시의 파일명	*/
	fSName varchar(200) not null,				/* 서버에 저장된 파일명 */
	fSize int not null,									/* 업로드한 파일의 총 사이즈 */
	title varchar(100) not null,				/* 업로드 파일의 간단한 제목 */
	content text,												/* 업로드 파일의 상세 설명	*/
  part varchar(20) not null,					/* 자료실 파일 분류(학습/여행/음식/기타) */
	hostIp varchar(30) not null,				/* 업로드한 클라이언트 IP */
	openSw char(3) default '공개',				/* 업로드한 자료의 공개여부('공개'/'비공개') */
  fDate datetime default now(),				/* 파일 업로드한 날짜 */
  downNum int default 0,							/* 파일 다운로드 횟수 */
	complaint char(2) default 'NO',			/* 신고글 유무(신고당한글:OK, 정상글:NO, 감춘글:HI(hidden)) */
	primary key(idx),
	foreign key(mid) references member(mid)
);
desc pds;

select * from pds;
insert into pds values(0,'admin' ,'', '', '', 0, '', '','','', default,default, default, default);