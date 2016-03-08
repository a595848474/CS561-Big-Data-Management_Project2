transactions = LOAD 'input/transactions.txt' USING PigStorage(',') AS (TransID: int, CustID: int, TransTotal: float, TransNumItems: int, TransDesc: chararray);

clean1 = FOREACH transactions GENERATE CustID, TransTotal;

cust_groups = GROUP clean1 BY CustID;

cust_query_counts = FOREACH cust_groups GENERATE group, COUNT(clean1), SUM(clean1.TransTotal);

STORE cust_query_counts INTO 'output_project2/query1_result.txt' USING PigStorage(',');

