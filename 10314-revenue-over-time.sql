with prebase as (
    select
        date_trunc('month', created_at) as month,
        sum(purchase_amt) as revenue
    from
        amazon_purchases
    where
        purchase_amt > 0
    group by
        1
),
base as (
    select
        month,
        lag(revenue, 1) over (
            order by
                month asc
        ) as last_month,
        lag(revenue, 2) over (
            order by
                month asc
        ) as past_3_month,
        revenue AS this_month
    from
        prebase
    order by
        1
)
select
    to_char(month, 'yyyy-MM') AS month,
    (last_month + past_3_month + this_month) / 3 as rolling_average_revenue
from
    base