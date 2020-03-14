create database sub7;

create table Users(Id INT NOT NULL,Name VARCHAR(20),Email VARCHAR(20),Salary INT,PRIMARY KEY(Id));

create table Accounts(Account_id INT NOT NULL,Type VARCHAR(20),bank_id INT,user_id INT,Account_no INT,Amount INT,PRIMARY KEY(Account_id)
	,FOREIGN KEY (user_id) REFERENCES Users(Id)
	,FOREIGN KEY (bank_id) REFERENCES Bank(Bank_id)
	);

#create table AccountType(Acc_id INT NOT NULL,Type VARCHAR(20),PRIMARY KEY(Acc_id),
#FOREIGN KEY (Acc_id) REFERENCES Accounts(Account_id));

INSERT INTO Users VALUES(12,"Gary","gar@gmail.com",70000);#
INSERT INTO Users VALUES(21,"John","joh@outlook.com",60000);#
INSERT INTO Users VALUES(44,"Mike","Mike@gmail.com",100000);#
INSERT INTO Users VALUES(51,"Paul","paul@gmail.com",70000);
INSERT INTO Users VALUES(22,"George","ger@yahoomail.com",40000);#
INSERT INTO Users VALUES(32,"Mack","mac@gmail.com",80000);
INSERT INTO Users VALUES(02,"Kim","kim@gmail.com",90000);#

INSERT INTO Accounts VALUES(10,"SavingAccount",1001,21,1836271,300000);

INSERT INTO Accounts VALUES(23,"SavingAccount",1042,22,2481726,400000);
INSERT INTO Accounts VALUES(25,"CurrentAccount",1042,22,6387268,300000);
INSERT INTO Accounts VALUES(27,"LoanAccount",1021,22,78372348,100000);

INSERT INTO Accounts VALUES(11,"SavingAccount",1021,44,7361889,200000);
INSERT INTO Accounts VALUES(15,"CurrentAccount",1001,44,7284639,500000);

INSERT INTO Accounts VALUES(90,"LoanAccount",1042,02,3278432,200000);

INSERT INTO Accounts VALUES(111,"CurrentAccount",1021,12,7823611,1000000);
INSERT INTO Accounts VALUES(102,"LoanAccount",1001,12,2864171,50000);

INSERT INTO Accounts VALUES(241,"CurrentAccount",1042,51,7138129,60000);
INSERT INTO Accounts VALUES(99,"SavingAccount",1021,32,72368714,400000);
INSERT INTO Accounts VALUES(09,"LoanAccount",1042,32,324771843,200000);


-- create table Bank as(
-- SELECT U.Id,U.Name,U.Email,U.Salary,A.Account_id,A.Type,A.Account_no,A.Amount FROM Users as U join Accounts as A ON U.Id=A.user_id
-- );

create table Bank(Bank_id INT NOT NULL,Bank_name VARCHAR(20),PRIMARY KEY (Bank_id));

INSERT INTO Bank VALUES(1001,"IDFC BANK");
INSERT INTO Bank VALUES(1042,"SIB BANK");
INSERT INTO Bank VALUES(1021,"CIB BANK");




SELECT A.Type,
	   SUM(CASE WHEN U.Name='Gary' then A.Amount else 0 end) as 'Gary',
	   SUM(CASE WHEN U.Name='John' then A.Amount else 0 end) as 'John',
	   SUM(CASE WHEN U.Name='George' then A.Amount else 0 end) as 'George'
	   FROM Accounts A join Users U ON U.Id=A.user_id join Bank B ON A.bank_id=B.Bank_id GROUP BY A.Type;


SET @sql=NULL;
SELECT 
	GROUP_CONCAT(DISTINCT
		CONCAT(
		'SUM(CASE WHEN U.Name=''',
		Nm,
		''' then A.Amount else 0 end) as `',Nm,'`'
		)
	)INTO @sql
FROM
(SELECT U.Name as Nm
FROM Users U
Order BY U.Name
) d;
SET @sql=CONCAT('SELECT A.Type,',@sql,'  
	FROM Accounts A
	join Users U
	ON U.Id=A.user_id
	join Bank B 
	ON A.Bank_id=B.Bank_id
	GROUP BY A.Type;
');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


INSERT INTO Users VALUES(62,"Matt","mtt@gmail.com",120000);
INSERT INTO Users VALUES(78,"Kate","kte@gmail.com",520000);

INSERT INTO Accounts VALUES(35,"JhanDhanAccount",1042,62,67325718,300000);
INSERT INTO Accounts VALUES(36,"JhanDhanAccount",1001,78,72318691,100000);
INSERT INTO Accounts VALUES(96,"SavingAccount",1021,78,73911432,900000);

INSERT INTO Accounts VALUES(83,"JhanDhanAccount",1042,21,89842185,400000);
INSERT INTO Accounts VALUES(88,"JhanDhanAccount",1001,51,92783281,400000);
