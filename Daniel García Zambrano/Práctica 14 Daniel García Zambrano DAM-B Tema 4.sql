-- EJERCICIO 1

SELECT
    NOMEM AS NOMBRE,
    numhi AS hijos
FROM
    tdepto   d
    JOIN temple   e ON d.direc = e.numem
WHERE
    tidir = 'F';

-- EJERCICIO 2

SELECT
    nomde AS departamento
FROM
    tdepto   d
    LEFT JOIN temple   e ON d.numde = e.numde
WHERE
    e.numde IS NULL
    AND tidir <> 'P';
         
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

INSERT INTO temple (
    numem,
    nomem,
    extel,
    fecna,
    fecin,
    salar,
    comis,
    numhi
) VALUES (
    560,
    'NORBERTO',
    485,
    '12/05/1990',
    '30/1/2012',
    2000,
    200,
    0
);

-- EJERCICIO 5

SELECT
    nomde AS departamento
FROM
    tdepto   d
    LEFT JOIN temple   e ON d.numde = e.numde
WHERE
    e.numde IS NULL;
    
-- EJERCICIO 6

SELECT
    nomde   AS departamento,
    nomem   AS empleado
FROM
    tdepto   d
    LEFT JOIN temple   e ON d.numde = e.numde
WHERE
    e.numde IS NULL;
    
-- EJERCICIO 7

SELECT
    nomem   AS empleado,
    nomde   AS departamento
FROM
    tdepto   d
    RIGHT JOIN temple   e ON d.numde = e.numde
WHERE
    e.numde IS NULL;
    
-- EJERCICIO 8

SELECT
    nomde   AS departamento,
    nomem   AS empleado
FROM
    tdepto   d
    FULL JOIN temple   e ON d.numde = e.numde
WHERE
    d.numde IS NULL
    OR e.numem IS NULL;
    
-- EJERCICIO 9

SELECT
    nomem   AS empleado,
    nomde   AS departamento
FROM
    tdepto   d
    INNER JOIN temple   e ON d.numde = e.numde;
    
-- EJERCICIO 10

SELECT
    nomem   AS empleado,
    nomde   AS departamento
FROM
    tdepto   d
    INNER JOIN temple   e ON d.numde = e.numde
WHERE
    e.numde IS NULL;
    
-- EJERCICIO 11

SELECT
    nomem   AS empleado,
    nomde   AS departamento
FROM
    tdepto   d
    NATURAL JOIN temple   e;
    
-- EJERCICIO 12

SELECT
    nomem   AS empleado,
    nomde   AS departamento,
    nomce   AS centro
FROM
    tdepto   d
    NATURAL JOIN temple   e
    NATURAL JOIN tcentr   c;
    
-- EJERCICIO 13

DELETE FROM tdepto
WHERE
    numde = 137;
    
DELETE FROM temple
WHERE
    numem = 560;