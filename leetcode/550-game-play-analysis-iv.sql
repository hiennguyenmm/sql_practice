with prebase as (
    select
        player_id,
        event_date as log_in_first_time,
        lead(event_date, 1) over (
            partition by player_id
            order by
                event_date asc
        ) as log_in_second_time,
        row_number() over (
            partition by player_id
            order by
                event_date asc
        ) as day_order
    from
        activity
),
base as (
    select
        player_id,
        (log_in_second_time - log_in_first_time) as day_gap
    from
        prebase
    where
        day_order = 1
)
select
    round(
        count(
            distinct case
                when day_gap = 1 then player_id
            end
        ) * 1.00 / count(distinct player_id),
        2
    ) AS fraction
from
    base