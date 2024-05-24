with base as (
    select
        Department.name as department,
        Employee.name as employee,
        salary,
        dense_rank() over (
            partition by Department.name
            order by
                salary desc
        ) AS rank_salary
    from
        Department
        join Employee on Department.id = Employee.departmentId
)
select
    department,
    employee,
    salary
from
    base
where
    rank_salary <= 3
order by
    department,
    salary desc