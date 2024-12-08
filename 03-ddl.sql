CREATE SCHEMA IF NOT EXISTS real_estate;
SET search_path = real_estate, public;

DROP TABLE IF EXISTS Property_Photos CASCADE;
DROP TABLE IF EXISTS Rooms CASCADE;
DROP TABLE IF EXISTS Payments CASCADE;
DROP TABLE IF EXISTS Contracts_History CASCADE;
DROP TABLE IF EXISTS Contracts CASCADE;
DROP TABLE IF EXISTS Properties CASCADE;
DROP TABLE IF EXISTS Property_Types CASCADE;
DROP TABLE IF EXISTS Owners CASCADE;
DROP TABLE IF EXISTS Clients CASCADE;
DROP TABLE IF EXISTS Agents CASCADE;

CREATE TABLE Property_Types 
(
    PROPERTY_TYPE_ID serial PRIMARY KEY NOT NULL,
    Name VARCHAR(100) NOT NULL UNIQUE,
    Description TEXT
);

CREATE TABLE Owners 
(
    Owner_ID serial PRIMARY KEY NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(100) NOT NULL,
    Country VARCHAR(100) NOT NULL
);

CREATE TABLE Clients 
(
    CLIENT_ID serial PRIMARY KEY NOT NULL,
    Name TEXT NOT NULL,
    Email TEXT NOT NULL UNIQUE,
    Phone VARCHAR(100) NOT NULL
);

CREATE TABLE Agents 
(
    AGENT_ID serial PRIMARY KEY NOT NULL,
    Name TEXT NOT NULL,
    Email TEXT NOT NULL UNIQUE,
    Phone TEXT NOT NULL UNIQUE
);

CREATE TABLE Properties
(
    Property_ID serial PRIMARY KEY NOT NULL,
    Property_Types_ID INTEGER NOT NULL,
    Owner_ID INTEGER DEFAULT NULL,
    Address TEXT NOT NULL,
    Area INTEGER CHECK (Area > 0),
    Price INTEGER CHECK (Price > 0),
    Year_Built DATE CHECK (Year_Built <= CURRENT_DATE),
    Status VARCHAR(100) NOT NULL,
    Rental_Price INTEGER CHECK (Rental_Price >= 0),
    CONSTRAINT CHK_Status CHECK (Status IN ('построено', 'не построено')),
    FOREIGN KEY (Property_Types_ID) REFERENCES Property_Types (PROPERTY_TYPE_ID),
    FOREIGN KEY (Owner_ID) REFERENCES Owners (Owner_ID)
);

CREATE TABLE Contracts 
(
    Contract_ID serial PRIMARY KEY NOT NULL,
    Property_ID INTEGER NOT NULL,
    Client_ID INTEGER NOT NULL,
    Agent_ID INTEGER NOT NULL,
    Start_Date DATE NOT NULL,
    End_Date DATE,
    Contract_Type VARCHAR(50) NOT NULL DEFAULT 'Аренда',
    CONSTRAINT CHK_ContractType CHECK (Contract_Type IN ('Аренда', 'Продажа')),
    CONSTRAINT CHK_Dates CHECK (End_Date IS NULL OR End_Date > Start_Date),
    FOREIGN KEY (Property_ID) REFERENCES Properties (Property_ID),
    FOREIGN KEY (Client_ID) REFERENCES Clients (CLIENT_ID),
    FOREIGN KEY (Agent_ID) REFERENCES Agents (AGENT_ID)
);

CREATE TABLE Rooms 
(
    Room_ID serial PRIMARY KEY NOT NULL,
    Property_ID INTEGER NOT NULL,
    Area INTEGER CHECK (Area > 0),
    Room_Type TEXT NOT NULL,
    FOREIGN KEY (Property_ID) REFERENCES Properties (Property_ID)
);

CREATE TABLE Property_Photos 
(
    PROPERTY_PHOTOS_ID serial PRIMARY KEY NOT NULL,
    Room_ID INTEGER NOT NULL,
    Photo_URL TEXT NOT NULL,
    FOREIGN KEY (Room_ID) REFERENCES Rooms (Room_ID)
);

CREATE TABLE Payments 
(
    PAYMENTS_ID serial PRIMARY KEY NOT NULL,
    Contract_ID INTEGER NOT NULL,
    Payment_Amount INTEGER CHECK (Payment_Amount > 0),
    Date DATE NOT NULL,
    FOREIGN KEY (Contract_ID) REFERENCES Contracts (Contract_ID)
	ON DELETE CASCADE
	ON UPDATE CASCADE;
);

CREATE TABLE Contracts_History 
(
    HISTORY_ID serial PRIMARY KEY NOT NULL,
    Property_ID INTEGER NOT NULL,
    Client_ID INTEGER NOT NULL,
    Agent_ID INTEGER NOT NULL,
    Event_Type VARCHAR(100) NOT NULL,
    Event_Date DATE NOT NULL,
    Description TEXT,
    Field_Name VARCHAR(100),
    Old_Value TEXT,
    New_Value TEXT,
    CONSTRAINT CHK_EventType CHECK (Event_Type IN ('create_contract', 'update_contract', 'delete_contract', 'extend_contract')),
    FOREIGN KEY (Property_ID) REFERENCES Properties (Property_ID),
    FOREIGN KEY (Client_ID) REFERENCES Clients (CLIENT_ID),
    FOREIGN KEY (Agent_ID) REFERENCES Agents (AGENT_ID)
);
