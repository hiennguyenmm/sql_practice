with prebase as (
    select
        *
    from
        (
            select
                distinct profession,
                1 AS id
            from
                employee_list
        ) AS profes full
        outer join (
            select
                distinct birth_month,
                1 AS id
            from
                employee_list
        ) as birth using (id)
    order by
        profes,
        birth
),
base as (
    select
        profession,
        birth_month,
        count(employee_id) AS no_of_employees
    from
        employee_list
    group by
        1,
        2
)
select
    prebase.profession,
    prebase.birth_month,
    case
        when no_of_employees is not null then no_of_employees
        else 0
    end as no_of_employees
from
    prebase
    left join base using (profession, birth_month)
order by
    1,
    2