-- EJERCICIO 1
SELECT
    'DEPARTAMENTO DE ' || nomde AS "NOMBRE DE DEPARTAMENTO"
FROM
    tdepto
WHERE
    presu * 1000 < 30000
ORDER BY
    nomde;

-- EJERCICIO 2

SELECT
    numde
    || '-'
    || nomde AS "NÚMERO-NOMBRE",
    tidir AS "TIPO DE DIRECTOR"
FROM
    tdepto
WHERE
    presu * 1000 < 30000
ORDER BY
    numde;

-- EJERCICIO 3

SELECT
    nomem AS nombre,
    salar * 12 AS "SALARIO 2020",
    salar * 12 * 1.02 AS "SALARIO 2021",
    salar * 12 * power(1.02, 2) AS "SALARIO 2022"
FROM
    temple
WHERE
    numhi > 4
ORDER BY
    nomem;

-- EJERCICIO 4

SELECT
    nomem AS nombre
FROM
    temple
WHERE
    salar + ( numhi * 120 ) > salar * 1.2
ORDER BY
    nomem;

-- EJERCICIO 5

SELECT
    nomem AS nombre,
    salar + comis AS "SALARIO TOTAL"
FROM
    temple
WHERE
    numde = 112
ORDER BY
    salar + comis DESC,
    nomem;

-- EJERCICIO 6

SELECT
    nomem AS nombre,
    salar + comis AS "SALARIO TOTAL"
FROM
    temple
WHERE
    numde = 112
    AND comis IS NOT NULL
ORDER BY
    salar + comis DESC,
    nomem;

-- EJERCICIO 7

SELECT
    nomem AS nombre,
    salar + comis || ' €' AS "SALARIO TOTAL"
FROM
    temple
WHERE
    numde = 112
    AND comis IS NOT NULL
ORDER BY
    salar + comis DESC,
    nomem;
    
-- EJERCICIO 8

SELECT
    nomem AS nombre,
    salar + 60 * ( numhi - 3 ) AS "SALARIO TOTAL"
FROM
    temple
WHERE
    numhi >= 4
ORDER BY
    nomem;

-- EJERCICIO 9

SELECT
    nomem AS nombre,
    salar + 60 * ( numhi - 3 ) AS "SALARIO TOTAL"
FROM
    temple
WHERE
    numhi >= (
        SELECT
            numhi
        FROM
            temple
        WHERE
            nomem LIKE '%JULIANA'
    )
ORDER BY
    nomem;

-- EJERCICIO 10

SELECT
    nomem AS nombre
FROM
    temple
WHERE
    salar >= 1.15 * (
        SELECT
            salar
        FROM
            temple
        WHERE
            nomem LIKE '%CLAUDIA'
    )
ORDER BY
    nomem;

-- EJERCICIO 11

SELECT
    nomde AS "NOMBRE DE DEPARTAMENTO"
FROM
    tdepto
WHERE
    depde IS NULL
ORDER BY
    nomde;