function conn = dbcon( )

%# JDBC connector path
javaaddpath('C:\Program Files\MATLAB\R2011a\mysql-connector-java-5.0.8\mysql-connector-java-5.0.8-bin.jar');
%# connection parameteres
host = 'localhost'; %MySQL hostname
user = 'root'; %MySQL username
password ='';%MySQL password
dbName = 'ethiocarplate'; %MySQL database name
%# JDBC parameters
jdbcString = sprintf('jdbc:mysql://%s/%s', host, dbName);
jdbcDriver = 'com.mysql.jdbc.Driver';

%# Create the database connection object
conn = database(dbName, user , password, jdbcDriver, jdbcString);