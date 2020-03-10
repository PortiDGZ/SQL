-- Práctica 16 Ejercicio 1 --
SELECT
    nomem "NOMBRE DE EMPLEADO",
    salar * 1.01 "SALARIO +1%"
FROM
    temple
WHERE
    numde = 100
    AND trunc(months_between(fecin, fecna) / 12) > 20
ORDER BY
    nomem DESC;
    
--Práctica 16 Ejercicio 2 --

SELECT
    numce,
    AVG(presu)
FROM
    tdepto
GROUP BY
    numce;

-- Práctica 16 Ejercicio 3 --

SELECT
    nomem,
    trunc((sysdate - fecna) / 365) "EDAD"
FROM
    temple   e,
    tdepto   d
WHERE
    e.numde = d.numde
    AND nomde = 'PERSONAL';

-- Práctica 16 Ejercicio 4 --

SELECT
    dirce,
    nomde
FROM
    temple   e
    JOIN tdepto   d ON ( e.numde = d.numde )
    JOIN tcentr   c ON ( c.numce = d.numce )
WHERE
    numhi > 3;


-- Práctica 16 Ejercicio 5 --

SELECT
    dirce,
    nomde
FROM
    tcentr   c
    JOIN tdepto   d ON ( c.numce = d.numce )
WHERE
    EXISTS (
        SELECT
            *
        FROM
            temple e
        WHERE
            numhi > 3
    );
    
-- Práctica 16 Ejercicio 6 --

SELECT
    COUNT(nomem),
    numhi
FROM
    temple
GROUP BY
    numhi;

-- Práctica 16 Ejercicio 7 --

CREATE VIEW sin_comisión AS
    ( SELECT
        nomem,
        trunc((sysdate - fecna) / 365) AS "Edad actual",
        salar || 'C' AS "Salario"
    FROM
        temple
    WHERE
        comis = 0
        OR comis IS NULL
    );

-- Práctica 16 Ejercicio 8 --

SELECT
    AVG(e.salar)
FROM
    temple         e
    JOIN sin_comisión   s ON e.nomem = s.nomem;