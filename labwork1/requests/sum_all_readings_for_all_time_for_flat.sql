select s.name, house_number, flat_local_number, sum(value)
from meter_readings
         inner join meter_responses mr on mr.meter_response_id = meter_readings.response_id
         inner join flats f on f.flat_id = mr.flat_id
         inner join houses h on h.house_id = f.house_id
         inner join streets s on s.street_id = h.street_id
group by s.name, house_number, flat_local_number;