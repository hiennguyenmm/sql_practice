with exit_time as (
    select
        user_id,
        date_trunc('day', timestamp) as day,
        min(timestamp) AS page_exit
    from
        facebook_web_log
    where
        action = 'page_exit'
    group by
        1,
        2
),
load_time as (
    select
        user_id,
        date_trunc('day', timestamp) as day,
        max(timestamp) AS page_load
    from
        facebook_web_log
    where
        action = 'page_load'
    group by
        1,
        2
),
base as (
    select
        exit_time.user_id,
        exit_time.day,
        page_exit,
        page_load,
        page_exit - page_load as session_time
    from
        exit_time
        join load_time using (user_id, day)
    where
        page_exit > page_load
)
select
    user_id,
    avg(session_time)
from
    base
group by
    1