
                   answer of 1 objective question- 
      
select g.GeographyLocation , sum(bc.Balance) as Total_Balance
from bank_churn bc
join customerinfo ci on ci.CustomerID = bc.CustomerID
join geography g on g.GeographyID = ci.GeographyID
group by g.GeographyLocation

         answer of 2 objective question-
         
select Surname , EstimatedSalary from customerinfo
where quarter(BankDOJ) = 4
order by EstimatedSalary desc
limit 5
         
               answer of 3 objective question-
               
select avg(NumOfProducts) from bank_churn
where HasCrCard = 1

      answer of 4 objective question-
     
select g.GenderCategory , count(bc.Exited) as churn_rate
from bank_churn bc
join customerinfo ci on ci.CustomerID = bc.CustomerID
join gender g on g.GenderID = ci.GenderID
where Exited = 1
and year(BankDOJ) = (select year(max(ci.BankDOJ)) from customerinfo ci)
group by g.GenderCategory

                           answer of 5 objective question-

select e.ExitCategory , avg(bc.CreditScore) as Avg_cred_sco
from bank_churn bc
join exitcustomer e on e.ExitID = bc.Exited
group by e.ExitCategory

						 answer of 6 objective question-

select g.GenderCategory , avg(ci.EstimatedSalary) from customerinfo ci
join gender g on g.GenderID = ci.GenderID
join bank_churn bc on bc.CustomerID = ci.CustomerID
where bc.Exited = 0
group by  g.GenderCategory

						 answer of 7 objective question-


with custseg as (
select CustomerID , CreditScore , 
case
when CreditScore < 580 then 'Poor'
when CreditScore between 580 and 669 then 'Fair'
when CreditScore between 670 and 739 then 'Good'
when CreditScore between 740 and 799 then 'Very Good'
else 'Excellent'
end as Credit_Segment
from bank_churn
where Exited = 1
)
select Credit_Segment , count(*) as totalexitcustomer from custseg
group by Credit_Segment
order by totalexitcustomer desc
limit 1


                                   answer of 8 objective question-
                                   
 select g.GeographyLocation , count(bc.CustomerID) as activecustomers 
 from geography g
 join customerinfo ci on ci.GeographyID = g.GeographyID
 join bank_churn bc on bc.CustomerID = ci.CustomerID
 where bc.IsActiveMember = 1
 and bc.Tenure>5 
 group by g.GeographyLocation
 order by activecustomers desc
 limit 1


                             answer of 9 objective question-
                             
select cc.Category , ec.ExitCategory , count(bc.CustomerID) 
from bank_churn bc
join creditcard cc on cc.CreditID = bc.HasCrCard
join exitcustomer ec on ec.ExitId = bc.Exited
group by cc.Category , ec.ExitCategory                             
                             
                             
                             answer of 10 objective question-
                          
 select NumOfProducts , count(*) as exitedcustomer from bank_churn
 where Exited = 1
 group by NumOfProducts 
 order by exitedcustomer desc
                       
                       answer of 11 objective question-
                       
select year(BankDOJ) , count(*) as customerjoin from customerinfo
group by year(BankDOJ)                    
order by year(BankDOJ)                     
                             
 
select month(BankDOJ) , count(*) as customerjoin from customerinfo
group by month(BankDOJ)                    
order by month(BankDOJ)

                       answer of 12 objective question-
                       
select NumOfProducts , sum(Balance) as total_balance from bank_churn
where Exited = 1
group by NumOfProducts                      
order by NumOfProducts                       
                       
                       answer of 14 objective question-
  total table - 7
  categorical variable table - 5
  
                      answer of 15 objective question-
                       
select g.GeographyLocation , ge.GenderCategory , avg(ci.EstimatedSalary) as avg_salary , 
rank() over (partition by GeographyLocation order by avg(ci.EstimatedSalary) desc) as ranking
from customerinfo ci 
join geography g on g.GeographyID = ci.GeographyID
join gender ge on ge.GenderID = ci.GenderID

group by g.GeographyLocation , ge.GenderCategory                     
                       
                        answer of 16 objective question-
                        
select 
case
when ci.Age >= 18 and ci.Age <= 30 then "18-30"
when ci.Age > 30 and ci.Age <= 50 then "30-50"
else "50+"
end as age_bracket , 
avg(bc.Tenure) as avgtenure_exitedcustomer
from bank_churn bc 
join customerinfo ci on ci.CustomerID = bc.CustomerID  
where bc.Exited = 1                      
group by age_bracket                        
                        
                        answer of 19 objective question-
                        
with custseg as (
select CustomerID , CreditScore , 
case
when CreditScore < 580 then 'Poor'
when CreditScore between 580 and 669 then 'Fair'
when CreditScore between 670 and 739 then 'Good'
when CreditScore between 740 and 799 then 'Very Good'
else 'Excellent'
end as Credit_Segment
from bank_churn
where Exited = 1
)                        
  
 select Credit_Segment , count(CustomerID) as total_customer , rank() over (order by count(CustomerID) desc) as Ranks
 from custseg
 group by Credit_Segment
 order by Ranks

                                answer of 20 objective question-

select 
case
when ci.Age >= 18 and ci.Age <= 30 then "18-30"
when ci.Age > 30 and ci.Age <= 50 then "30-50"
else "50"
end as age_bracket , 
count(ci.CustomerID) as customer_with_cc
from customerinfo ci
join bank_churn bc on bc.CustomerID = ci.CustomerID
where HasCrCard = 1
group by age_bracket


with cte as (
select 
case
when ci.Age >= 18 and ci.Age <= 30 then "18-30"
when ci.Age > 30 and ci.Age <= 50 then "30-50"
else "50"
end as age_bracket , 
count(ci.CustomerID) as customer_with_cc
from customerinfo ci
join bank_churn bc on bc.CustomerID = ci.CustomerID
where HasCrCard = 1
group by age_bracket
)
select age_bracket , customer_with_cc 
from cte
where customer_with_cc < (select avg(customer_with_cc) from cte)


                                 answer of 21 objective question-

select g.GeographyLocation , count(ci.CustomerID) as total_customer , 
rank() over (order by count(ci.CustomerID) desc) as Ranks , 
avg(bc.Balance) as avg_balance
from geography g 
join customerinfo ci on ci.GeographyID = g.GeographyID
join bank_churn bc on bc.CustomerID = ci.CustomerID
where bc.IsActiveMember = 0
group by g.GeographyLocation


                                answer of 22 objective question-
                                
ALTER TABLE customerinfo
ADD COLUMN CustomerID_Surname VARCHAR(255);

UPDATE customerinfo
SET CustomerID_Surname = CONCAT(CustomerId,'_',Surname);

                                 answer of 23 objective question- 
                                 
select * ,
case
when Exited = 1 then 'Exit'
else 'Retain'
end as Exitcategory 
from bank_churn           
                                 answer of 25 objective question-
				
select CustomerID , Surname 
from customerinfo
where Surname like "%on"        

                          
                                 answer of 26 objective question-
                                 
select * from bank_churn 
where IsActiveMember = 1 and Exited = 1   


                              
                                 
  
 select * from bank_churn limit 5
select * from customerinfo limit 5
select * from activecustomer
select * from creditcard
select * from exitcustomer
select * from gender
select * from geography