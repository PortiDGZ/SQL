-- Práctica 8 Ejercicio 1 --
SELECT
    nomce
FROM
    tcentr
WHERE
    EXISTS (
        SELECT
            nomce
        FROM
            tcentr
        WHERE
            dirce LIKE '%ATOCHA%'
    );
    
    -- Práctica 8 Ejercicio 2 --

SELECT
    nomem,
    salar
FROM
    temple
WHERE
    numde = 100
    AND EXISTS (
        SELECT
            salar
        FROM
            temple
        WHERE
            salar > 1300
    );
    
    -- Práctica 8 Ejercicio 3 --

SELECT
    nomem,
    salar
FROM
    temple
WHERE
    numde = 100
    AND EXISTS (
        SELECT
            salar
        FROM
            temple
        WHERE
            numde = 100
            AND salar > 2750
    );
    
    -- Práctica 8 Ejercicio 4 --

SELECT
    nomem,
    salar
FROM
    temple
WHERE
    numde = 100
    AND EXISTS (
        SELECT
            salar
        FROM
            temple
        WHERE
            numde = 100
            AND salar > 3000
    );