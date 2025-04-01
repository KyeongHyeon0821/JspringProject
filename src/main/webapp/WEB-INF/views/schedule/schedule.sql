show tables;

create table schedule(
	idx int not null auto_increment,
	mid	varchar(20) not null,
	sDate datetime not null,		/* 일정 등록 날짜 */
	part varchar(10) not null,	/* 1.모임, 2.업무, 3.학습, 4.여행, 0.기타 */
	content text not null,			/* 일정 상세 내용 */
	primary key(idx),
	foreign key(mid) references member(mid)
);

insert into schedule values(default, 'admin', '2025-03-15', '학습', '프로젝트 기획 초안');
insert into schedule values(default, 'admin', '2025-03-31', '업무', 'A팀 프로젝트 초안 회의');
insert into schedule values(default, 'admin', '2025-03-31', '모임', 'A팀 단합대회, 17시 충북대 중문 커피숍');
insert into schedule values(default, 'admin', '2025-04-05', '모임', '식목일 모임, 10시 청주쳬육관 기념식수');
insert into schedule values(default, 'hkd1234', '2025-04-09', '학습', '스프링 레거시 이론 학습');
insert into schedule values(default, 'hkd1234', '2025-04-15', '여행', '천안 여행');
insert into schedule values(default, 'hkd1234', '2025-04-18', '기타', '운동');
insert into schedule values(default, 'hkd1234', '2025-04-20', '기타', '정보처리기사 실기 시험');
insert into schedule values(default, 'hkd1234', '2025-04-21', '업무', '프로젝트 발표');
insert into schedule values(default, 'hkd1234', '2025-04-30', '기타', '저녁약속');
insert into schedule values(default, 'hkd1234', '2025-05-01', '기타', '아침운동');
insert into schedule values(default, 'hkd1234', '2025-05-05', '여행', '에버랜드 놀이공원');
insert into schedule values(default, 'kms1234', '2025-03-23', '모임', '성안길 제일카페 18시');
insert into schedule values(default, 'kms1234', '2025-04-02', '기타', '휴강');
insert into schedule values(default, 'kms1234', '2025-04-02', '기타', '휴강');
insert into schedule values(default, 'kms1234', '2025-04-07', '업무', '프로젝트 요구사항 정의서 제출');
insert into schedule values(default, 'kms1234', '2025-04-11', '학습', 'API 복습');
insert into schedule values(default, 'kms1234', '2025-04-15', '학습', '정보처리기사 실기 공부');
insert into schedule values(default, 'kms1234', '2025-04-20', '업무', 'J Project 점검');
insert into schedule values(default, 'kms1234', '2025-04-26', '학습', 'Python 중급학습');
insert into schedule values(default, 'kms1234', '2025-04-30', '기타', '당근마켓 집 앞 거래');
insert into schedule values(default, 'kms1234', '2025-05-04', '여행', '강원도 속초 1박2일 여행');
insert into schedule values(default, 'kms1234', '2025-03-15', '학습', '정처기 공부');
insert into schedule values(default, 'kms1234', '2025-03-31', '학습', '프로그래밍 공부');
insert into schedule values(default, 'kms1234', '2025-03-31', '업무', '프로젝트 기획안 회의');

select * from schedule where mid='hkd1234' and date_format(sDate, '%Y-%m')='2025-04';

select * from schedule where date_format(sDate, '%Y-%m') ='2025-04' and mid = 'kms1234';
select * from schedule where date_format(sDate, '%Y-%m') ='2025-04' and mid = 'kms1234' order by sDate;
select * from schedule where date_format(sDate, '%Y-%m') ='2025-04' and mid = 'kms1234' order by sDate, part;
select * from schedule where date_format(sDate, '%Y-%m') ='2025-04' and mid = 'kms1234' group by sDate,part order by sDate, part;
select *, count(part) as partCnt from schedule where date_format(sDate, '%Y-%m') = '2025-04' and mid = 'kms1234' group by sDate order by sDate, part;
