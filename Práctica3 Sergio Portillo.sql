    --------------------------------
        
        -- Práctica 3 Ejercicio 1--
    SELECT
        'DEPARTAMENTO DE ' || nomde AS "NOMBRE"
    FROM
        tdepto
    WHERE
        presu * 1000 < 30000
    ORDER BY
        nomde;
        
        -- Práctica 3 Ejercicio 2--
    
    SELECT
        numde
        || '-'
        || nomde AS "Número-Nombre",
        tidir AS "T"
    FROM
        tdepto
    WHERE
        presu < '30';
        
        -- Práctica 3 Ejercicio 3--
    
    SELECT
        nomem AS "Nombre",
        salar * 12 AS "Salario 2014",
        salar * 12 * 1.02 AS "Salario 2015",
        salar * 12 * 1.02 * 1.02 AS "Salario 2016"
    FROM
        temple
    WHERE
        numhi > 4
    ORDER BY
        nomem DESC;
        
        -- Práctica 3 Ejercicio 4--
    
    SELECT
        nomem
    FROM
        temple
    WHERE
        salar * 0.20 < numhi * 120;
        
        -- Práctica 3 Ejercicio 5--
    
    SELECT
        nomem,
        salar + comis
    FROM
        temple
    WHERE
        numde IN (
            112
        )
    ORDER BY
        salar + comis DESC,
        nomem ASC;
        
        -- Práctica 3 Ejercicio 6--
    
    SELECT
        nomem,
        salar + comis
    FROM
        temple
    WHERE
        numde IN (
            112
        )
        AND comis IS NOT NULL
    ORDER BY
        salar + comis DESC,
        nomem ASC;
        
        -- Práctica 3 Ejercicio 7--
    
    SELECT
        nomem AS "NOMBRE",
        salar + comis || ' €' AS "SALARIO TOTAL"
    FROM
        temple
    WHERE
        numde IN (
            112
        )
        AND comis IS NOT NULL
    ORDER BY
        salar + comis DESC,
        nomem ASC;
        
        -- Práctica 3 Ejercicio 8--
    
    SELECT
        nomem AS "NOMBRE",
        salar + ( numhi - 3 ) * ( 60 )
        || ' €' AS "Salario Total"
    FROM
        temple
    WHERE
        numhi >= 4;
        
        -- Práctica 3 Ejercicio 9--
    
    SELECT
        nomem AS "NOMBRE",
        salar + ( numhi - 3 ) * ( 60 )
        || ' €' AS "Salario Total"
    FROM
        temple
    WHERE
        numhi >= (
            SELECT
                numhi
            FROM
                temple
            WHERE
                nomem LIKE '%JULIANA'
        )
    ORDER BY
        numhi;
        
        -- Práctica 3 Ejercicio 10--
    
    SELECT
        nomem
    FROM
        temple
    WHERE
        salar >= 1.15 * (
            SELECT
                salar
            FROM
                temple
            WHERE
                nomem LIKE '%CLAUDIA'
        );
        
        -- Práctica 3 Ejercicio 11--
    
    SELECT
        nomde
    FROM
        tdepto
    WHERE
        depde IS NULL;