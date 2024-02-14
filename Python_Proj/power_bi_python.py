import pandas as pd
# import sql_conexao
# import os

    server = 'DESKTOP-CEOQIBE\SQLEXPRESS'
    database = 'DWcommerce'
    username = 'Duke'
    password = 'Duke1957'
    
    sqlconnection = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};\
                      SERVER='+server+';\
                      DATABASE='+database+';\
                      UID='+username+';\
                      PWD='+ password)  
  
# Criar e printar Dataframe ========================
venda = {'data': ['15/02/2021', '16/02/2021'],
         'valor': [500, 300],
         'produto': ['feijao', 'arroz'],
         'qtde': [50, 70],
        }
vendas_df = pd.DataFrame(venda) 
# print(vendas_df)

# Ler CSV e printar conteúdo ======================
cte_entrada = pd.read_csv('C:\GitHub\GitHub\Python_Proj\cte_entrada.csv')
# print(cte_entrada.head())

# Ler banco de dados com função de conexão externa ====
conexao = sql_conexao.sqlconnection()

query = 'SELECT FirstName FROM AdventureWorksDW2022.dbo.DimEmployee'
cursor = conexao.cursor()
cursor.execute(query)
result = cursor.fetchall()
# for row in result:
#     print(row)
# display(cursor)

