SELECT AVG(salar),MIN(salar),MAX(salar) FROM temple; 

SELECT nomem, salar FROM temple WHERE salar*1.40 > (SELECT MAX(salar) FROM temple);

SELECT TRUNC(MAX(months_between(sysdate,fecna)/12)) AS "MAXIMO" FROM temple WHERE numde = 110;

SELECT nomem, TRUNC(MAX(months_between(sysdate,fecna)/12)) AS "MAXIMO" FROM temple WHERE numde = 110 group by nomem;