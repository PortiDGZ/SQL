-- EJERCICIO 1

SELECT DISTINCT
    numde AS departamento,
    COUNT(*) AS "N�MERO DE EMPLEADOS"
FROM
    temple
GROUP BY
    numde;
    
-- EJERCICIO 2

SELECT DISTINCT
    numde AS departamento,
    trunc(AVG(salar), 2) AS "SALARIO MEDIO",
    trunc(MIN(salar), 2) AS "SALARIO M�NIMO",
    trunc(MAX(salar), 2) AS "SALARIO M�XIMO"
FROM
    temple
GROUP BY
    numde;
    
-- EJERCICIO 3

SELECT DISTINCT
    comis AS comisi�n,
    trunc(AVG(salar), 2) AS "SALARIO MEDIO",
    trunc(AVG(round(months_between(sysdate, fecna) / 12))) AS "EDAD MEDIA"
FROM
    temple
GROUP BY
    comis;
    
-- EJERCICIO 4

SELECT DISTINCT
    comis AS comisi�n,
    trunc(AVG(salar), 2) AS "SALARIO MEDIO",
    trunc(AVG(trunc(months_between(sysdate, fecna) / 12))) AS "EDAD MEDIA"
FROM
    temple
GROUP BY
    comis;
    
-- EJERCICIO 5

SELECT DISTINCT
    numde   AS departmento,
    comis   AS comisi�n,
    trunc(AVG(salar), 2) AS "SALARIO MEDIO",
    trunc(AVG(trunc(months_between(sysdate, fecna) / 12))) AS "EDAD MEDIA"
FROM
    temple
GROUP BY
    numde,
    comis
ORDER BY
    numde;

-- EJERCICIO 6

SELECT
    numde AS departamento,
    COUNT(numem) AS "N�MERO DE EMPLEADOS",
    SUM(salar) AS "SUMA DE SALARIOS"
FROM
    temple
WHERE
    numde = ANY (
        SELECT
            numde
        FROM
            temple
        WHERE
            salar > 2500
    )
GROUP BY
    numde;