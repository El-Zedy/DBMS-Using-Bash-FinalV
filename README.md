# Bash Shell Script Database Management System (DBMS)
This project is a CLI-based Database Management System developed in Bash Shell Script. The aim of this project is to enable users to store and retrieve data from their hard drive using a simple and easy-to-use interface.

## Project Features
The application provides a main menu that allows the user to perform the following actions:

- Create a new database
- List all existing databases
- Connect to a specific database
- Drop a database

Upon connecting to a specific database, the user will be presented with a new screen that provides the following options:

- Create a new table
- List all existing tables
- Drop a table
- Insert data into a table
- Select data from a table
- Delete data from a table
- Update data in a table

The following are some additional details regarding the project:

- Databases will be stored as directories in the same location as the script file
- Rows returned from a SELECT statement will be displayed on the terminal in an accepted/good format
- The script will ask about column datatypes when creating a new table, and will check for them when inserting or updating data
- The script will also ask about a primary key when creating a new table, and will check for its existence when inserting data into the table

## Getting Started
To use this project, you will need to clone the repository to your local machine using the following command:

     git clone https://github.com/El-Zedy/DBMS-Using-Bash-FinalV.git
  
Once you have cloned the repository, navigate to the project directory using the terminal and run the script using the following command:

    ./master.sh
  
This will launch the CLI interface, and you will be presented with the main menu.

## Contributing
If you would like to contribute to this project, please fork the repository and make your changes. Once you have made your changes, submit a pull request and the project owner will review your changes.

## Contact
If you have any questions or suggestions regarding this project, please contact the project owner at muhammadhassanelzedy@gmail.com .
