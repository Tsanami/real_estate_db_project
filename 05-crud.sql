set search_path = real_estate, public;
--Таблица Clients

--Добавление клиента
INSERT INTO Clients (CLIENT_ID, Name, Email, Phone)
VALUES (11, 'Иван Иванов', 'ivan.ivanov@example.com', '+79876543210');

--Получение списка всех клиентов
SELECT * FROM Clients;

--Обновление данных клиента
UPDATE Clients
SET Email = 'ivan.newemail@example.com', Phone = '+79991112233'
WHERE CLIENT_ID = 11;

--Удаление клиента
DELETE FROM Clients
WHERE CLIENT_ID = 11;


--Таблица Contracts

--Добавление контракта
INSERT INTO Contracts (Contract_ID, Property_ID, Client_ID, Agent_ID, Start_Date, End_Date, Contract_Type)
VALUES 
(11, 10, 10, 10, '2024-01-01', '2024-12-31', 'Аренда');

--Получение всех контрактов
SELECT 
    Contract_ID AS "ID контракта", 
    Property_ID AS "ID объекта", 
    Client_ID AS "ID клиента", 
    Agent_ID AS "ID агента", 
    Start_Date AS "Дата начала", 
    End_Date AS "Дата окончания", 
    Contract_Type AS "Тип контракта"
FROM 
    Contracts;

--Обновление типа контракта
UPDATE Contracts
SET Contract_Type = 'Продажа', End_Date = NULL
WHERE Contract_ID = 1;

--Удаление контракта
DELETE FROM Contracts
WHERE Contract_ID = 1;
