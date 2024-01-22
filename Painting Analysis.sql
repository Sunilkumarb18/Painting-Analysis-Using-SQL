select * from work where museum_id is null

select top 3* from museum 
select top 3* from subject
select top 3 * from work
select top 3* from artist

select top 3* from product_size
select top 3* from canvas_size 
select * from museum_hours

select * from museum m 
where museum_id not in (select distinct museum_id from work)

select count(work_id) [Total Count]
from product_size 
where sale_price>regular_price

select w.name 
from product_size p
inner join work w on p.work_id=w.work_id
where sale_price<(0.5*regular_price)


update p 
set size_id = left(size_id,CHARINDEX('.',size_id)-1)
from product_size p where size_id like '%.%'

select top 1* from (
select label,
       MAX(cast(p.sale_price as decimal(18,2))) [Price]
from product_size p 
inner join canvas_size c on p.size_id=c.size_id
group by label) a order by Price desc



with cte as (
select *,ROW_NUMBER() over(partition by work_id,name,artist_id,style,museum_id order by work_id) no
from work)
delete from cte where no>1

select * from museum where city like '[0-9]%'

with cte as(
select *,ROW_NUMBER() over(partition by museum_id,[day],[open],[close] order by museum_id) rnk from museum_hours ) 
delete from cte where rnk>1

select top 10 subject
      
from subject s 
inner join work w on s.work_id=w.work_id
group by subject
order by COUNT(museum_id)  desc

with cte as(
select m.museum_id,
       city , m.state, m.country,ROW_NUMBER() over (partition by m.museum_id,m.city, m.state, m.country order by m.museum_id) rnk
from museum_hours mh 
right join museum m on m.museum_id=mh.museum_id 
where day in ('Sunday','Monday'))
select museum_id,city,state,country from cte where rnk>1

SELECT m.name, m.city, m.state, m.country
FROM museum_hours mh
JOIN museum m ON mh.museum_id = m.museum_id
WHERE day IN ('Sunday', 'Monday')
GROUP BY m.name, m.city, m.state, m.country
HAVING COUNT( day) = 2
ORDER BY m.name;


select top 3* from museum
select top 3* from museum_hours

select day,
       COUNT(museum_id) [Total Open Museums]
from museum_hours
group by day

select top 3* from museum
select top 3* from museum_hours
select top 3* from artist
select top 3* from work

select top 5 m.name,
             COUNT(work_id) [Total Paintings]
from museum m 
left join work w on m.museum_id=w.museum_id
group by m.name
order by [Total Paintings] desc

select top 3 * from artist
select top 3 * from work

select top 5 a.full_name,
       COUNT(work_id) [Total Count]
from artist a 
left join 
work w on a.artist_id=w.artist_id
group by a.full_name
order by [Total Count] desc

select top 3 * from canvas_size

SELECT TABLE_NAME, COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'size_id';

select top 3 * from product_size
select top 3 * from canvas_size

select top 3 * from (
						select label,
							   COUNT(work_id) [Total]
						from canvas_size cs 
						left join product_size ps 
						on cs.size_id=ps.size_id
						group by label
						)s
where s.Total>0
order by Total

select top 3* from museum m
select top 3* from museum_hours mh

select m.name,
       state,
       DATEDIFF(MINUTE,Open_Time,Close_Time)/60[Hours],
	   day
	  
from museum_hours mh
right join museum m on m.museum_id=mh.museum_id
order by Hours desc


select top 3* from museum

select top 3* from work

select top 3 * from subject

select top 1 m.name  
from museum m 
left join work w 
on m.museum_id=w.museum_id
group by m.name
order by COUNT(style)  desc

select top 3* from artist

select top 3* from museum

select top 3* from museum
select top 3* from work

select TABLE_NAME,* from INFORMATION_SCHEMA.COLUMNS  where COLUMN_NAME='artist_id'

select * from (
					select full_name,COUNT(country) [Total Countries]
					from artist a left join work w on a.artist_id=w.artist_id
								  left join museum m on w.museum_id=m.museum_id
					group by full_name)s 
where [Total Countries]>1

select top 3* from museum
select top 3* from work w


select top 1 country from (
							select top 5country,
								   COUNT( work_id) [Total] 	  
							from museum m left join work w on m.museum_id=w.museum_id
							group by country
							order by Total desc
							)s
order by Total

select top 3 w.name,count(m.museum_id) total from work w left join museum m on w.museum_id=w.museum_id
group by w.name
order by total 

select * from work where name like '%portrait%'

select top 3* from artist
select top 3* from museum

select top 1 
             a.full_name,
			 COUNT(w.name) [Total Count]
from artist a left join work w on w.artist_id=a.artist_id
              left join museum m on w.museum_id=m.museum_id
where w.name like '%portrait%' and m.country!='USA'
group by a.full_name
order by [Total Count] desc
