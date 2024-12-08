set search_path = real_estate, public;
-- Функция для логгирования изменений в контракте
CREATE OR REPLACE FUNCTION version_contract()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Contracts_History (
        Property_ID, 
        Client_ID, 
        Agent_ID, 
        Event_Type, 
        Event_Date, 
        Description, 
        Field_Name, 
        Old_Value, 
        New_Value
    )
    VALUES (
        OLD.Property_ID,
        OLD.Client_ID,
        OLD.Agent_ID,
        'update_contract',
        CURRENT_DATE,
        'Versioning: contract updated',
        NULL,
        ROW(OLD.*)::TEXT, -- Сохраняем старую строку целиком
        ROW(NEW.*)::TEXT  -- Сохраняем новую строку целиком
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Триггер для версионности в таблице Contracts
CREATE TRIGGER trigger_version_contract
AFTER UPDATE ON Contracts
FOR EACH ROW
EXECUTE FUNCTION version_contract();

--Если цена аренды (rental_price) отсутствует при добавлении недвижимости, установить ее как 5% от общей стоимости (price).
CREATE OR REPLACE FUNCTION set_default_rental_price()
RETURNS TRIGGER AS $$
BEGIN
    IF (NEW.rental_price IS NULL) THEN
        NEW.rental_price := NEW.price * 0.05;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_rental_price_trigger
BEFORE INSERT ON properties
FOR EACH ROW EXECUTE FUNCTION set_default_rental_price();

-- CREATE TABLE Properties_History (
--     Version_ID SERIAL PRIMARY KEY,
--     Property_ID INTEGER NOT NULL,
--     Property_Types_ID INTEGER NOT NULL,
--     Owner_ID INTEGER,
--     Address TEXT NOT NULL,
--     Area INTEGER,
--     Price INTEGER,
--     Year_Built DATE,
--     Status VARCHAR(100),
--     Rental_Price INTEGER,
--     Version_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--     Operation_Type VARCHAR(50) CHECK (Operation_Type IN ('INSERT', 'UPDATE', 'DELETE'))
-- );
