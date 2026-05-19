WITH CTE AS(

SELECT 
t.*,
w.* 
FROM {{ ref('trip_fact') }} t
left join {{ ref('daily_weather') }} w
on t.TRIP_DATE = w.DAILY_WEATHER

order by TRIP_DATE DESC

)

select 
* 
from CTE