create table cust_account(
    accountNo VARCHAR2(20) PRIMARY KEY,
    custName VARCHAR2(50),
    balance number(20,4)
);

insert into cust_account VALUES('70-490-930','ȫ�浿',10000000);
insert into cust_account VALUES('70-490-911','������',10000000);
commit;
SELECT * FROM cust_account;