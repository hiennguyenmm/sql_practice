with base as (
    select
        request_at AS day,
        count(trips.id) AS total_trips,
        count(
            case
                when trips.status != 'completed' then 1
            end
        ) AS cancel_trips
    from
        trips
        join users client_users on trips.client_id = client_users.users_id
        join users driver_users on trips.driver_id = driver_users.users_id
    where
        trips.request_at between '2013-10-01'
        and '2013-10-03'
        and client_users.banned = 'No'
        and driver_users.banned = 'No'
    group by
        1
)
select
    day AS Day,
    round(cancel_trips * 1.00 / total_trips, 2) AS "Cancellation Rate"
from
    base
order by
    day