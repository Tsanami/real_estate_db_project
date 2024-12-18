# Customizable Database for real estate analytics and accounting. 

Создание базы данных для ведеения аналитики и учета недвижимости в рамках осеннего проекта, ПАДИИ ВШЭ СПб, осень 2024  
Предментная область - недвижимость  
# Структура проекта  
├── 1 - основные сущности модели   
├── 2a - концептуальная модель  
├── 2b - логическая модель  
├── 2c - физическая модель  
║  
├── 3 - создание таблиц и схемы   
├── 4 - заполнение таблиц   
├── 5 - CRUD-запросы (INSERT, SELECT, UPDATE, DELETE)   
├── 6 - смысловые запросы (GROUP BY + HAVING, ORDER BY, оконные функции)   
├── 7 - представления под каждую таблицу   
├── 8 - 3 сложных представления   
├── 9 - 2 триггера   
├── 10 - 2 процедуры   
├── 11 - python - ORM   

Концептуальная модель
<img width="880" alt="Screenshot 2024-12-18 at 20 03 08" src="https://github.com/user-attachments/assets/57a3e575-360c-4b7f-b192-b2ffbc8d57f6" />  
Факт -- договоры (contracts), все остальное -- измерения

Логическая модель  
<img width="882" alt="Screenshot 2024-12-18 at 20 20 30" src="https://github.com/user-attachments/assets/8c294af6-864b-4c2b-8e01-c07b19fe79f5" />  

Присутствует таблица history для отслеживания различных операций, изменений

# Описание таблицы `Properties` (Недвижимость)

| Тип    | Название поля           | Описание                       | Тип данных       | Ограничения                        |
|--------|-------------------------|--------------------------------|------------------|------------------------------------|
| **PK** | `Property_ID`           | Идентификатор недвижимости     | `INTEGER`        | `NOT NULL`                        |
| **FK** | `Property_Types_ID`     | Идентификатор вида недвижимости | `VARCHAR(100)`   | `NOT NULL`                        |
| **FK** | `Owner_ID`              | Идентификатор владельца        | `INTEGER`        | `NOT NULL`                        |
|        | `Address`               | Адрес недвижимости             | `TEXT`           |                                    |
|        | `Area`                  | Площадь недвижимости           | `INTEGER`        | `CHECK (Area >= 0)`               |
|        | `Price`                 | Цена                           | `INTEGER`        | `CHECK (Price >= 0)`              |
|        | `Year_Built`            | Год постройки                  | `DATE`           |                                    |
|        | `Status`                | Построена или нет              | `VARCHAR(100)`   |                                    |
|        | `Rental_Price`          | Стоимость аренды               | `INTEGER`        | `CHECK (Rental_Price >= 0)`       |


---

## **Owners (Владельцы)**
| Column Name      | Description               | Data Type   | Constraints   |
|------------------|---------------------------|-------------|---------------|
| **Owner_ID**     | Идентификатор владельца   | INTEGER     | PK, NOT NULL  |
| **Name**         | ФИО владельца            | VARCHAR(100)| NOT NULL      |
| **Email**        | Почта владельца          | VARCHAR(100)|               |
| **Phone**        | Номер телефона           | VARCHAR(100)|               |
| **Country**      | Страна                   | VARCHAR(100)|               |

---

## **Contracts (Договоры)**
| Column Name       | Description                       | Data Type   | Constraints     |
|-------------------|-----------------------------------|-------------|-----------------|
| **Contract_ID**   | Идентификатор договора           | INTEGER     | PK, NOT NULL    |
| **Property_ID**   | Идентификатор недвижимости       | INTEGER     | FK, NOT NULL    |
| **Client_ID**     | Идентификатор клиента            | INTEGER     | FK, NOT NULL    |
| **Agent_ID**      | Идентификатор агента (риэлтор)   | INTEGER     | FK, NOT NULL    |
| **Start_Date**    | Дата начала действия договора    | DATE        | NOT NULL        |
| **End_Date**      | Дата окончания действия договора | DATE        |                 |

