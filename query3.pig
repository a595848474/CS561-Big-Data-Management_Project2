transactions = LOAD 'input/transactions.txt' USING PigStorage(',') AS (TransID: int, CustID: int, TransTotal: float, TransNumItems: int, TransDesc: chararray);

clean1 = FOREACH transactions GENERATE CustID, TransTotal;

clean1_groups = GROUP clean1 BY CustID;

clean1_group_result =  FOREACH clean1_groups GENERATE group, MIN(clean1.TransTotal) as minTransTotal, MAX(clean1.TransTotal) as maxTransTotal;

customers = LOAD 'input/customers.txt' USING PigStorage(',') AS (ID: int, Name: chararray, Age: int, CountryCode: int, Salary: float);

clean2 = FOREACH customers GENERATE ID, CountryCode;

join_result = join clean2 BY ID, clean1_group_result BY group USING 'replicated';

join_result_clean = FOREACH join_result GENERATE $1, $3, $4;

join_result_groups = GROUP join_result_clean BY CountryCode;

result = FOREACH join_result_groups GENERATE group, COUNT(join_result_clean), MIN(join_result_clean.minTransTotal), MAX(join_result_clean.maxTransTotal);

STORE result INTO 'output_project2/query3.txt' USING PigStorage(',');
