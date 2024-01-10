import pandas as pd
import mysql_conexao

venda = {'data': ['15/02/2021', '16/02/2021'],
         'valor': [500, 300],
         'produto': ['feijao', 'arroz'],
         'qtde': [50, 70],
        }
vendas_df = pd.DataFrame(venda) 
print(vendas_df)

cte_entrada = pd.read_csv('Jenkins/cte_entrada.csv')
print(cte_entrada.head())

conexao = mysql_conexao.mysql_connection()
query = '''
    SELECT * FROM dbProjetos.tbTeste
'''
cursor = conexao.cursor()
cursor.execute(query)
result = cursor.fetchall()
for row in result:
    print(row)

print('Teste com sucesso')