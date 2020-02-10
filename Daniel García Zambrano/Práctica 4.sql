-- EJERCICIO 1
SELECT
    nomem AS nombre
FROM
    temple
WHERE
    salar > ALL (
        SELECT
            salar
        FROM
            temple
        WHERE
            numde = 122
    )
ORDER BY
    nomem;
    
-- EJERCICIO 2

SELECT
    nomem AS nombre
FROM
    temple
WHERE
    salar > ALL (
        SELECT
            salar
        FROM
            temple
        WHERE
            numde = 150
    )
ORDER BY
    nomem;
    
-- EJERCICIO 3

SELECT
    nomem AS nombre
FROM
    temple
WHERE
    salar > ANY (
        SELECT
            salar * 2.5
        FROM
            temple
        WHERE
            numde = 122
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
    salar = ANY (
        SELECT
            comis * 10
        FROM
            temple
    )
ORDER BY
    nomem;

-- EJERCICIO 5

SELECT
    nomem   AS nombre,
    salar   AS salario
FROM
    temple
WHERE
    salar > ALL (
        SELECT
            comis * 20
        FROM
            temple
        WHERE
            comis IS NOT NULL
    )
ORDER BY
    nomem;
    
-- EJERCICIO 6

SELECT
    nomem   AS nombre,
    salar   AS salario
FROM
    temple
WHERE
    salar < ALL (
        SELECT
            comis * 20
        FROM
            temple
        WHERE
            comis IS NOT NULL
    )
ORDER BY
    nomem;