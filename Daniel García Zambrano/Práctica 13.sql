-- EJERCICIO 1

SELECT
    extel AS "EXTENSIÓN TELEFÓNICA",
    COUNT(*) AS "NÚMERO DE EMPLEADOS"
FROM
    temple
HAVING
    COUNT(*) > 1
GROUP
    by extel;
    
-- EJERCICIO 2

SELECT
    numce AS centro,
    AVG(presu * 1000) AS "PRESUPUESTO MEDIO"
FROM
    tdepto
GROUP BY
    numce;
    
-- EJERCICIO 3

SELECT
    numce   AS centro,
    tidir   AS "TIPO DE DIRECCIÓN",
    AVG(presu * 1000) AS "PRESUPUESTO MEDIO"
FROM
    tdepto
GROUP BY
    numce,
    tidir;
    
-- EJERCICIO 4

SELECT
    numde AS departamento,
    COUNT(DISTINCT extel) AS "NÚMERO DE EXTENSIONES"
FROM
    temple
HAVING
    AVG(salar) > (
        SELECT
            AVG(salar)
        FROM
            temple
    )
GROUP
    by numde;
    
-- EJERCICIO 5

SELECT
    MAX(SUM(salar)) AS máximo
FROM
    temple
GROUP BY
    numde;
    
-- OTRAS CONSULTAS

-- EXTRA 1

SELECT
    nomde AS departamento,
    (
        SELECT
            nomce
        FROM
            tcentr
        WHERE
            d.numce = numce
    ) AS centro,
    (
        SELECT
            MAX(salar)
        FROM
            temple
        WHERE
            d.numde = numde
    ) AS "SALARIO MÁXIMO"
FROM
    tdepto d
WHERE
    presu * 1000 < 30000
    AND (
        SELECT
            MAX(salar)
        FROM
            temple
        WHERE
            d.numde = numde
    ) > 1500
ORDER BY
    nomde;
    
-- EXTRA 2

SELECT
    nomde AS departamento,
    (
        SELECT
            trunc(AVG(salar), 2)
        FROM
            temple
        WHERE
            d.numde = numde
    ) AS "SALARIO MEDIO"
FROM
    tdepto d;
    
-- EXTRA 3

SELECT
    nomde AS departamento,
    (
        SELECT
            COUNT(*)
        FROM
            temple
        WHERE
            d.numde = numde
    ) AS "NÚMERO DE EMPLEADOS",
    (
        SELECT
            SUM(nvl(salar, 0))
        FROM
            temple
        WHERE
            d.numde = numde
    ) AS "SUMA DE SALARIOS",
    (
        SELECT
            SUM(nvl(comis, 0))
        FROM
            temple
        WHERE
            d.numde = numde
    ) AS "SUMA DE COMISIONES",
    (
        SELECT
            SUM(nvl(numhi, 0))
        FROM
            temple
        WHERE
            d.numde = numde
    ) AS "HIJOS"
FROM
    tdepto d
WHERE
    tidir = 'F';
    
-- EXTRA 4

SELECT
    nomde AS departamento,
    (
        SELECT
            COUNT(DISTINCT extel)
        FROM
            temple
        WHERE
            d.numde = numde
    ) AS "EXTENSIONES DISTINTAS"
FROM
    tdepto d
WHERE
    presu * 1000 > 35000;