import sqlalchemy
from sqlalchemy import create_engine, Column, Integer, String, text
from sqlalchemy.orm import sessionmaker
from sqlalchemy.orm import declarative_base
login = 'postgres'
password = open('password').readline()
engine = create_engine(f'postgresql://{login}:{password}@localhost/postgres')

with engine.connect() as connection:
    connection.execute(text('set search_path = real_estate'))

base = declarative_base()

"""CREATE TABLE Clients 
(
    CLIENT_ID serial PRIMARY KEY NOT NULL,
    Name TEXT NOT NULL,
    Email TEXT NOT NULL UNIQUE,
    Phone VARCHAR(100) NOT NULL
);"""

class Clients(base):
    __tablename__ = 'clients'
    __table_args__ = {'schema': 'real_estate'}
    client_id = Column(Integer, primary_key=True)
    name = Column(String)
    email = Column(String)
    phone = Column(sqlalchemy.VARCHAR)

# create session
Session = sessionmaker(bind=engine)
session = Session()

# insert new client
new_client = Clients(client_id = 11, name='Vyacheslave Gorihovsky', email='gorihovskyvyacheslav@gmail.com', phone='777')
session.add(new_client)
session.commit()

# update a client
client_to_update = session.query(Clients).filter_by(name = 'Vyacheslave Gorihovsky').first()
client_to_update.phone = '42'
session.commit()

# delete a client
client_to_delete = session.query(Clients).filter(Clients.name == 'Vyacheslave Gorihovsky').first()
session.delete(client_to_delete)
session.commit()

# select clients
clients = session.query(Clients).filter(Clients.name.like('V%')).all()
for client in clients:
    print(client.name, client.email, client.phone)


# execute task 6
with open('06-selects.sql', 'r') as file:
    analytics_queries = file.read()
queries = [query.strip() for query in analytics_queries.split(';') if query.strip()]
with engine.connect() as connection:
    for i, query in enumerate(queries):
        print(f"ЗАПРОС {i}")
        try:
            result = connection.execute(text(query))
            if result.returns_rows:
                for row in result:
                    print(row)
        except Exception as e:
            print(f"Ошибка при выполнении запроса: {e}")