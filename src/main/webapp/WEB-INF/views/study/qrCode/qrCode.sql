show tables;

create table qrCode (
	idx     	int not null auto_increment,
	mid				varchar(20) not null,
	name			varchar(20) not null,
	email			varchar(50) not null,
	movieName varchar(50) not null,		/* 영화제목 */
	movieDate varchar(50) not null,		/* 영화 상영일 */
	movieTime varchar(50) not null,		/* 영화 상영시간 */
	movieAdult  varchar(50) not null,	/* 성인 예매티켓 수 */
	movieChild  varchar(50) not null,	/* 아동 예매티켓 수 */
	publishDate varchar(30) not null,	/* QR코드 발행일자(영화 예매일자) */
	qrCodeName	varchar(80) not null, /* 생성된 QR코드명 */	
	primary key(idx),
	foreign key(mid) references member(mid)
);
desc qrCode;
drop table qrCode;
