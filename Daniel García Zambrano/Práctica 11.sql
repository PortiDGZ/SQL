-- EJERCICIO 1

SELECT
    AVG(salar) AS "SALARIO MEDIO",
    MIN(salar) AS "SALARIO MÍNIMO",
    MAX(salar) AS "SALARIO MÁXIMO"
FROM
    temple;

-- EJERCICIO 2

SELECT
    nomem   AS nombre,
    salar   AS salario
FROM
    temple
WHERE
    salar * 1.4 > (
        SELECT
            MAX(salar)
        FROM
            temple
    )
ORDER BY
    nomem;

-- EJERCICIO 3

SELECT
    trunc(MAX(months_between(sysdate, fecna)) / 12) AS "EDAD MÁXIMA"
FROM
    temple
WHERE
    numde = 110;
    
-- EJERCICIO 4

SELECT
    nomem AS nombre,
    trunc(months_between(sysdate, fecna) / 12) AS "EDAD"
FROM
    temple
WHERE
    numde = 110
    AND months_between(sysdate, fecna) = (
        SELECT
            MAX(months_between(sysdate, fecna))
        FROM
            temple
        WHERE
            numde = 110
    );
    
-- EJERCICIO 5

SELECT
    COUNT(*) AS "NÚMERO DE EMPLEADOS",
    COUNT(DISTINCT comis) AS "COMISIONES DISTINTAS",
    SUM(comis) AS "SUMA DE LAS COMISIONES"
FROM
    temple
WHERE
    numde = 112;