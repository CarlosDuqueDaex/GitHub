import pandas as pd
from mysql_conexao import mysql_connection

venda = {'data': ['15/02/2021', '16/02/2021'],
         'valor': [500, 300],
         'produto': ['feijao', 'arroz'],
         'qtde': [50, 70],
        }
vendas_df = pd.DataFrame(venda) 
print(vendas_df)

cte_entrada = pd.read_csv('Jenkins/cte_entrada.csv')
print(cte_entrada.head())

query = '''
    SELECT * FROM dbProjetos.tbTeste
'''
cursor = mysqlconnection.cursor()
cursor.execute(query)
result = cursor.fetchall()
for row in result:
    print(row)

print('Teste com sucesso')