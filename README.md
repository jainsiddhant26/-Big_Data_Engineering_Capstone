# Big Data Engineering Capstone

## Business Scenario

You have been hired as a new data engineer at Analytixlabs. Your first major task is to work on data engineering project for one of the 
big corporation’s employees data from the 1980s and 1995s. All the database of employees from that period are provided six CSV files. 
In this project, you will design data model with all the tables to hold data, import the CSVs into a SQL database, 
transfer SQL database to HDFS/Hive, and perform analysis using Hive/Impala/Spark/SparkML using the data and create data and ML pipelines.

## Project Objectives:

Generation of data model from the data provided. Creation of database & tables in MySQL server based on the ER Diagram. Transfer the data from MySQL to HDFS by creating of Sqoop job. Database creation in Hive and load data into it based onn the ER diagram. Work on Exploratory data analysis as per the analysis requirement using Impala and Spark SQL. Build ML Model as per the requirement. Creation of data pipeline and ML pipe line.
The entire data is contained in the /csv folder which contains a total of 6 files:

- titles.csv -> This file contains the different job titles of the employees.
- employees.csv -> Contains all data related to each employee, such as employee id, name, age,sex, date of hiring, etc.
- salaries.csv -> contains salary of each employee.
- departments.csv -> enlists the various departments in the company.
- dept_manager.csv -> indicates which employee manages which department.
- dept_emp.csv -> indicates wich department each employee belongs to.

## Data Flow Description

- All csv given by the client were upload to a Linux based cloud system.
- All the csv were converted into SQL database tables with following attributes as mentioned in slide 5 and 6.
- Sqoop as a middleware we transferred all Tables data as Avro files into HDFS 
- HDFS (copyFromLocal) we transferred Avro Schema files to hdfs 
- We created Hive tables and loaded Avro files data into it
- Then using Hive tables we performed EDA in Impala and Spark SQL
- Using Pyspark Dataframes we did ML Model Building 
- And created ML Pipelines


