with new_invoice as (
    insert into invoices (pay_before)
        values ((select current_date))
        returning invoice_id)
update meter_responses
set invoice_id = (select * from new_invoice)
where meter_response_id = (select meter_response_id
                           from meter_responses
                                    inner join flats f on f.flat_id = meter_responses.flat_id
                                    inner join houses h on h.house_id = f.house_id
                                    inner join streets s on s.street_id = h.street_id
                           where flat_local_number = '2302'
                             and house_number = '5'
                             and name = 'ул.Оршанская'
                           order by giving_date desc
                           limit 1);