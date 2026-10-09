with cte_numbers(n, weekday)
as(
    
	select 0, datename(DW,0)
	union all
	select n+1, DATENAME(DW,n+1)
	from cte_numbers
	where n < 6
)
select weekday
from cte_numbers;

select * from employees;

with cteEmployeeManagerialLevels(employee_id, employee_name , manager_id ,[level])
as
(
	select e.employee_id ,e.employee_name,isnull(e.manager_id,0), 1
	from employees e
	where manager_id is null
	union all 
	select e.employee_id ,e.employee_name,e.manager_id, [level]+1
	from employees e 
	join cteEmployeeManagerialLevels ce 
	on e.manager_id = ce.employee_id
)
select * from  cteEmployeeManagerialLevels;



-- ======================================================================================================


create schema test

CREATE TABLE test.bill_of_materials (
    parent_part_id INT,
    child_part_id  INT,
    quantity       DECIMAL(10, 2) NOT NULL DEFAULT 1.00,
    PRIMARY KEY (parent_part_id, child_part_id)
);

CREATE TABLE test.parts (
    part_id   INT PRIMARY KEY,
    part_name VARCHAR(100) NOT NULL,
    part_type VARCHAR(20) CHECK (part_type IN ('Assembly', 'Sub-Assembly', 'Component'))
);

INSERT INTO test.parts (part_id, part_name, part_type) VALUES
(100, 'Bicycle', 'Assembly'),
(200, 'Frame Assembly', 'Sub-Assembly'),
(201, 'Frame Tube', 'Component'),
(202, 'Front Fork', 'Component'),
(300, 'Wheel Assembly', 'Sub-Assembly'),
(301, 'Rim', 'Component'),
(302, 'Tire', 'Component'),
(303, 'Spoke', 'Component');

INSERT INTO test.bill_of_materials (parent_part_id, child_part_id, quantity) VALUES
(100, 200, 1.00), -- 1 Frame per Bicycle
(100, 300, 2.00), -- 2 Wheels per Bicycle
(200, 201, 1.00), -- 1 Tube per Frame
(200, 202, 1.00), -- 1 Fork per Frame
(300, 301, 1.00), -- 1 Rim per Wheel
(300, 302, 1.00), -- 1 Tire per Wheel
(300, 303, 32.00); -- 32 Spokes per Wheel

-- Write a recursive CTE query that finds only the sub-components required to build a single Wheel Assembly (part_id = 300).


-- Q1
with cteBuildSingleWheelAssembly
as
(
	select p.parent_part_id
	,p.child_part_id
	,p.quantity
	,1 as n
	from test.bill_of_materials p
	where p.parent_part_id=300
	union all
	select p.parent_part_id
	,p.child_part_id
	,p.quantity
	,n+1
	from test.bill_of_materials p 
	join cteBuildSingleWheelAssembly ca
	on p.parent_part_id = ca.child_part_id
)
select * from cteBuildSingleWheelAssembly;

-- Q2
with cteNum(n)
as
(
	select 1
	union all
	select n+1
	from cteNum
	where n <10
)
select n from cteNum



--Q3

declare @year int = 2026;
declare @month int = 10;
with cteGenDates(date)
as
(
select DATEFROMPARTS(@year, @month,1)
union all
select dateadd(day, 1 , date)
from cteGenDates
where date < DATEFROMPARTS(@year, @month, 31)
)
select date from cteGenDates



-- ===================================


CREATE TABLE test.Projectss
(
    ProjectId INT PRIMARY KEY,
    ProjectName VARCHAR(100) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NULL,
    Status VARCHAR(20) NOT NULL
        DEFAULT 'Planned',

    CHECK (EndDate IS NULL OR EndDate >= StartDate)
);
GO

CREATE TABLE test.Taskss
(
    TaskId INT PRIMARY KEY,
    ProjectId INT NOT NULL,
    TaskName VARCHAR(150) NOT NULL,

    ParentTaskId INT NULL,
    DependsOnTaskId INT NULL,

    AssignedTo VARCHAR(100) NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NULL,
    Status VARCHAR(20) NOT NULL
        DEFAULT 'Pending',

    FOREIGN KEY (ProjectId)
        REFERENCES test.Projectss(ProjectId),

    FOREIGN KEY (ParentTaskId)
        REFERENCES test.Taskss(TaskId),

    FOREIGN KEY (DependsOnTaskId)
        REFERENCES test.Taskss(TaskId),

    CHECK (ParentTaskId IS NULL
           OR ParentTaskId <> TaskId),

    CHECK (DependsOnTaskId IS NULL
           OR DependsOnTaskId <> TaskId),

    CHECK (EndDate IS NULL OR EndDate >= StartDate)
);

