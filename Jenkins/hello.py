import pandas as pd
from mysql.connector import connect

venda = {'data': ['15/02/2021', '16/02/2021'],
         'valor': [500, 300],
         'produto': ['feijao', 'arroz'],
         'qtde': [50, 70],
        }
vendas_df = pd.DataFrame(venda) 
print(vendas_df)

cte_entrada = pd.read_csv('Jenkins/cte_entrada.csv')
print(cte_entrada.head())

def mysql_connection(host, user, passwd, database=None):
    connection = connect(
        host = host,
        user = user,
        passwd = passwd,
        database = database
    )
    return connection

connection = mysql_connection('195.35.16.111', 'root', 'Duke1957')
query = '''
    SELECT * FROM dbProjetos.tbTeste
'''
cursor = connection.cursor()
cursor.execute(query)
result = cursor.fetchall()
for row in result:
    print(row)

print('Teste com sucesso')