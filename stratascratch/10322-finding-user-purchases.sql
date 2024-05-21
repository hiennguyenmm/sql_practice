with prebase as (
    select
        user_id,
        created_at,
        lag(created_at, 1) over (partition by user_id order by created_at asc) as pre_purchase
    from
        amazon_transactions
),
base as (
    select
        user_id,
        datediff('day', pre_purchase, created_at) as day_gap
    from
        prebase
)
select
    distinct user_id
from
    base
where
    day_gap <= 7
order by
    user_id;