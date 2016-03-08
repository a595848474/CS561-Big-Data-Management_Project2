transactions = LOAD 'input/transactions.txt' USING PigStorage(',') AS (TransID: int, CustID: int, TransTotal: float, TransNumItems: int, TransDesc: chararray);

clean1 = FOREACH transactions GENERATE CustID, TransTotal, TransNumItems;

transactions_groups = GROUP clean1 BY $0;

transactions_count = FOREACH transactions_groups GENERATE group, COUNT(clean1), SUM(clean1.TransTotal), MIN(clean1.TransNumItems);

customers = LOAD 'input/customers.txt' USING PigStorage(',') AS (ID: int, Name: chararray, Age: int, CountryCode: int, Salary: float);

clean2 = FOREACH customers GENERATE ID, Name, Salary;

join_result = join clean2 BY ID, transactions_count BY group using 'replicated';

result = FOREACH join_result GENERATE $0, $1, $2, $4, $5, $6;

STORE result INTO 'output_project2/query2.txt' USING PigStorage(',');


