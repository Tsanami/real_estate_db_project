set search_path = real_estate, public;

delete from contracts_history;
delete from payments;
delete from property_photos;
delete from rooms;
delete from contracts;
delete from properties;
delete from agents;
delete from clients;
delete from owners;
delete from property_types;

insert into property_types (property_type_id, name, description)
values 
(1, 'квартира', 'жилая квартира'),
(2, 'дом', 'независимый жилой дом'),
(3, 'офис', 'коммерческое офисное помещение'),
(4, 'склад', 'складское помещение'),
(5, 'магазин', 'розничный магазин'),
(6, 'вилла', 'роскошная жилая вилла'),
(7, 'студия', 'компактная квартира для одного или пары'),
(8, 'пентхаус', 'роскошная квартира на последнем этаже'),
(9, 'двухуровневая', 'квартира с двумя уровнями'),
(10, 'особняк', 'большой роскошный дом');

insert into owners (owner_id, name, email, phone, country)
values
(1, 'Иван Иванов', 'ivanov@example.com', '123-456-7890', 'Россия'),
(2, 'Мария Петрова', 'petrova@example.com', '234-567-8901', 'Россия'),
(3, 'Сергей Кузнецов', 'kuznetsov@example.com', '345-678-9012', 'Россия'),
(4, 'Елена Сидорова', 'sidorova@example.com', '456-789-0123', 'Россия'),
(5, 'Александр Смирнов', 'smirnov@example.com', '567-890-1234', 'Россия'),
(6, 'люкас уильямс', 'lucas@example.com', '678-901-2345', 'испания'),
(7, 'софия джонсон', 'sophia.johnson@example.com', '789-012-3456', 'италия'),
(8, 'лиам мартинес', 'liam.martinez@example.com', '890-123-4567', 'мексика'),
(9, 'ава джексон', 'ava.jackson@example.com', '901-234-5678', 'франция'),
(10, 'мейсон браун', 'mason.brown@example.com', '123-987-6543', 'бразилия');

insert into clients (client_id, name, email, phone)
values
(1, 'Анна Воронова', 'voronova@example.com', '123-456-1234'),
(2, 'Дмитрий Романов', 'romanov@example.com', '234-567-2345'),
(3, 'Ольга Фёдорова', 'fedorova@example.com', '345-678-3456'),
(4, 'Петр Иванов', 'ivanov@example.com', '456-789-4567'),
(5, 'Наталья Коваленко', 'kovalenko@example.com', '567-890-5678'),
(6, 'люкас паркер', 'lucas.parker@example.com', '678-234-5678'),
(7, 'амелия скотт', 'amelia.scott@example.com', '789-345-6789'),
(8, 'ноа аддамс', 'noah.adams@example.com', '890-456-7890'),
(9, 'миа грин', 'mia.green@example.com', '901-567-8901'),
(10, 'джеймс рейд', 'james.reid@example.com', '123-678-9012');

insert into agents (agent_id, name, email, phone)
values
(1, 'Андрей Шмидт', 'shmidt@example.com', '111-222-3333'),
(2, 'Марина Гордеева', 'gordeva@example.com', '222-333-4444'),
(3, 'Константин Лебедев', 'lebedev@example.com', '333-444-5555'),
(4, 'Татьяна Павлова', 'pavlova@example.com', '444-555-6666'),
(5, 'Евгений Козлов', 'kozlov@example.com', '555-666-7777'),
(6, 'агент уилсон', 'wilson@example.com', '666-777-8888'),
(7, 'агент джексон', 'jackson@example.com', '777-888-9999'),
(8, 'агент ли', 'lee@example.com', '888-999-0000'),
(9, 'агент уайт', 'white@example.com', '999-000-1111'),
(10, 'агент аллен', 'allen@example.com', '000-111-2222');

