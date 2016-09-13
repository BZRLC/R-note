
DELETE from page_list
where link in 
(
select * from 
(
select link
from page_list
group by link
having count(1) >1
)A
)
and id not in
(
select * from (select min(id)
from page_list
group by link
having count(link)>1
)B
)
