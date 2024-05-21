with base as (
    select
        user_id,
        name,
        sum(distance) AS total_distance
    from
        lyft_rides_log
        join lyft_users on user_id = lyft_users.id
    group by
        1,
        2
)
select
    user_id,
    name,
    total_distance
from
    base
order by
    total_distance desc
limit
    10