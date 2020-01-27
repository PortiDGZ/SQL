-- Práctica 5 Ejercicio 1 --
SELECT
    nomem
FROM
    temple
WHERE
    salar BETWEEN 1500 AND 1600
ORDER BY
    nomem;
    
-- Práctica 5 Ejercicio 2 --

SELECT
    nomem,
    salar
FROM
    temple
WHERE
    comis IS NOT NULL
    AND numhi <> 0
    AND salar / numhi BETWEEN comis * 50 AND 720
ORDER BY
    nomem;