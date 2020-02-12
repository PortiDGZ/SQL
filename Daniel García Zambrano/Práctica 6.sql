-- EJERCICIO 1
SELECT
    nomem AS nombre,
    salar || ' €' AS salario
FROM
    temple
WHERE
    nomem LIKE ( '%, A%' )
ORDER BY
    nomem;
    
-- EJERCICIO 2

SELECT
    nomem AS nombre
FROM
    temple
WHERE
    nomem LIKE ( '%, ________' )
ORDER BY
    nomem;
    
-- EJERCICIO 3

SELECT
    'DEPARTAMENTO DE ' || nomde AS departamento,
    presu * 1000 || ' €' AS presupuesto
FROM
    tdepto
WHERE
    nomde LIKE ( '%SECTOR%' )
ORDER BY
    nomde;