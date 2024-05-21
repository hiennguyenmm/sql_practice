with prebase as (
    select
        search_id,
        sum(clicked) as sum_click,
        min(search_results_position) as rank_min,
        max(search_results_position) as rank_max
    from
        fb_search_events
    group by
        1
)
select
    search_id,
    case
        when sum_click = 0 then 1
        when rank_min <= 3 then 3
        when rank_max > 3 then 2
    end as rating
from
    prebase
order by
    1