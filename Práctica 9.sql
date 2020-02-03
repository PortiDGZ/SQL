-- Práctica 9 Ejercicio 1 --
SELECT
    nomem,
    comis
FROM
    temple
WHERE
    numde LIKE 110
    AND comis IS NOT NULL
ORDER BY
    nomem;
    
    -- Práctica 9 Ejercicio 2 --

SELECT
    nomde
FROM
    tdepto
WHERE
    nomde NOT LIKE 'DIRECCIÓN %'
    AND nomde NOT LIKE 'SECTOR %';
    
    -- Práctica 9 Ejercicio 3 --

SELECT
    nomem,
    salar
FROM
    temple
WHERE
    ( numhi = 0
      AND salar > 1500 )
    OR ( numhi > 0
         AND salar < 1000 )
ORDER BY
    nomem;
    
    -- Práctica 9 Ejercicio 4 --

SELECT
    nomem,
    ( salar + comis )
FROM
    temple
WHERE
    comis IS NOT NULL
    AND salar + comis >= ALL (
        SELECT
            salar
        FROM
            temple
    );
    
    -- Práctica 9 Ejercicio 5 --

SELECT
    nomem,
    salar
FROM
    temple
WHERE
    numde = 111
    AND comis IS NOT NULL
    AND EXISTS (
        SELECT
            *
        FROM
            temple
        WHERE
            numde = 111
            AND comis > salar * 0.15
    )
ORDER BY
    nomem;
    
    -- Práctica 9 Ejercicio 6 --

SELECT
    nomde,
    tidir,
    presu
FROM
    tdepto
WHERE
    tidir LIKE 'F'
    OR ( tidir LIKE 'P'
         AND ( presu > 30
               OR depde IS NULL ) );