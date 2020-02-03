-- Pr�ctica 12 Ejercicio 1 --
SELECT DISTINCT
    numde,
    COUNT(numem)
FROM
    temple
GROUP BY
    numde;
    
-- Pr�ctica 12 Ejercicio 2 --

SELECT
    numde AS "N�MERO DE DEPARTAMENTO",
    trunc(AVG(salar), 2) AS "SALARIO MEDIO",
    trunc(MAX(salar), 2) AS "SALARIO M�XIMO",
    trunc(MIN(salar), 2) AS "SALARIO M�NIMO"
FROM
    temple
GROUP BY
    numde;

-- Pr�ctica 12 Ejercicio 3 --

SELECT
    comis,
    trunc(AVG(salar), 2),
    round(AVG(months_between(sysdate, fecna) / 12))
FROM
    temple
GROUP BY
    comis;

-- Pr�ctica 12 Ejercicio 4 --

SELECT
    comis,
    trunc(AVG(salar), 2),
    trunc(AVG(months_between(sysdate, fecna) / 12))
FROM
    temple
GROUP BY
    comis;

-- Pr�ctica 13 Ejercicio 5 --

SELECT
    numde,
    trunc(AVG(salar), 2),
    trunc(AVG(months_between(sysdate, fecna) / 12))
FROM
    temple
GROUP BY
    numde,comis;
    -- Pr�ctica 13 Ejercicio 6 --

SELECT numde, COUNT(numem), SUM(salar) FROM temple WHERE salar > 2500 group by numde;