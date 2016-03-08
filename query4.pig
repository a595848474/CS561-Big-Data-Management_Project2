transactions = LOAD 'input/transactions.txt' USING PigStorage(',') AS (TransID: int, CustID: int, TransTotal: float, TransNumItems: int, TransDesc: chararray);

clean1 = FOREACH transactions GENERATE CustID;

clean1_groups = GROUP clean1 BY CustID;

clean1_groups_count = FOREACH clean1_groups GENERATE group as CustID, COUNT(clean1) as numOfTrans, (int)1;

clean1_groups_count_groups = GROUP clean1_groups_count BY $2;

clean1_groups_count_groups_count = FOREACH clean1_groups_count_groups GENERATE group, MIN(clean1_groups_count.numOfTrans) as minTrans;

join1_result = join clean1_groups_count_groups_count BY minTrans, clean1_groups_count BY numOfTrans;

customers = LOAD 'input/customers.txt' USING PigStorage(',') AS (ID: int, Name: chararray, Age: int, CountryCode: int, Salary: float);

clean2 = FOREACH customers GENERATE ID, Name;

join2_result = join clean2 BY ID, join1_result BY CustID;

result = FOREACH join2_result GENERATE Name, minTrans;

STORE result INTO 'output_project2/query4.txt' USING PigStorage(',');
