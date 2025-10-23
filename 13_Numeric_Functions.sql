-- Numeric Funtion
/* 
1. ROUND - Rounding Function
2. ABS - Absolute value function
*/ 

/* =======================================================
1. ROUND
========================================================== */

SELECT 
2.527 AS real_no,
ROUND(2.527, 2) AS round_2,
ROUND(2.527, 1) AS round_1,
ROUND(2.527, 0) AS round_0

/* ========================================================
ABS - Absolute value (works like |mod|)
=========================================================== */

SELECT 
ABS(-2) AS abs_negative,
ABS(2) AS abs_positive