insert into properties (property_id, property_types_id, owner_id, address, area, price, year_built, status, rental_price)
values
(1, 1, 1, '123 main st, springfield', 120, 150000, '2000-05-15', 'построено', 1200),
(2, 2, 2, '456 elm st, shelbyville', 250, 300000, '1995-07-20', 'построено', 2500),
(3, 3, 3, '789 oak st, springfield', 500, 500000, '2010-03-10', 'построено', 5000),
(4, 4, 4, '101 pine st, capital city', 1000, 750000, '2005-11-25', 'построено', 7500),
(5, 5, 5, '202 maple st, springfield', 75, 100000, '2018-09-05', 'не построено', null),
(6, 6, 6, '333 beach st, barcelona', 200, 450000, '2015-02-18', 'построено', 3000),
(7, 7, 7, '444 river rd, rome', 100, 200000, '2018-04-22', 'построено', 2500),
(8, 8, 8, '555 mountain view, mexico city', 400, 800000, '2012-08-19', 'построено', 6000),
(9, 9, 9, '666 sunset ave, paris', 300, 600000, '2008-11-11', 'построено', 5000),
(10, 10, 10, '777 city center, london', 500, 1000000, '2020-12-25', 'не построено', null);

insert into contracts (contract_id, property_id, client_id, agent_id, start_date, end_date, contract_type)
values
(1, 1, 1, 1, '2023-01-01', '2024-01-01', 'Продажа'),
(2, 2, 2, 2, '2023-06-01', '2024-06-01', 'Продажа'),
(3, 3, 3, 3, '2022-01-15', '2023-01-15', 'Продажа'),
(4, 4, 4, 4, '2023-03-01', null, 'Продажа'),
(5, 5, 5, 5, '2023-09-01', '2024-09-01', 'Продажа'),
(6, 6, 6, 6, '2023-05-01', '2024-05-01', 'Продажа'),
(7, 7, 7, 7, '2022-06-15', '2023-06-15', 'Продажа'),
(8, 8, 8, 8, '2023-04-01', null, 'Продажа'),
(9, 9, 9, 9, '2023-07-01', '2024-07-01', 'Продажа'),
(10, 10, 10, 10, '2023-08-01', null, 'Продажа');

insert into rooms (room_id, property_id, area, room_type)
values
(1, 1, 20, 'спальня'),
(2, 1, 15, 'гостиная'),
(3, 2, 50, 'офис'),
(4, 3, 25, 'конференц-зал'),
(5, 4, 100, 'склад'),
(6, 5, 30, 'прихожая'),
(7, 6, 40, 'спальня'),
(8, 7, 35, 'гостиная'),
(9, 8, 60, 'офис'),
(10, 9, 45, 'спальня');
insert into rooms (room_id, property_id, area, room_type) values (11, 1, 100, 'спортзал');
insert into rooms (room_id, property_id, area, room_type) values (12, 1, 5000, 'бассейн');
insert into property_photos (property_photos_id, room_id, photo_url)
values
(1, 1, 'https://example.com/photos/1.jpg'),
(2, 2, 'https://example.com/photos/2.jpg'),
(3, 3, 'https://example.com/photos/3.jpg'),
(4, 4, 'https://example.com/photos/4.jpg'),
(5, 5, 'https://example.com/photos/5.jpg'),
(6, 6, 'https://example.com/photos/6.jpg'),
(7, 7, 'https://example.com/photos/7.jpg'),
(8, 8, 'https://example.com/photos/8.jpg'),
(9, 9, 'https://example.com/photos/9.jpg'),
(10, 10, 'https://example.com/photos/10.jpg');

insert into payments (payments_id, contract_id, payment_amount, date)
values
(1, 1, 1200, '2023-01-01'),
(2, 2, 2500, '2023-06-01'),
(3, 3, 5000, '2022-01-15'),
(4, 4, 7500, '2023-03-01'),
(5, 5, 1000, '2023-09-01'),
(6, 6, 3000, '2023-05-01'),
(7, 7, 4000, '2023-06-15'),
(8, 8, 3500, '2023-04-01'),
(9, 9, 2500, '2023-07-01'),
(10, 10, 2000, '2023-08-01');

insert into contracts_history (history_id, property_id, client_id, agent_id, event_type, event_date, description, field_name, old_value, new_value)
values
(1, 1, 1, 1, 'create_contract', '2023-01-01', 'первичное создание контракта', null, null, null),
(2, 2, 2, 2, 'create_contract', '2023-06-01', 'первичное создание контракта', null, null, null),
(3, 3, 3, 3, 'extend_contract', '2022-01-15', 'продление контракта на дополнительный год', null, null, null),
(4, 4, 4, 4, 'extend_contract', '2023-03-01', 'продление контракта на неопределенный срок', null, null, null);


