-- Práctica 14 Ejercicio 1 --
SELECT
    e.nomem,
    e.numhi,
    d.direc,
    e.numem,
    d.tidir
FROM
    tdepto   d
    JOIN temple   e ON d.direc= e.numem
WHERE
    tidir = 'F'
ORDER BY e.nomem;

-- Práctica 14 Ejercicio 2 --
         
select numde from tdepto where numde NOT
in

( SELECT
    numde
FROM
    temple
);
         
-- Práctica 14 Ejercicio 3 --

INSERT INTO tdepto VALUES (
   300,10,180,'F',10,110,'NUEVO');

-- Práctica 14 Ejercicio 4 --

SELECT
    extel
FROM
    temple;

INSERT INTO temple (
    numem,
    nomem,
    fecna,
    fecin,
    salar,
    comis,
    extel
) VALUES (
    560,
    'NORBERTO',
    '11 / 11 / 1963',
    '12 / 12 / 1987',
    1350,
    100,
    340
);

-- Práctica 14 Ejercicio 5 --

select * from tdepto where numde NOT
in

( SELECT
    numde
FROM
    temple
WHERE
    numde IS NOT NULL
);

-- Práctica 14 Ejercicio 6 --

SELECT
    nomde,
    nomem
FROM
    tdepto   d
    LEFT JOIN temple   e ON d.numde = e.numde
WHERE
    numem IS NULL;
    
-- Práctica 14 Ejercicio 7 --

SELECT
    nomem,
    nomde
FROM
    tdepto   d
    RIGHT JOIN temple   e ON d.numde = e.numde
WHERE
    d.numde IS NULL;
    
-- Práctica 14 Ejercicio 8 --

SELECT
    d.nomde,
    d.numde,
    e.numde,
    e.nomem
FROM
    tdepto   d
    FULL JOIN temple   e ON d.numde = e.numde
WHERE
    d.numde IS NULL
    OR e.numem IS NULL
ORDER BY
    1;

-- Práctica 14 Ejercicio 9 --

SELECT
    d.nomde,
    d.numde,
    e.numde,
    e.nomem
FROM
    tdepto   d
    INNER JOIN temple   e ON d.numde = e.numde
WHERE
    d.numde IS NOT NULL
    OR e.numde IS NOT NULL
ORDER BY
    1;

-- Práctica 14 Ejercicio 10 --

SELECT
    d.nomde,
    d.numde,
    e.numde,
    e.nomem
FROM
    tdepto   d
    INNER JOIN temple   e ON d.numde = e.numde
WHERE
    d.numde IS NULL
ORDER BY
    1;

-- Práctica 14 Ejercicio 11 --

SELECT
    nomde,
    nomem
FROM
    tdepto
    NATURAL JOIN temple;

-- Práctica 14 Ejercicio 12 --

SELECT
    nomde,
    nomem,
    nomce
FROM
    tdepto
    NATURAL JOIN temple
    NATURAL JOIN tcentr;

-- Práctica 14 Ejercicio 13 --

delete from tdepto where numde = 300;
delete from temple where nomem = 'NORBERTO';