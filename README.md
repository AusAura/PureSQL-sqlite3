# PureSQL+sqlite3
Generates fake data to the SQLite3 DB, then executes a series of pure SQL scripts (from 1 to 13) with queries to the fake data.

1) When main.py executed, asks if you want to re-generate the database.

2) **If yes**, then re-creates a new SQLite3 DB from the 'script.sql' file.
3) Then generates fake data with 'Faker'. Uses 'groups' and 'subjects' lists during the process.
4) Converts the data to the format that is suitable for the upload to the DB. For example, adds random date for each mark.
5) Uploads everything by replacing values in the pre-set SQL queries.
6) Finishes

7) **If no**, runs all available scripts that are named by the template.
8) Scripts are filled with the pure SQL queries for the fake data.
