-- EJERCICIO 1

SELECT
    nomce AS nombre
FROM
    tcentr
WHERE
    EXISTS (
        SELECT
            dirce
        FROM
            tcentr
        WHERE
            dirce LIKE ( '%ATOCHA%' )
    )
ORDER BY
    nomce;
    
-- EJERCICIO 2

SELECT
    nomem   AS nombre,
    salar   AS salario
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
            AND numde = 100
    )
ORDER BY
    nomem;
    
-- EJERCICIO 3

SELECT
    nomem   AS nombre,
    salar   AS salario
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
            salar > 2750
            AND numde = 100
    )
ORDER BY
    nomem;
    
-- EJERCICIO 4

SELECT
    nomem   AS nombre,
    salar   AS salario
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
            salar > 3000
            AND numde = 100
    )
ORDER BY
    nomem;