-- EJERCICIO 1

SELECT
    nomem AS nombre
FROM
    temple
WHERE
    salar BETWEEN 1500 AND 1600
ORDER BY
    nomem;
    
-- EJERCICIO 2

SELECT
    nomem   AS nombre,
    salar   AS salario
FROM
    temple
WHERE
    comis IS NOT NULL
    AND numhi <> 0
    AND salar / numhi BETWEEN comis * 50 AND 720
ORDER BY
    nomem;