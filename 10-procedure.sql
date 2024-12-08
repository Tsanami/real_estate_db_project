--Процедура для обновления стоимости аренды

CREATE OR REPLACE PROCEDURE UpdateRentalPriceByContract(
    IN p_contract_id INTEGER,
    IN p_new_rental_price INTEGER
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_property_id INTEGER;
BEGIN
    SELECT Property_ID INTO v_property_id
    FROM Contracts
    WHERE Contract_ID = p_contract_id;

    IF v_property_id IS NULL THEN
        RAISE EXCEPTION 'Контракт с ID % не найден', p_contract_id;
    END IF;

    IF p_new_rental_price <= 0 THEN
        RAISE EXCEPTION 'Новая стоимость аренды должна быть больше 0.';
    END IF;

    UPDATE Properties
    SET Rental_Price = p_new_rental_price
    WHERE Property_ID = v_property_id
      AND Rental_Price IS DISTINCT FROM p_new_rental_price;
END;
$$;


--Продление срока действия договора

CREATE OR REPLACE PROCEDURE ExtendContract(
    IN p_contract_id INTEGER,
    IN p_new_end_date DATE
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_old_end_date DATE;
BEGIN
    SELECT End_Date INTO v_old_end_date
    FROM Contracts
    WHERE Contract_ID = p_contract_id;

    IF v_old_end_date IS NULL THEN
        RAISE EXCEPTION 'Договор с ID % не найден', p_contract_id;
    END IF;

    IF p_new_end_date <= v_old_end_date THEN
        RAISE EXCEPTION 'Новая дата окончания должна быть позже текущей даты окончания (%).', v_old_end_date;
    END IF;

    UPDATE Contracts
    SET End_Date = p_new_end_date
    WHERE Contract_ID = p_contract_id;
END;
$$;
