with prebase as (
    select
        date_trunc('month', created_at) AS month,
        sum(value) AS revenue
    from
        sf_transactions
    group by
        1
),
base as (
    select
        month,
        lag(revenue, 1) over (order by month asc ) as pre_revenue,
        revenue
    from
        prebase
    order by
        month asc
)
select
    to_char(month, 'yyyy-MM') AS month,
    round((revenue / pre_revenue - 1) * 100, 2) AS percentage_change
from
    base;