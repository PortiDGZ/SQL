-- EJERCICIO 1

SELECT
    nomem AS nombre
FROM
    temple
WHERE
    extel IN (
        250,
        750
    )
ORDER BY
    nomem;

-- EJERCICIO 2

SELECT
    nomem AS nombre
FROM
    temple
WHERE
    numde IN (
        (
            SELECT
                numde
            FROM
                temple
            WHERE
                nomem LIKE ( '%PILAR' )
        ),
        (
            SELECT
                numde
            FROM
                temple
            WHERE
                nomem LIKE ( '%DOROTEA' )
        )
    )
ORDER BY
    nomem;
    
-- EJERCICIO 3

SELECT
    nomde   AS "NOMBRES DEPARTAMENTOS",
    direc   AS "IDENTIFICADOR DE DIRECTOR"
FROM
    tdepto
WHERE
    direc IN (
        (
            SELECT
                direc
            FROM
                tdepto
            WHERE
                nomde = 'DIRECCIÓN COMERCIAL'
        ),
        (
            SELECT
                direc
            FROM
                tdepto
            WHERE
                nomde = 'PERSONAL'
        )
    )
ORDER BY
    nomde;