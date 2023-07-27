CREATE DATABASE IF NOT EXISTS credit_card_classification;
USE credit_card_classification; -- Create a database called credit_card_classification.
CREATE TABLE credit_card_data (
customer_number INT,
offer_accepted VARCHAR(255) NOT NULL,
reward VARCHAR(255) NOT NULL,
mailer_type VARCHAR(255) NOT NULL,
income_level VARCHAR(255) NOT NULL,
bank_accounts_open INT,
overdraft_protection VARCHAR(255) NOT NULL,
credit_rating VARCHAR(255) NOT NULL,
credit_cards_held INT,
homes_owned INT,
household_size INT,
home_owner VARCHAR(255) NOT NULL,
average_balance FLOAT,
balance_Q1 FLOAT,
balance_Q2 FLOAT,
balance_Q3 FLOAT,
balance_Q4 FLOAT,
PRIMARY KEY (customer_number)
); -- Create a table credit_card_data with the same columns as given in the csv file. Please make sure you use the correct data types for each of the columns.
SELECT * FROM credit_card_data; -- data for the table was imported throug 'import wizard' 4. Select all the data from table credit_card_data to check if the data was imported correctly.
ALTER TABLE credit_card_data DROP COLUMN balance_q4;
SELECT * FROM credit_card_data LIMIT 10; -- Use the alter table command to drop the column q4_balance from the database, as we would not use it in the analysis with SQL. Select all the data from the table to verify if the command worked. Limit your returned results to 10.
SELECT COUNT(*) AS rows_amount FROM credit_card_data; -- Use sql query to find how many rows of data you have.
SELECT DISTINCT offer_accepted FROM credit_card_data; -- What are the unique values in the column Offer_accepted
SELECT DISTINCT reward FROM credit_card_data; -- What are the unique values in the column Reward?
SELECT DISTINCT mailer_type FROM credit_card_data; -- What are the unique values in the column mailer_type?
SELECT DISTINCT credit_cards_held FROM credit_card_data ORDER BY credit_cards_held; -- What are the unique values in the column credit_cards_held?
SELECT DISTINCT household_size FROM credit_card_data ORDER BY household_size; -- What are the unique values in the column household_size
SELECT customer_number FROM credit_card_data ORDER BY average_balance DESC LIMIT 10; -- Arrange the data in a decreasing order by the average_balance of the customer. Return only the customer_number of the top 10 customers with the highest average_balances in your data.
SELECT ROUND(AVG(average_balance), 1) AS average_balance FROM credit_card_data; -- What is the average balance of all the customers in your data?
select income_level, ROUND(AVG(average_balance), 1) AS avg_balance
FROM credit_card_data GROUP BY income_level; -- What is the average balance of the customers grouped by Income Level? The returned result should have only two columns, income level and Average balance of the customers. Use an alias to change the name of the second column.
SELECT bank_accounts_open, ROUND(AVG(average_balance), 1) AS avg_balance
FROM credit_card_data GROUP BY bank_accounts_open; -- What is the average balance of the customers grouped by number_of_bank_accounts_open? The returned result should have only two columns, number_of_bank_accounts_open and Average balance of the customers. Use an alias to change the name of the second column
SELECT credit_rating, ROUND(AVG(credit_cards_held), 1) AS avg_cards_amount
FROM credit_card_data GROUP BY credit_rating; -- What is the average number of credit cards held by customers for each of the credit card ratings? The returned result should have only two columns, rating and average number of credit cards held. Use an alias to change the name of the second column.
SELECT bank_accounts_open, ROUND(AVG(credit_cards_held), 1) as avg_cards_amount
FROM credit_card_data GROUP BY bank_accounts_open; -- Is there any correlation between the columns credit_cards_held and number_of_bank_accounts_open? You can analyse this by grouping the data by one of the variables and then aggregating the results of the other column. Visually check if there is a positive correlation or negative correlation or no correlation between the variables
SELECT * FROM credit_card_data WHERE (credit_rating = 'medium' OR credit_rating = 'high') AND
credit_cards_held <= 2 AND
home_owner = 'yes' AND
household_size >= 3; -- QUESTION 11
SELECT customer_number, average_balance
FROM credit_card_data WHERE average_balance < (SELECT AVG(average_balance) FROM credit_card_data); -- Your managers want to find out the list of customers whose average balance is less than the average balance of all the customers in the database. Write a query to show them the list of such customers. You might need to use a subquery for this problem.
CREATE VIEW low_balance_customers AS SELECT customer_number, average_balance
FROM credit_card_data WHERE average_balance < (SELECT AVG(average_balance) FROM credit_card_data);
SELECT credit_rating, ROUND(AVG(average_balance), 1) AS avg_balance
FROM credit_card_data
WHERE credit_rating = 'High' OR credit_rating = 'Low' 
GROUP BY credit_rating; -- Your managers are more interested in customers with a credit rating of high or medium. What is the difference in average balances of the customers with high credit card rating and low credit card rating?
SELECT * 
FROM
(SELECT *,
DENSE_RANK() OVER(ORDER BY balance_Q1 ASC) AS Q1_balance_ranking
FROM credit_card_data) AS ranked_data
WHERE Q1_balance_ranking = 11; -- Provide the details of the customer that is the 11th least Q1_balance in your database.