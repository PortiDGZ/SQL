-- Práctica 12 Ejercicio 1 --
SELECT DISTINCT
    numde,
    COUNT(numem)
FROM
    temple
GROUP BY
    numde;
    
-- Práctica 12 Ejercicio 2 --

SELECT
    numde AS "NÚMERO DE DEPARTAMENTO",
    trunc(AVG(salar), 2) AS "SALARIO MEDIO",
    trunc(MAX(salar), 2) AS "SALARIO MÁXIMO",
    trunc(MIN(salar), 2) AS "SALARIO MÍNIMO"
FROM
    temple
GROUP BY
    numde;

-- Práctica 12 Ejercicio 3 --

SELECT
    comis AS "COMISIÓN",
    trunc(AVG(salar), 2) AS "SALARIO MEDIO",
    round(AVG(months_between(sysdate, fecna) / 12)) AS "EDAD MEDIA"
FROM
    temple
GROUP BY
    comis 
ORDER BY 1;

-- Práctica 12 Ejercicio 4 --

SELECT
    comis AS "COMISIÓN",
    trunc(AVG(salar), 2) AS "SALARIO MEDIO",
    trunc(AVG(months_between(sysdate, fecna) / 12)) AS "EDAD CUMPLIDA"
FROM
    temple
GROUP BY
    comis;

-- Práctica 12 Ejercicio 5 --

SELECT
    numde AS "NÚMERO DE DEPARTAMENTO",
    comis AS "COMISIÓN",
    trunc(AVG(salar), 2) AS "SALARIO MEDIO",
    trunc(AVG(months_between(sysdate, fecna) / 12)) AS "EDAD MEDIA"
FROM
    temple
GROUP BY
    numde,
    comis
ORDER BY 1;
    -- Práctica 12 Ejercicio 6 --

SELECT
    numde,
    COUNT(numem),
    SUM(salar)
FROM
    temple
WHERE
    numde IN (
        SELECT
            numde
        FROM
            temple
        WHERE
            salar > 2500
    )
GROUP BY
    numde;