set search_path = real_estate, public;
--Статистика аренды и продаж объектов недвижимости
--показывает сводную информацию об объектах недвижимости,
--включая тип объекта, адрес, владельца, клиента, агента и тип контракта. 

CREATE OR REPLACE VIEW Rent_Sale_Statistics AS
SELECT 
    c.Contract_ID AS "ID контракта",
    p.Property_ID AS "ID объекта",
    pt.Name AS "Тип объекта",
    p.Address AS "Адрес",
    o.Name AS "Владелец",
    cl.Name AS "Клиент",
    a.Name AS "Агент",
    c.Contract_Type AS "Тип контракта",
    c.Start_Date AS "Дата начала",
    c.End_Date AS "Дата окончания"
FROM 
    Contracts c
JOIN 
    Properties p ON c.Property_ID = p.Property_ID
JOIN 
    Property_Types pt ON p.Property_Types_ID = pt.PROPERTY_TYPE_ID
LEFT JOIN 
    Owners o ON p.Owner_ID = o.Owner_ID
JOIN 
    Clients cl ON c.Client_ID = cl.CLIENT_ID
JOIN 
    Agents a ON c.Agent_ID = a.AGENT_ID;


--Общий доход от аренды и продаж
--Это представление рассчитывает общий доход от аренды и продаж для каждого объекта недвижимости.

CREATE OR REPLACE VIEW Revenue_Statistics AS
SELECT 
    p.Property_ID AS "ID объекта",
    pt.Name AS "Тип объекта",
    p.Address AS "Адрес",
    SUM(py.Payment_Amount) AS "Общий доход",
    COUNT(DISTINCT c.Contract_ID) AS "Количество контрактов",
    MAX(c.Contract_Type) AS "Последний тип контракта"
FROM 
    Payments py
JOIN 
    Contracts c ON py.Contract_ID = c.Contract_ID
JOIN 
    Properties p ON c.Property_ID = p.Property_ID
JOIN 
    Property_Types pt ON p.Property_Types_ID = pt.PROPERTY_TYPE_ID
GROUP BY 
    p.Property_ID, pt.Name, p.Address;


--Площади и средняя стоимость недвижимости по типам объектов
--Это представление группирует недвижимость по типам и
--отображает общую площадь, среднюю стоимость и количество объектов для каждого типа.

CREATE OR REPLACE VIEW Property_Area_Price_Statistics AS
SELECT 
    pt.Name AS "Тип объекта",
    COUNT(p.Property_ID) AS "Количество объектов",
    SUM(p.Area) AS "Общая площадь (м²)",
    AVG(p.Price) AS "Средняя стоимость (руб)",
    AVG(p.Rental_Price) AS "Средняя арендная стоимость (руб)"
FROM 
    Properties p
JOIN 
    Property_Types pt ON p.Property_Types_ID = pt.PROPERTY_TYPE_ID
GROUP BY 
    pt.Name
ORDER BY 
    "Средняя стоимость (руб)" DESC;

