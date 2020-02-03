-- Práctica 11 Ejercicio 1 --

SELECT
    AVG(salar),
    MIN(salar),
    MAX(salar)
FROM
    temple;
    
    -- Práctica 11 Ejercicio 2 --


SELECT
    nomem,
    salar
FROM
    temple
WHERE
    salar * 1.40 > (
        SELECT
            MAX(salar)
        FROM
            temple
    );
    
    -- Práctica 11 Ejercicio 3 --


SELECT
    trunc(MAX(months_between(sysdate, fecna) / 12)) AS "MAXIMO"
FROM
    temple
WHERE
    numde = 110;
    
    -- Práctica 11 Ejercicio 4 --


SELECT
    nomem,
    trunc(months_between(sysdate, fecna) / 12) AS "MAXIMO"
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
    
    -- Práctica 11 Ejercicio 5 --

SELECT
    COUNT(nomem),
    COUNT(DISTINCT(comis)),
    SUM(comis)
FROM
    temple
WHERE
    numde = 112;