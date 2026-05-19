
WITH daily_weather AS(

SELECT 
DATE(TIME) AS daily_weather,
weather,
temp,
pressure,
humidity,
clouds
 
FROM {{ source('demo', 'weather') }}


),

daily_weather_agg as 

(
select daily_weather,
weather,
ROUND(AVG(temp),3) AS AVG_TEMP,
ROUND(AVG(pressure),3) AS AVG_PRESSURE,
ROUND(AVG(humidity),3) AS AVG_HUMIDITY,
ROUND(AVG(clouds),3) AS AVG_CLOUDS

FROM daily_weather
GROUP BY daily_weather,weather
QUALIFY  ROW_NUMBER() OVER(PARTITION BY daily_weather ORDER BY COUNT(weather) DESC) =1
)

SELECT 
* 
FROM daily_weather_agg
