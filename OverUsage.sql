with X1 as 
(
	select 
		id, city, price, 
		ROW_NUMBER() over (partition by city order by price) as RC
	from
		flats
)
select 
	id, city, price 
from 
	X1
where 
	RC <= 3
order by 
	id