select s.name, house_number, flat_local_number, t.name from flats
inner join houses h on h.house_id = flats.house_id
inner join streets s on s.street_id = h.street_id
inner join flats_x_agreements fxa on flats.flat_id = fxa.flat_id
inner join agreements a on a.agreement_id = fxa.agreement_id
inner join tariffs t on t.tariff_id = a.tariff_id
where fxa.end_date is null or t.end_date > current_date;