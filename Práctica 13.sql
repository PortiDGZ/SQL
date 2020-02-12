-- Práctica 13 Ejercicio 1 --
SELECT
    extel,
    COUNT(*)
FROM
    temple
GROUP BY
    extel
HAVING
    COUNT(*) > 1;
    
-- Práctica 13 Ejercicio 2 --

SELECT
    numce AS "Centro",
    AVG(presu * 1000)
    || '€' AS "PRESUPUESTO MEDIO"
FROM
    tdepto
GROUP BY
    numce;
    
-- Práctica 13 Ejercicio 3 --

DESCRIBE tdepto;

SELECT
    numce   AS "Número de centro",
    AVG(presu * 1000) AS "Presupuesto medio",
    tidir   AS "ESTADO"
FROM
    tdepto
WHERE
    tidir LIKE 'P'
    OR tidir LIKE 'F'
GROUP BY
    tidir,
    numce;
    
-- Práctica 13 Ejercicio 4 --

SELECT
    numde AS departamento,
    COUNT(DISTINCT extel) AS "NÚMERO DE EXTENSIONES"
FROM
    temple
GROUP BY
    numde
HAVING
    AVG(salar) > (
        SELECT
            AVG(salar)
        FROM
            temple
    );
    
-- Práctica 13 Ejercicio 5 --

SELECT
    numde,
    SUM(salar)
FROM
    temple
GROUP BY
    numde
HAVING
    SUM(salar) >= (
        SELECT
            MAX(SUM(salar))
        FROM
            temple
        GROUP BY
            numde
    );
    
-- Práctica 13 Ejercicio 6 --

SELECT
    d.numde,
    c.nomce,
    presu,
    MAX(salar)
FROM
    tdepto   d,
    tcentr   c,
    temple   e
WHERE
    ( d.numce = c.numce )
    AND ( e.numde = d.numde )
GROUP BY
    d.numde,
    c.nomce,
    presu
HAVING presu < 35
       AND MAX(salar) > 1500;
    
-- Práctica 13 Ejercicio 7 --

SELECT
    numde,
    round(AVG(salar), 2)
FROM
    temple
GROUP BY
    numde
HAVING
    AVG(salar) > ANY (
        SELECT
            AVG(salar)
        FROM
            temple
    );
    
-- Práctica 13 Ejercicio 8 --

SELECT
    d.numde,
    COUNT(*),
    SUM(salar),
    SUM(nvl(comis, 0)),
    SUM(numhi)
FROM
    tdepto   d
    JOIN temple   e ON ( d.numde = e.numde )
WHERE
    tidir = 'F'
GROUP BY
    d.numde;

-- Práctica 13 Ejercicio 9 --

SELECT
    d.numde,
    extel,
    COUNT(*)
FROM
    temple   e
    JOIN tdepto   d ON ( e.numde = d.numde )
WHERE
    presu > 35
GROUP BY
    d.numde,
    extel
ORDER BY
    1,
    2;