create table visit (
  visitDate  datetime not null default now(),
  visitCount int not null default 1
);

drop table visit;
delete from visit;

insert into visit values ('2025-4-2', 8);
insert into visit values ('2025-4-3', 5);
insert into visit values ('2025-4-5', 10);
insert into visit values ('2025-4-6', 12);
insert into visit values ('2025-4-7', 5);
insert into visit values ('2025-4-8', 4);
insert into visit values ('2025-4-9', 15);

select * from visit order by visitDate desc;
select substring(visitDate,1,10)as visitDate, visitCount from visit order by visitDate desc;