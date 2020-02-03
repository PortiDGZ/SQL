-- Práctica 6 Ejercicio 1 --
SELECT
    nomem,
    salar
FROM
    temple
WHERE
    nomem LIKE '%,A'
ORDER BY
    nomem;

-- Práctica 6 Ejercicio 2 --

SELECT
    nomem,
    salar
FROM
    temple
WHERE
    nomem LIKE '%,_________'
ORDER BY
    nomem;

-- Práctica 6 Ejercicio 3 --

SELECT
    'DEPARTAMENTO DE ' || nomde AS "Departamento",
    presu * 1000 || ' €' AS "Presupuesto"
FROM
    tdepto
WHERE
    nomde LIKE 'SECTOR%'
ORDER BY
    nomde;