WITH response_id as (
    insert
        into meter_responses (flat_id, giving_date)
            values ((select flat_id
                     from flats as f
                              inner join houses h on h.house_id = f.house_id
                              inner join streets s on s.street_id = h.street_id
                     where s.name = 'ул.Дубосековская'
                       and h.house_number = '9'
                       and f.flat_local_number = 'A12'),
                    '2022-05-01')
            returning meter_response_id)
insert
into meter_readings(plan_id, response_id, value)
values ((select plan_id from plans where name = 'Пик'),
        (select * from response_id),
        2.12),
       ((select plan_id from plans where name = 'Полупик'),
        (select * from response_id),
        6.4),
       ((select plan_id from plans where name = 'Ночь'),
        (select * from response_id),
        23.4);

WITH response_id as (
    insert
        into meter_responses (flat_id, giving_date)
            values ((select flat_id
                     from flats as f
                              inner join houses h on h.house_id = f.house_id
                              inner join streets s on s.street_id = h.street_id
                     where s.name = 'ул.Дубосековская'
                       and h.house_number = '9'
                       and f.flat_local_number = 'A12'),
                    '2022-05-01')
            returning meter_response_id)
insert
into meter_readings(plan_id, response_id, value)
values ((select plan_id from plans where name = 'День'),
        (select * from response_id),
        2.12),
       ((select plan_id from plans where name = 'Ночь'),
        (select * from response_id),
        23.4);