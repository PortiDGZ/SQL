-- Práctica 4 Ejercicio 1--
SELECT
    nomem
FROM
    temple
WHERE
    salar > ALL (
        SELECT
            salar
        FROM
            temple
        WHERE
            numde = '122'
    );
    
-- Práctica 4 Ejercicio 2--

SELECT
    nomem
FROM
    temple
WHERE
    salar > ALL (
        SELECT
            salar
        FROM
            temple
        WHERE
            numde = '150'
    );

-- Práctica 4 Ejercicio 3--

SELECT
    nomem
FROM
    temple
WHERE
    salar >= ANY (
        SELECT
            salar * 2.50
        FROM
            temple
        WHERE
            numde = '122'
    )
    ORDER BY nomem;
    
-- Práctica 4 Ejercicio 4 --

SELECT
    nomem,
    salar
FROM
    temple
WHERE
    salar = ANY (
        SELECT
            comis * 10
        FROM
            temple
    );

-- Práctica 4 Ejercicio 5--
     SELECT
      nomem,
      salar
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
      
-- Práctica 4 Ejercicio 6 --
SELECT
    nomem,
    salar
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