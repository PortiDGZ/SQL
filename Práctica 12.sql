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
    comis AS "COMISI�N",
    trunc(AVG(salar), 2) AS "SALARIO MEDIO",
    round(AVG(months_between(sysdate, fecna) / 12)) AS "EDAD MEDIA"
FROM
    temple
GROUP BY
    comis 
ORDER BY 1;

-- Pr�ctica 12 Ejercicio 4 --

SELECT
    comis AS "COMISI�N",
    trunc(AVG(salar), 2) AS "SALARIO MEDIO",
    trunc(AVG(months_between(sysdate, fecna) / 12)) AS "EDAD CUMPLIDA"
FROM
    temple
GROUP BY
    comis;

-- Pr�ctica 12 Ejercicio 5 --

SELECT
    numde AS "N�MERO DE DEPARTAMENTO",
    comis AS "COMISI�N",
    trunc(AVG(salar), 2) AS "SALARIO MEDIO",
    trunc(AVG(months_between(sysdate, fecna) / 12)) AS "EDAD MEDIA"
FROM
    temple
GROUP BY
    numde,
    comis
ORDER BY 1;
    -- Pr�ctica 12 Ejercicio 6 --

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