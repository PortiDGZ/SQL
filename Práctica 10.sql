-- Práctica 10 Ejercicio 1 --

SELECT
    nomem,
    fecna
FROM
    temple
WHERE
    EXTRACT(MONTH FROM fecna) = 11;
    
    -- Práctica 10 Ejercicio 2 --

SELECT
    nomem
FROM
    temple
WHERE
    EXTRACT(MONTH FROM fecna) = EXTRACT(MONTH FROM sysdate)
    AND ( EXTRACT(DAY FROM fecna) ) = EXTRACT(DAY FROM sysdate);
    
    -- Práctica 10 Ejercicio 3 --

SELECT
    nomem,
    fecna
FROM
    temple
WHERE
    EXTRACT(YEAR FROM fecna) < 1950;
    
    -- Práctica 10 Ejercicio 4 --

SELECT
    nomem,
    fecin
FROM
    temple
WHERE
    EXTRACT(YEAR FROM fecin) < 1970;
    
    -- Práctica 10 Ejercicio 5 --

SELECT
    nomem,
    fecna,
    fecin
FROM
    temple
WHERE
    EXTRACT(YEAR FROM fecin) - EXTRACT(YEAR FROM fecna) < 30;