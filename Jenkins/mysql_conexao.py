import mysql.connector
def mysql_connection():
    mysqlconnection = mysql.connector.connect(
        host = '127.0.0.1',
        user = 'root',
        passwd = '@Duke1957',
        auth_plugin='mysql_native_password'
    return mysqlconnection    
    )
    