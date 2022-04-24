create table service_zones
(
    service_zone_id serial
        constraint service_zones_pk
            primary key,
    name            varchar not null
);

alter table service_zones
    owner to n1kutochkin;

create table streets
(
    street_id serial
        constraint streets_pk
            primary key,
    name      varchar not null
);

alter table streets
    owner to n1kutochkin;

create table houses
(
    house_id        serial
        constraint houses_pk
            primary key,
    street_id       integer not null
        constraint houses_streets_street_id_fk
            references streets,
    service_zone_id integer not null
        constraint houses_service_zones_service_zone_id_fk
            references service_zones,
    house_number    varchar not null
);

alter table houses
    owner to n1kutochkin;

create unique index streets_name_uindex
    on streets (name);

create table owners
(
    owner_id      serial
        constraint owners_pk
            primary key,
    name          varchar           not null,
    surname       varchar           not null,
    middle_name   varchar           not null,
    birthday_date date              not null,
    balance       numeric default 0 not null
);

alter table owners
    owner to n1kutochkin;

create table flats
(
    flat_id         serial
        constraint flats_pk
            primary key,
    house_id        integer not null
        constraint flats_houses_house_id_fk
            references houses,
    owner_id        integer not null
        constraint flats_owners_owner_id_fk
            references owners,
    is_supplied_gas boolean not null
);

alter table flats
    owner to n1kutochkin;

create table tariffs
(
    tariff_id  serial
        constraint tariffs_pk
            primary key,
    start_date date not null,
    end_date   date
);

alter table tariffs
    owner to n1kutochkin;

create table agreements
(
    agreement_id  serial
        constraint agreements_pk
            primary key,
    approval_date date              not null,
    tariff_id     integer           not null
        constraint agreements_tariffs_tariff_id_fk
            references tariffs,
    discount_id   integer default 0 not null
);

alter table agreements
    owner to n1kutochkin;

create table flats_x_agreements
(
    agreement_id integer not null
        constraint flats_x_agreements_agreements_agreement_id_fk
            references agreements,
    flat_id      integer not null
        constraint flats_x_agreements_flats_flat_id_fk
            references flats
            on delete cascade,
    start_date   date    not null,
    end_date     date,
    constraint flats_x_agreements_pk
        primary key (agreement_id, flat_id)
);

alter table flats_x_agreements
    owner to n1kutochkin;

create table plans
(
    plan_id serial
        constraint plans_pk
            primary key,
    name    varchar not null
);

alter table plans
    owner to n1kutochkin;

create table tariffs_x_plans
(
    tariff_id integer not null
        constraint tariffs_x_plans_tariffs_tariff_id_fk
            references tariffs,
    plan_id   integer not null
        constraint tariffs_x_plans_plans_plan_id_fk
            references plans,
    rate      numeric not null,
    constraint tariffs_x_plans_pk
        primary key (tariff_id, plan_id)
);

alter table tariffs_x_plans
    owner to n1kutochkin;

create table periods
(
    period_id  serial
        constraint periods_pk
            primary key,
    start_date date not null,
    end_date   date not null
);

alter table periods
    owner to n1kutochkin;

create table invoices
(
    invoice_id serial
        constraint invoices_pk
            primary key,
    pay_before date not null,
    pay_date   date
);

alter table invoices
    owner to n1kutochkin;

create table meter_responses
(
    meter_response_id serial
        constraint meter_responses_pk
            primary key,
    flat_id           integer not null
        constraint meter_responses_flats_flat_id_fk
            references flats,
    period_id         integer not null
        constraint meter_responses_periods_period_id_fk
            references periods,
    invoice_id        integer not null
        constraint meter_responses_invoices_invoice_id_fk
            references invoices,
    giving_date       date    not null
);

alter table meter_responses
    owner to n1kutochkin;

create table meter_readings
(
    plan_id     integer not null
        constraint meter_readings_plans_plan_id_fk
            references plans,
    response_id integer not null
        constraint meter_readings_meter_responses_meter_response_id_fk
            references meter_responses,
    value       real    not null,
    constraint meter_readings_pk
        primary key (plan_id, response_id)
);

alter table meter_readings
    owner to n1kutochkin;

create table privileges
(
    privilege_id serial
        constraint privileges_pk
            primary key,
    title        varchar not null,
    discount     numeric not null
);

alter table privileges
    owner to n1kutochkin;

create table privileges_x_owners
(
    privilege_id integer not null
        constraint privileges_x_owners_privileges_privilege_id_fk
            references privileges,
    owner_id     integer not null
        constraint privileges_x_owners_owners_owner_id_fk
            references owners,
    constraint privileges_x_owners_pk
        primary key (privilege_id, owner_id)
);

alter table privileges_x_owners
    owner to n1kutochkin;

