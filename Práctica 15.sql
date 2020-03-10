-- Pr�ctica 15 Ejercicio 1 --
CREATE VIEW vista1 AS
    ( SELECT
        numem,
        nomem,
        salar,
        comis
    FROM
        temple
    WHERE
        numde = 111
    );

-- Pr�ctica 15 Ejercicio 2 --

CREATE VIEW vista2 AS
    ( SELECT
        MAX(SUM(salar)) maximo_sal
    FROM
        temple
    GROUP BY
        numde
    );

-- Pr�ctica 15 Ejercicio 3 --

SELECT
    numde,
    SUM(salar)
FROM
    temple
GROUP BY
    numde
HAVING
    SUM(salar) = (
        SELECT
            *
        FROM
            vista2
    );
    
-- Pr�ctica 15 Ejercicio 4 --

SELECT
    nomem
FROM
    vista1
WHERE
    comis IS NOT NULL
ORDER BY
    nomem;

-- Pr�ctica 15 Ejercicio 5 --

INSERT INTO vista1 VALUES (
    999,
    'RODOLFO',
    999,
    999
);

-- Pr�ctica 15 Ejercicio 6 --

DELETE FROM temple
WHERE
    nomem = 'RODOLFO';

DESCRIBE tcentr;
    
-- Pr�ctica 15 Ejercicio 7 --

CREATE VIEW vista3 AS
    ( SELECT
        c.nomce,
        c.numce,
        c.dirce,
        d.numde,
        d.direc,
        d.tidir,
        d.presu,
        d.nomde,
        d.depde
    FROM
        tcentr   c
        JOIN tdepto   d ON c.numce = d.numce
    );
    
-- Pr�ctica 15 Ejercicio 8 --

SELECT
    nomce,
    SUM(presu)
FROM
    vista3
GROUP BY
    nomce;
    
-- Pr�ctica 15 Ejercicio 9 --

INSERT INTO vista3 (
    numce,
    nomce,
    numde,
    direc,
    tidir,
    presu,
    depde,
    nomde
) VALUES (
    30,
    'SUCURSAL �CIJA',
    200,
    120,
    'F',
    20,
    110,
    'CONTABILIDAD'
);

-- Pr�ctica 15 Ejercicio 10 --

-- No se puede