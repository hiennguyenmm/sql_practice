select
    date_part('week', date) AS week_number,
    sum(amount_spent) / count(user_id) as average_amount_spent
from
    user_purchases
where
    day_name = 'Friday'
group by
    1;