select min(America) as America, min(Asia) as Asia, min(Europe) as Europe from
    (select 
        row,
        case when continent = 'America' then name else null end as America,
        case when continent = 'Asia' then name else null end as Asia,
        case when continent = 'Europe' then name else null end as Europe
    from
        (select *,
        row_number() over(partition by continent order by name) as row
        from student) t1) t2
group by row;