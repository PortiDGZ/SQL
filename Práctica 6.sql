SELECT
    nomem,
    salar
FROM
    temple
WHERE
    nomem LIKE '%,A'
ORDER BY
    nomem;

SELECT
    nomem,
    salar
FROM
    temple
WHERE
    nomem LIKE '%,_________'
ORDER BY
    nomem;

SELECT
    'DEPARTAMENTO DE ' || nomde AS "Departamento",
    presu * 1000 || ' €' AS "Presupuesto"
FROM
    tdepto
WHERE
    nomde LIKE 'SECTOR%'
ORDER BY
    nomde;