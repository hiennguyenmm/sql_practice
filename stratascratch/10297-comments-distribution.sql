with base as (
    select
        user_id,
        count(body) as number_of_comments
    from
        fb_users
        join fb_comments on user_id = id
    where
        date_trunc('day', joined_at) between '2018-01-01'
        and '2020-01-31'
        and date_trunc('day', created_at) between '2020-01-01'
        and '2020-01-31'
        and created_at >= joined_at
    group by
        1
)
select
    number_of_comments,
    count(user_id) as number_of_users
from
    base
group by
    1
order by
    1;