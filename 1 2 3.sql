-- EJERCICIO 1

SELECT
    COUNT(numem) AS "NÚMERO DE EMPLEADOS",
    SUM(numhi) AS hijos
FROM
    tdepto   d
    JOIN temple   e ON d.numde = e.numde
WHERE
    tidir = 'F'
GROUP BY
    e.numde;

-- EJERCICIO 2

SELECT
    nomde AS departamento
FROM
    tdepto   d
    JOIN temple   e ON d.numde = e.numde
WHERE
    tidir = 'F'
HAVING
    COUNT(numem) = 0
GROUP BY
    d.numde,
    nomde;
         
-- EJERCICIO 3

INSERT INTO tdepto (
    numde,
    nomde,
    tidir
) VALUES (
    137,
    'NUEVO',
    'F'
);

-- EJERCICIO 4

