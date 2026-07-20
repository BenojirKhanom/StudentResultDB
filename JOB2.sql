
create database StudentResultDB
go
use StudentResultDB
--part 1
create table Department 
( DepartmentId int Identity(1,1) primary key,
  depName Varchar(20) null

)

create table Student 
( StudentId int Identity(1,1) primary key,
  studentName Varchar(30) not null ,
  DepartmentId int,
  foreign key (DepartmentId) 
  references Department(DepartmentId),
);


create table Result 
( ResultId int Identity(1,1) primary key,
  TotalMatks int ,
  Grade Varchar(30)  null ,
  Status Varchar(30)  null,
  StudentId int,
  foreign key (StudentId) 
  references Student(StudentId),
);


--part 2
insert into Department (depName) values ('Math'),('Bangla'),('English'),('Science'),('Social Science');
insert into Student (studentName ,DepartmentId)
values ('A',1),('B',1), 
('C',2),('D',2),
('E',3),('F',3),
('G',4),('H',4),
('I',5),('J',5)

insert into Result (TotalMatks,Grade,Status,StudentId) values
(80,'A+','Passed',1),
(70,'A','Passed',2),
(60,'B','Passed',3),
(50,'C','Passed',4),
(40,'D','Passed',5),
(30,'F','Failed',6),
(32,'F','Failed',7),
(25,'F','Failed',8),
(27,'F','Failed',9),
(31,'F','Failed',10);


--part 3
select * from Student

select s.studentName ,d.depName from Student s 
join Department d on s.DepartmentId = d.DepartmentId

select s.studentName from  Result r
join Student s  on s.StudentId = r.StudentId
where r.Status = 'Passed'

select s.studentName from  Result r
join Student s  on s.StudentId = r.StudentId
where r.Status = 'Failed'

select s.studentName from  Result r
join Student s  on s.StudentId = r.StudentId
where r.Grade = 'A'

select s.studentName , r.TotalMatks from  Result r
join Student s  on s.StudentId = r.StudentId
order by s.studentName , r.TotalMatks


--part 4
-- view
go
create view StudentsTotalMarks
as
select s.studentName , r.TotalMatks from  Result r
join Student s  on s.StudentId = r.StudentId
go
select * from StudentsTotalMarks

--
go
create proc sp_getStudentByGrade
@Grade varchar(30)
as
begin 
select s.studentName from  Result r
join Student s  on s.StudentId = r.StudentId
where r.Grade = @Grade
end
go
Exec sp_getStudentByGrade 'A'

---
go
create function greadeBesedOnMarks
(@marks int)
returns char(2)
as 
begin 
Declare @Grade char(2)
if @marks>=80 set @Grade ='A+'
else if @marks>=70 set @Grade ='A'
else if @marks>=60 set @Grade ='B'
else if @marks>=50 set @Grade ='C'
else if @marks>=40 set @Grade ='D'
else  set @Grade ='C'
return @Grade

end

go 
Exec greadeBesedOnMarks 70

--- part 5

update Result set TotalMatks = 50 where StudentId = 1

delete Result where StudentId = 2
delete Student where StudentId = 2


select s.studentName , r.TotalMatks from  Result r
join Student s  on s.StudentId = r.StudentId
where s.StudentId = 1
