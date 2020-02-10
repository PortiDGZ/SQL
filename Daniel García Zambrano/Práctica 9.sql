-- EJERCICIO 1

SELECT
    nomem   AS nombre,
    comis   AS comisión
FROM
    temple
WHERE
    numde = 110
    AND EXISTS (
        SELECT
            nomem
        FROM
            temple
        WHERE
            comis > 0
    )
ORDER BY
    nomem;
    
-- EJERCICIO 2

SELECT
    nomem AS nombre
FROM
    temple
WHERE
    numde NOT IN (
        100,
        110,
        111,
        112
    )
ORDER BY
    1;
    
-- EJERCICIO 3

SELECT
    nomem   AS nombre,
    salar   AS salario
FROM
    temple
WHERE
    ( numhi = 0
      AND salar > 1500 )
    OR ( numhi > 0
         AND salar < 1000 )
ORDER BY
    1;
    
-- EJERCICIO 4

SELECT
    nomem AS nombre,
    salar + comis AS "SALARIO TOTAL"
FROM
    temple
WHERE
    salar + comis - 1800 > ANY (
        SELECT
            salar + comis
        FROM
            temple
    )
ORDER BY
    numem;
    
-- EJERCICIO 5

SELECT
    nomem   AS nombre,
    salar   AS salario
FROM
    temple
WHERE
    numde = 111
    AND comis > 0
    AND EXISTS (
        SELECT
            salar
        FROM
            temple
        WHERE
            comis > salar * 0.15
    )
ORDER BY
    1;

-- EJERCICIO 6

SELECT
    nomde   AS nombre,
    tidir   AS "TIPO DE DIRECTOR",
    presu   AS presupuesto
FROM
    tdepto
WHERE
    depde IS NULL
    OR tidir = 'F'
    OR ( tidir = 'P'
         AND presu * 1000 > 30000 )
ORDER BY
    1;