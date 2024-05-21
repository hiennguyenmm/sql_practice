select
    worker_title
from
    title
    join worker on worker_ref_id = worker_id
where
    salary = (
        select
            max(salary)
        from
            worker
    )