create database Bank_Loan;
use Bank_Loan;
select * from bank_loan_data;

#1) Q1 Total Loan Application
select count(id) as Total_Loan_Applications from bank_loan_data;

# Q1 Month to date Total Loan Applications
select count(id) as MTD_Total_Loan_Applications from bank_loan_data
WHERE month(issue_date) = 12 AND year(issue_date) = 2021;

# Q3 Month on Month Total Loan Applictions
#First calculate previous Month to date Loan Applications
select count(id) as PMTD_Total_Loan_Applications from bank_loan_data
WHERE month(issue_date) = 11 AND year(issue_date) = 2021;

-- To Find MoM Total Loan (MTD-PMTD)/PMTD

#2.Total Funded Amount
SELECT sum(loan_amount) as Total_Funded_Amount From bank_loan_data;

-- Month to date 
SELECT sum(loan_amount) as MTD_Total_Funded_Amount From bank_loan_data
where month(issue_date)= 12 And year(issue_date)=2021;

-- Previous Month to date
SELECT sum(loan_amount) as PMTD_Total_Funded_Amount From bank_loan_data
where month(issue_date)= 11 And year(issue_date)=2021;

# 3. Total Amount Received
SELECT sum(Total_payment) as Total_Amont_Received From bank_loan_data;

-- Month to date (Current date)
SELECT sum(Total_payment) as MTD_Total_Amont_Received From bank_loan_data
Where month(issue_date) = 12 And year(issue_date)= 2021;

-- Previous Month to date
SELECT sum(Total_payment) as PMTD_Total_Amont_Received From bank_loan_data
Where month(issue_date) = 11 And year(issue_date)= 2021;

# 4. Average Interest rate
SELECT  round(avg(int_rate) * 100,2) As Avg_interest_rate from bank_loan_data;

-- Month to date
SELECT  round(avg(int_rate) * 100,2) As MTD_Avg_interest_rate from bank_loan_data
where month(issue_date) =12 and year(issue_date) =2021;

-- Previous Month to date(last month)
SELECT  round(avg(int_rate) * 100,2) As PMTD_Avg_interest_rate from bank_loan_data
where month(issue_date) =11 and year(issue_date) =2021;

# 5. Average Debt-to-income Ratio(DTI)
Select round(avg(dti) *100,2) as Avg_dti from bank_loan_data;

-- Current Month Ratio (Month to date)
Select round(avg(dti) *100,2) as MTD_Avg_dti from bank_loan_data
where month(issue_date)=12 and year(issue_date)=2021;

-- Previous month Ratio
Select round(avg(dti) *100,2) as PMTD_Avg_dti from bank_loan_data
where month(issue_date)=11 and year(issue_date)=2021;

# Total number of Good Loan  Percentage 
SELECT
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) / 
	COUNT(id) AS Good_Loan_Percentage
FROM bank_loan_data;

-- Good Loan Application
select count(id) as Good_loan_Applications From bank_loan_data 
where loan_status = 'Fully Paid' or loan_status ='Current' ;

-- Good loan Funded Amount
select sum(loan_amount) as Good_loan_funded_amount From bank_loan_data 
where loan_status = 'Fully Paid' or loan_status ='Current' ;

-- Good Loan Total Received Amount
select sum(total_payment) as Good_loan_received_amount From bank_loan_data 
where loan_status = 'Fully Paid' or loan_status ='Current' ;


# Total number of Bad loan Percentage
select 
(count(case when loan_status ='Charged off' then id END) * 100.0)
/
count(id) as Bad_loan_percentage from bank_loan_data;

-- Total Bad loan Application
SELECT count(id) as Bad_loan_Applictions from bank_loan_data
Where loan_status ='Charged off';

-- Bad loan Funded Amount
SELECT sum(loan_amount) as Bad_loan_funded_amount from bank_loan_data
Where loan_status ='Charged off';

-- Bad Loan Total Received Amount 
SELECT Sum(Total_payment) as Bad_loan_received_Amount from bank_loan_data
Where loan_status ='Charged off';

# Loan Status grade veiw
SELECT 
     loan_status,
     COUNT(id) as Total_Loan_Application,
     SUM(total_payment) as Total_Amount_received,
     SUM(loan_amount) as total_Funded_amount,
     Round(AVG(int_rate *100),2) as Interest_rate,
     Round(AVG(dti *100),2) as DTI
     FROM bank_loan_data
     GROUP BY loan_status;
     
-- Month to date
SELECT
	 loan_status,
     SUM(total_payment) as MTD_Total_Amount_received,
     SUM(loan_amount) as MTD_Total_funded_amount
FROM bank_loan_data
WHERE MONTH(issue_date) =12 
GROUP BY loan_status;

# Bank loan Report Overview
Select 
      Month(issue_date) as Month_number,
      date_format(issue_date,"%M") as Month_Name,
      count(id) as total_loan_Application,
      sum(loan_amount) as Total_funded_amount,
      sum(total_payment) as total_Received_amount
from bank_loan_data
group by Month(issue_date),date_format(issue_date,"%M")
order by Month(issue_date);

-- State
Select 
      Address_state as State,
      count(id) as total_loan_Application,
      sum(loan_amount) as Total_funded_amount,
      sum(total_payment) as total_Received_amount
from bank_loan_data
group by Address_state
order by Address_state;

-- Term
Select 
      Term,
      count(id) as total_loan_Application,
      sum(loan_amount) as Total_funded_amount,
      sum(total_payment) as total_Received_amount
from bank_loan_data
group by Term
order by Term;


--  Employee Length
Select 
      emp_length as Employee_length,
      count(id) as total_loan_Application,
      sum(loan_amount) as Total_funded_amount,
      sum(total_payment) as total_Received_amount
from bank_loan_data
group by emp_length
order by emp_length;

-- Purpose
Select 
      Purpose,
      count(id) as total_loan_Application,
      sum(loan_amount) as Total_funded_amount,
      sum(total_payment) as total_Received_amount
from bank_loan_data
group by Purpose
order by Purpose;

-- HOME OWNERSHIP
Select 
      home_ownership,
      count(id) as total_loan_Application,
      sum(loan_amount) as Total_funded_amount,
      sum(total_payment) as total_Received_amount
from bank_loan_data
group by home_ownership
order by home_ownership;

-- Filters
Select 
      home_ownership,
      count(id) as total_loan_Application,
      sum(loan_amount) as Total_funded_amount,
      sum(total_payment) as total_Received_amount
from bank_loan_data
Where grade ='A' and address_state='CA'
group by home_ownership
order by home_ownership;
