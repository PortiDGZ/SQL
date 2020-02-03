-- Práctica 7 Ejercicio 1 --

SELECT
    nomem
FROM
    temple
WHERE
    extel IN (
        250,
        750
    )
ORDER BY
    nomem;

-- Práctica 7 Ejercicio 2 --

SELECT
    nomem
FROM
    temple
WHERE
    numde IN (
        SELECT
            numde
        FROM
            temple
        WHERE
            nomem LIKE '%, PILAR'
            OR nomem LIKE '%, DOROTEA'
    )
ORDER BY
    nomem;

-- Práctica 7 Ejercicio 3 --

SELECT
    nomde, direc
FROM
    tdepto
WHERE
    direc IN (
        SELECT
            direc
        FROM
            tdepto
        WHERE
            nomde LIKE '% COMERCIAL'
            OR nomde LIKE 'PERSONAL'
    )ORDER BY nomde;