# MihaiSurvey Application

This application is an ASP.NET MVC 5 application created with Visual Studio 2013. It uses a SQL Server 2012 database to store data. 

It can be deployed on premise or on any cloud provider. To see a live demo please visit https://mihaisurvey.azurewebsites.net/ 

For this demo I have deployed the application on Azure App Services and created an Azure SQL Database.

# Build the Application

To build the application please download all files, open the solution with Visual Studio 2013 or later, restore the packages and build the solution.

To create the database please run MihaiSurveyDB_SchemaAndData.sql script from Mihai.Survey.SqlScripts folder. 

Please change the database connection string in the web.config file and then you can run the application from Visual Studio using IIS Express or IIS in your local computer.

# Deploy the Application

To deploy the application please publish the application from Visual Studio to create the deployment package, then create an IIS web site in any server and restore the deployment package.

To create the application database please connect to any SQL Server 2012 or later and run MihaiSurveyDB_SchemaAndData.sql script.

Please change the database connection string in the web.config file.
