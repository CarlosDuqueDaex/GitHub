import pandas as pd
import mysql_conexao
import os

# Criar e printar Dataframe ========================
venda = {'data': ['15/02/2021', '16/02/2021'],
         'valor': [500, 300],
         'produto': ['feijao', 'arroz'],
         'qtde': [50, 70],
        }
vendas_df = pd.DataFrame(venda) 
print(vendas_df)

# Ler CSV e printar conteúdo ======================
cte_entrada = pd.read_csv('Jenkins/cte_entrada.csv')
print(cte_entrada.head())

# Ler banco de dados Mysql com função de conexão externa ====
conexao = mysql_conexao.mysql_connection()
query = '''
    SELECT * FROM dbProjetos.tbTeste
'''
cursor = conexao.cursor()
cursor.execute(query)
result = cursor.fetchall()
for row in result:
    print(row)

# Input e print de entrada pelo teclado
# nome = input("Escreva seu nome: ")
# print('Seu nome é:', nome)

arquivo = os.environ['ArquivoCSV']
print(arquivo)

print('Teste com sucesso')