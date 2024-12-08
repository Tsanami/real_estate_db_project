-- Создаем схему для представлений
create schema if not exists real_estate_view;

set search_path = real_estate_view, real_estate, public;

-- типы недвижимости
create or replace view v_property_types as
select
    pt.name as "Тип недвижимости",
    pt.description as "Описание"
from
    real_estate.property_types pt;

-- владельцы с замаскированными данными
create or replace view v_owners as
select
    o.name as "Владелец",
    overlay(o.email placing '****' from position('@' in o.email) - 3) as "Электронная почта",  -- Частичное маскирование
    left(o.phone, 3) || '****' || right(o.phone, 2) as "Номер телефона",
    o.country as "Страна"
from
    real_estate.owners o;

-- клиенты с замаскированными данными
create or replace view v_clients as
select
    c.name as "Клиент",
    overlay(c.email placing '****' from position('@' in c.email) - 3) as "Электронная почта",  -- Частичное маскирование
    left(c.phone, 3) || '****' || right(c.phone, 2) as "Номер телефона"
from
    real_estate.clients c;

-- агенты с замаскированными данными
create or replace view v_agents as
select
    a.name as "Агент",
    overlay(a.email placing '****' from position('@' in a.email) - 3) as "Электронная почта",  -- Частичное маскирование
    left(a.phone, 3) || '****' || right(a.phone, 2) as "Номер телефона"
from
    real_estate.agents a;

-- свойства недвижимости
create or replace view v_properties as
select
    p.address as "Адрес",
    pt.name as "Тип недвижимости",
    p.area as "Площадь (кв. м)",
    p.price as "Цена (₽)",
    p.year_built as "Год постройки",
    case 
        when p.status = 'построено' then 'Построено'
        when p.status = 'не построено' then 'Не построено'
    end as "Статус",
    coalesce(p.rental_price, '0') as "Цена аренды (₽)"
from
    real_estate.properties p
inner join
    real_estate.property_types pt on p.property_types_id = pt.property_type_id;

-- информация по контрактам
create or replace view v_contracts as
select
    c.start_date as "Дата начала",
    coalesce(to_char(c.end_date, 'YYYY-MM-DD'), 'Действует') as "Дата окончания", -- Преобразуем дату в текст
    case
        when c.contract_type = 'Аренда' then 'Аренда'
        when c.contract_type = 'Продажа' then 'Продажа'
    end as "Тип контракта",
    p.address as "Адрес недвижимости",
    cl.name as "Клиент",
    a.name as "Агент"
from
    real_estate.contracts c
inner join
    real_estate.properties p on c.property_id = p.property_id
inner join
    real_estate.clients cl on c.client_id = cl.client_id
inner join
    real_estate.agents a on c.agent_id = a.agent_id;

-- платежи
create or replace view v_payments as
select
    p.date as "Дата платежа",
    p.payment_amount as "Сумма (₽)",
    c.contract_type as "Тип контракта",
    cl.name as "Клиент",
    a.name as "Агент"
from
    real_estate.payments p
inner join
    real_estate.contracts c on p.contract_id = c.contract_id
inner join
    real_estate.clients cl on c.client_id = cl.client_id
inner join
    real_estate.agents a on c.agent_id = a.agent_id;

-- комнаты
create or replace view v_rooms as
select
    r.room_type as "Тип комнаты",
    r.area as "Площадь комнаты (кв. м)",
    p.address as "Адрес недвижимости"
from
    real_estate.rooms r
inner join
    real_estate.properties p on r.property_id = p.property_id;

-- фотографии недвижимости
create or replace view v_property_photos as
select
    ph.photo_url as "Ссылка на фото",
    r.room_type as "Тип комнаты",
    p.address as "Адрес недвижимости"
from
    real_estate.property_photos ph
inner join
    real_estate.rooms r on ph.room_id = r.room_id
inner join
    real_estate.properties p on r.property_id = p.property_id;

-- история изменений договоров
create or replace view v_contracts_history as
select
    h.event_type as "Тип события",
    h.event_date as "Дата события",
    h.description as "Описание",
    p.address as "Адрес недвижимости",
    cl.name as "Клиент",
    a.name as "Агент"
from
    real_estate.contracts_history h
inner join
    real_estate.properties p on h.property_id = p.property_id
inner join
    real_estate.clients cl on h.client_id = cl.client_id
inner join
    real_estate.agents a on h.agent_id = a.agent_id;

-- Представление, содержащее основную информацию из всех таблиц  
create or replace view v_full_overview as
select
    -- Информация о недвижимости
    p.address as "Адрес недвижимости",
    pt.name as "Тип недвижимости",
    p.area as "Площадь (кв. м)",
    p.price as "Цена (₽)",
    p.rental_price as "Цена аренды (₽)",
    to_char(p.year_built, 'YYYY') as "Год постройки",
    case 
        when p.status = 'построено' then 'Построено'
        when p.status = 'не построено' then 'Не построено'
    end as "Статус",
    -- Информация о владельце
    o.name as "Владелец",
    overlay(o.email placing '****' from position('@' in o.email) - 3) as "Электронная почта владельца",
    left(o.phone, 3) || '****' || right(o.phone, 2) as "Телефон владельца",
    -- Информация о контракте
    c.start_date as "Дата начала контракта",
    coalesce(to_char(c.end_date, 'YYYY-MM-DD'), 'Действует') as "Дата окончания контракта",
    c.contract_type as "Тип контракта",
    -- Информация о клиенте
    cl.name as "Клиент",
    overlay(cl.email placing '****' from position('@' in cl.email) - 3) as "Электронная почта клиента",
    left(cl.phone, 3) || '****' || right(cl.phone, 2) as "Телефон клиента",
    -- Информация об агенте
    a.name as "Агент",
    overlay(a.email placing '****' from position('@' in a.email) - 3) as "Электронная почта агента",
    left(a.phone, 3) || '****' || right(a.phone, 2) as "Телефон агента",
    -- Информация о платежах
    sum(pay.payment_amount) as "Общая сумма платежей (₽)",
    -- Информация о комнатах
    string_agg(r.room_type || ' (' || r.area || ' кв. м)', ', ') as "Комнаты",
    -- Информация о фотографиях
    string_agg(ph.photo_url, ', ') as "Фотографии"
from
    real_estate.properties p
inner join real_estate.property_types pt on p.property_types_id = pt.property_type_id
left join real_estate.owners o on p.owner_id = o.owner_id
left join real_estate.contracts c on p.property_id = c.property_id
left join real_estate.clients cl on c.client_id = cl.client_id
left join real_estate.agents a on c.agent_id = a.agent_id
left join real_estate.payments pay on c.contract_id = pay.contract_id
left join real_estate.rooms r on p.property_id = r.property_id
left join real_estate.property_photos ph on r.room_id = ph.room_id
group by
    p.property_id, pt.name, o.name, o.email, o.phone, p.area, p.price, 
    p.rental_price, p.year_built, p.status, c.start_date, c.end_date, 
    c.contract_type, cl.name, cl.email, cl.phone, a.name, a.email, a.phone;
