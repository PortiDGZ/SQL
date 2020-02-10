-- EJERCICIO 1

SELECT
    nomem   AS nombre,
    fecna   AS "FECHA DE NACIMIENTO"
FROM
    temple
WHERE
    EXTRACT(MONTH FROM fecna) = 11
ORDER BY
    1;
    
-- EJERCICIO 2

SELECT
    nomem AS nombre
FROM
    temple
WHERE
    EXTRACT(DAY FROM fecna) = EXTRACT(DAY FROM sysdate)
    AND EXTRACT(MONTH FROM fecna) = EXTRACT(MONTH FROM sysdate)
ORDER BY
    1;
    
-- EJERCICIO 3

SELECT
    nomem   AS nombre,
    fecna   AS "FECHA DE NACIMIENTO"
FROM
    temple
WHERE
    EXTRACT(YEAR FROM fecna) < 1950
ORDER BY
    1;
    
-- EJERCICIO 4

SELECT
    nomem   AS nombre,
    fecin   AS "FECHA DE INCORPORACIÓN"
FROM
    temple
WHERE
    EXTRACT(YEAR FROM fecin) < 1990
ORDER BY
    1;

-- EJERCICIO 5

SELECT
    nomem   AS nombre,
    fecna   AS "FECHA DE NACIMIENTO",
    fecin   AS "FECHA DE INCORPORACIÓN"
FROM
    temple
WHERE
    months_between(fecin, fecna) < 360
ORDER BY
    1;