---

## **Property_Types (Типы недвижимости)**
| Column Name         | Description                  | Data Type   | Constraints   |
|---------------------|------------------------------|-------------|---------------|
| **Property_Type_ID**| Идентификатор типа недвижимости | INTEGER | PK, NOT NULL  |
| **Name**            | Название типа недвижимости   | VARCHAR(100)| NOT NULL      |
| **Description**     | Описание                    | TEXT        |               |

---

## **Clients (Клиенты)**
| Column Name      | Description       | Data Type   | Constraints   |
|------------------|-------------------|-------------|---------------|
| **Client_ID**    | Идентификатор клиента | INTEGER | PK, NOT NULL  |
| **Name**         | ФИО               | TEXT        | NOT NULL      |
| **Email**        | Почта             | TEXT        |               |
| **Phone**        | Телефон           | VARCHAR(100)|               |

---

## **Rooms (Комнаты)**
| Column Name      | Description                  | Data Type   | Constraints               |
|------------------|------------------------------|-------------|---------------------------|
| **Room_ID**      | Идентификатор комнаты        | INTEGER     | PK, NOT NULL              |
| **Property_ID**  | Идентификатор недвижимости   | INTEGER     | FK, NOT NULL              |
| **Area**         | Площадь (м^2)               | INTEGER     | CHECK (Area >= 0)         |
| **Room_Type**    | Тип комнаты                  | TEXT        |                           |

---

## **Property_Photos (Фотографии недвижимости)**
| Column Name          | Description                  | Data Type   | Constraints     |
|----------------------|------------------------------|-------------|-----------------|
| **Property_Photos_ID**| Идентификатор фотографии    | INTEGER     | PK, NOT NULL    |
| **Room_ID**          | Ссылка на комнату           | INTEGER     | FK, NOT NULL    |
| **Photo_URL**        | Ссылка на фотографию        | TEXT        | NOT NULL        |

---

## **Payments (Платежи)**
| Column Name       | Description                | Data Type   | Constraints             |
|-------------------|----------------------------|-------------|-------------------------|
| **Payments_ID**   | Идентификатор платежа      | INTEGER     | PK, NOT NULL            |
| **Contract_ID**   | Идентификатор договора     | INTEGER     | FK, NOT NULL            |
| **Payment_Amount**| Сумма перевода             | INTEGER     | CHECK (Payment_Amount >= 0) |
| **Date**          | Дата перевода              | DATE        | NOT NULL                |

---

## **Contracts_History (История договоров)**
| Column Name       | Description                         | Data Type   | Constraints     |
|-------------------|-------------------------------------|-------------|-----------------|
| **History_ID**    | Идентификатор истории              | INTEGER     | PK, NOT NULL    |
| **Property_ID**   | Идентификатор недвижимости         | INTEGER     | FK, NOT NULL    |
| **Client_ID**     | Идентификатор клиента              | INTEGER     | FK, NOT NULL    |
| **Agent_ID**      | Идентификатор агента               | INTEGER     | FK, NOT NULL    |
| **Event_Type**    | Тип события (e.g., create_contract)| VARCHAR(100)|                 |
| **Event_Date**    | Дата события                      | DATE        | NOT NULL        |
| **Description**   | Описание события                  | TEXT        |                 |
| **Field_Name**    | Отслеживание изменения по полям    | VARCHAR(100)|                 |
| **Old_Value**     | Предыдущее значение поля           | TEXT        |                 |
| **New_Value**     | Новое значение поля               | TEXT        |                 |

---

## **Agents (Риелторы)**
| Column Name      | Description            | Data Type   | Constraints   |
|------------------|------------------------|-------------|---------------|
| **Agent_ID**     | Идентификатор риелтора | INTEGER     | PK, NOT NULL  |
| **Name**         | Полное имя риелтора   | TEXT        | NOT NULL      |
| **Email**        | Почта риелтора         | TEXT        |               |
| **Phone**        | Телефон риелтора       | TEXT        |               |

---
