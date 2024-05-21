with prebase as (
    select
        from_user,
        count(id) as total_emails
    from
        google_gmail_emails
    group by
        1
),
base as (
    select
        *,
        row_number() over (order by total_emails desc, from_user asc) as ranking
    from
        prebase
)
select
    from_user,
    total_emails,
    ranking
from
    base
order by
    ranking asc,
    from_user asc