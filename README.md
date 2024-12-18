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
