import pyodbc
def sql_connection():
    server = 'DESKTOP-CEOQIBE\SQLEXPRESS'
    database = 'DWcommerce'
    username = 'Duke'
    password = 'Duke1957'
    
    sqlconnection = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};\
                      SERVER='+server+';\
                      DATABASE='+database+';\
                      UID='+username+';\
                      PWD='+ password)  
  
    return sqlconnection    