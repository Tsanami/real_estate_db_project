set search_path = real_estate, public;
-- Запрос 1: Типы недвижимости и их ранжирование по средней арендной плате
-- Выводит название типа недвижимости, среднюю арендную плату, 
-- и ранг по средней арендной плате для типов с арендной платой более 1000.
SELECT 
    pt.Name AS Property_Type_Name,
    AVG(p.Rental_Price) AS Avg_Rental_Price,
    RANK() OVER (ORDER BY AVG(p.Rental_Price) DESC) AS Rank_By_Rental_Price
FROM 
    Properties p
JOIN 
    Property_Types pt ON p.Property_Types_ID = pt.PROPERTY_TYPE_ID
GROUP BY 
    pt.Name
HAVING 
    AVG(p.Rental_Price) > 1000
ORDER BY 
    Rank_By_Rental_Price;

-- Запрос 2: Клиенты и количество их контрактов
-- Выводит ID клиента, имя, количество контрактов, 
-- ранг по количеству контрактов и процент от общего числа контрактов.
SELECT 
    c.CLIENT_ID, 
    c.Name AS Client_Name,
    COUNT(*) AS Contracts_Count,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS Rank_By_Contracts,
    COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS Percent_Of_Total
FROM 
    Contracts co
JOIN 
    Clients c ON co.Client_ID = c.CLIENT_ID
GROUP BY 
    c.CLIENT_ID, c.Name
ORDER BY 
    Rank_By_Contracts;

-- Запрос 3: Агенты и их доход
-- Выводит ID агента, имя, количество платежей, общий доход, 
-- ранг по доходу и кумулятивный доход агентов.
SELECT 
    a.AGENT_ID, 
    a.Name AS Agent_Name,
    COUNT(p.PAYMENTS_ID) AS Total_Payments,
    SUM(p.Payment_Amount) AS Total_Income,
    RANK() OVER (ORDER BY SUM(p.Payment_Amount) DESC) AS Rank_By_Income,
    SUM(SUM(p.Payment_Amount)) OVER (ORDER BY SUM(p.Payment_Amount) DESC) AS Cumulative_Income
FROM 
    Payments p
JOIN 
    Contracts c ON p.Contract_ID = c.Contract_ID
JOIN 
    Agents a ON c.Agent_ID = a.AGENT_ID
GROUP BY 
    a.AGENT_ID, a.Name
ORDER BY  
    Rank_By_Income;

-- Запрос 4: Недвижимость и ранжирование по году постройки
-- Выводит ID недвижимости, адрес, год постройки, 
-- ранг по году постройки и перцентиль по году постройки.
SELECT 
    Property_ID, 
    Address, 
    Year_Built,
    RANK() OVER (ORDER BY Year_Built ASC) AS Rank_By_Year,
    RANK() OVER (ORDER BY Year_Built ASC) * 100.0 / COUNT(*) OVER () AS Percentile_By_Year
FROM 
    Properties
ORDER BY 
    Rank_By_Year;

-- Запрос 5: Комнаты и их анализ по площади
-- Выводит ID недвижимости, максимальную, минимальную и среднюю площадь комнат, 
-- количество комнат и ранг по средней площади комнат для недвижимости с более чем 3 комнатами.
SELECT 
    r.Property_ID,
    MAX(r.Area) AS Max_Room_Area,
    MIN(r.Area) AS Min_Room_Area,
    AVG(r.Area) AS Avg_Room_Area,
    COUNT(r.Room_ID) AS Room_Count,
    RANK() OVER (ORDER BY AVG(r.Area) DESC) AS Rank_By_Avg_Area
FROM 
    Rooms r
GROUP BY 
    r.Property_ID
HAVING 
    COUNT(r.Room_ID) > 3
ORDER BY 
    Rank_By_Avg_Area;
