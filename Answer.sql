-- MS SQL 2019

with 

-- Evaluate count of transactions and amount for available months
Q1 as 
(
       select 
              REPORT_MONTH = month(date), 
              TOTAL_COUNT_PAYMENTS = count(case when amount < 0 then 1 end),
              TOTAL_COUNT_INBOUNDS = count(case when amount > 0 then 1 end),
              TOTAL_SUM_PAYMENTS = sum(case when amount < 0 then amount else 0 end),
              TOTAL_SUM_INBOUNDS = sum(case when amount > 0 then amount else 0 end)
       from
              transactions
       group by 
              month(date)
),

-- Make decisions about monthly fee, for a months with transactions
Q2 as 
(
       select 
              REPORT_MONTH, TOTAL_COUNT_PAYMENTS, TOTAL_COUNT_INBOUNDS, TOTAL_SUM_PAYMENTS, TOTAL_SUM_INBOUNDS,
              -- credit card to pay every(!) month
              -- cost are charged each(!) month is 5
              -- not charged for a given month if you made at least 3 credit card payments for a total cost at least with 100 within that month
              COMMISSION = case when 
              (
                     (TOTAL_COUNT_PAYMENTS >= 3) and (TOTAL_SUM_PAYMENTS <= -100)
              ) then 0 else 5 end,
              MONTH_LEFTOFER = TOTAL_SUM_INBOUNDS + TOTAL_SUM_PAYMENTS
       from 
              Q1
       group by
              REPORT_MONTH, TOTAL_COUNT_PAYMENTS, TOTAL_COUNT_INBOUNDS, TOTAL_SUM_PAYMENTS, TOTAL_SUM_INBOUNDS
),

-- Temp table with list of all available months (12 on Earth)
T1 as (
       select T0.ALL_MONTHS from (values
              (1), 
              (2), 
              (3), 
              (4), 
              (5),
              (6),
              (7),
              (8),
              (9),
              (10),
              (11),
              (12)
       ) T0 (ALL_MONTHS)
),

-- Temp table with list of months without any transactions (T1 - Q1)
T2 as (
       select 
              -- let's calculate final cost on fly
              count(*) * 5 as FEE_FOR_EMPTY_MONTH 
       from T1
              LEFT JOIN Q1 ON REPORT_MONTH = T1.ALL_MONTHS
       WHERE 
              Q1.REPORT_MONTH IS NULL
),

-- Collect all values for final result

TResult as (
       select 
              (
                     select
                           FINAL_LEFTOVER = sum(MONTH_LEFTOFER)
                     from 
                           Q2
              ) FL,
              (
                     select
                           FINAL_COMMISSION = sum(COMMISSION)
                     from 
                           Q2
              ) FC,
              (
                     select
                           FEE_FOR_EMPTY_MONTH
                     from 
                           T2
              ) EP
       )

-- FINAL CALCULATION & OUTPUT

select
       FL - FC - EP as RESULT
from
       TResult
