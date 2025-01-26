3. During the period of October 1st 2019 (inclusive) and November 1st 2019 (exclusive), how many trips, respectively, happened:

select
	COUNT(gtd.index)
from
	green_taxi_data gtd
where
	gtd.lpep_dropoff_datetime >= '2019-10-01'
and
	gtd.lpep_dropoff_datetime < '2019-11-01'
and gtd.trip_distance >= 10

104802; 198924; 109603; 27678; 35189

4. Which was the pick up day with the longest trip distance? Use the pick up time for your calculations.
Tip: For every day, we only care about one single trip with the longest distance.

SELECT
    DATE(lpep_pickup_datetime) AS pickup_date,
    MAX(trip_distance) AS max_trip_distance
FROM
    green_taxi_data
GROUP BY
    DATE(lpep_pickup_datetime)
ORDER BY
    max_trip_distance DESC

5. Which were the top pickup locations with over 13,000 in total_amount (across all trips) for 2019-10-18?
Consider only lpep_pickup_datetime when filtering by date.

select
	z."Zone" as zone_name,
	SUM(gtd.total_amount) as total_per_day
from
	green_taxi_data gtd
join
	zones z on
	z."LocationID" = gtd."PULocationID"
where
	DATE(gtd.lpep_pickup_datetime) = '2019-10-18'
group by
	1
having
	SUM(gtd.total_amount) > 13000

East Harlem North	18686.679999999724
East Harlem South	16797.259999999802
Morningside Heights	13029.789999999914

6. For the passengers picked up in October 2019 in the zone named "East Harlem North" which was the drop off zone that had the largest tip?
Note: it's tip , not trip
We need the name of the zone, not the ID.

select
	MAX(gtd.tip_amount) as "max_tip",
	z."Zone"
from
	green_taxi_data gtd
join zones z on
	z."LocationID" = gtd."PULocationID"
where
	z."Zone" = 'East Harlem North'
and EXTRACT(month from gtd.lpep_pickup_datetime) = 10
and EXTRACT(year from gtd.lpep_pickup_datetime ) = 2019
group by
	z."Zone"

East Harlem North