INSERT INTO test.Projectss
    (ProjectId, ProjectName, StartDate, EndDate, Status)
VALUES
    (1, 'E-Commerce Application',
        '2026-10-01', '2026-12-31', 'In Progress'),

    (2, 'Employee Management System',
        '2026-10-05', '2027-01-31', 'Planned');

INSERT INTO test.Taskss
    (TaskId, ProjectId, TaskName, ParentTaskId,
     DependsOnTaskId, AssignedTo, StartDate, EndDate, Status)
VALUES
-- Project 1: top-level tasks
(101, 1, 'Requirement Analysis', NULL, NULL,
 'Rahul', '2026-10-01', '2026-10-05', 'Completed'),

(102, 1, 'System Design', NULL, 101,
 'Amit', '2026-10-06', '2026-10-12', 'Completed'),

(103, 1, 'Backend Development', NULL, 102,
 'Priya', '2026-10-13', '2026-10-25', 'In Progress'),

(104, 1, 'Frontend Development', NULL, 102,
 'Neha', '2026-10-13', '2026-10-27', 'In Progress'),

(105, 1, 'Testing', NULL, 103,
 'Rohit', '2026-10-28', '2026-11-05', 'Pending'),

-- Subtasks of Backend Development
(106, 1, 'Database Design', 103, NULL,
 'Amit', '2026-10-13', '2026-10-16', 'Completed'),

(107, 1, 'Develop API', 103, 106,
 'Priya', '2026-10-17', '2026-10-23', 'In Progress'),

(108, 1, 'API Unit Testing', 103, 107,
 'Rohit', '2026-10-24', '2026-10-25', 'Pending'),

-- Project 2
(201, 2, 'Gather Employee Requirements', NULL, NULL,
 'Sneha', '2026-10-05', '2026-10-10', 'Planned'),

(202, 2, 'Design Employee Database', NULL, 201,
 'Amit', '2026-10-11', '2026-10-15', 'Planned');


 select * from test.Taskss;
 select * from test.Projectss;

 -- Retrieve all subtasks under a parent task
-- Given TaskId = 103 (Backend Development), retrieve all tasks and nested subtasks under it, regardless of depth.

-- Q1
with cteSubTask(TaskId,Taskname, ParentSubName,n )
as
(
	select t.TaskId, t.TaskName,isnull(t.ParentTaskId,0),0 
	from test.Taskss t 
	where t.TaskId = 103
	union all
	select t.TaskId, t.TaskName,t.ParentTaskId,n+1
	from test.Taskss t 
	join 
	cteSubTask c
	on t.ParentTaskId = c.TaskId
	
)
select * from cteSubTask ;




-- Q2
with TaskHierarchy
(
		TaskId,
        ProjectId,
        TaskName,
        ParentTaskId,
        Status,
		n
)
as
(
    select
        TaskId,
        ProjectId,
        TaskName,
        ParentTaskId,
        Status,
		1
    from test.Taskss
    where ParentTaskId IS NULL

    union all

    select
        t.TaskId,
        t.ProjectId,
        t.TaskName,
        t.ParentTaskId,
        t.Status,
		n+1
   from test.Taskss t
    INNER JOIN TaskHierarchy h
        ON t.ParentTaskId = h.TaskId
)
SELECT
    ProjectId,
    TaskId,
    TaskName,
    Status,
	n as level
FROM TaskHierarchy h
WHERE NOT EXISTS
(
    SELECT 1
    FROM test.Taskss t
    WHERE t.ParentTaskId = h.TaskId
);




-- Q3
with cteSubTask(TaskId,Taskname, ParentSubName,n )
as
(
	select t.TaskId, t.TaskName,isnull(t.ParentTaskId,0),0 
	from test.Taskss t 
	where t.ParentTaskId is not null
	union all
	select t.TaskId, t.TaskName,t.ParentTaskId,n+1
	from test.Taskss t 
	join 
	cteSubTask c
	on t.ParentTaskId = c.TaskId
	
)
select * from cteSubTask ;




