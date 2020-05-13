-- Ejercicio 1 PL/SQL

SET SERVEROUTPUT ON;

-- Actividad 1
DECLARE
    filas NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO filas
    FROM
        temple;

    dbms_output.put_line('Número de filas: ' || filas);
END;
/

-- Actividad 2
CREATE OR REPLACE PROCEDURE nombre_empleado (
    numero NUMBER
) AS
    nombre VARCHAR2(20 BYTE);
BEGIN
    SELECT
        nomem
    INTO nombre
    FROM
        temple
    WHERE
        numem = numero;

    dbms_output.put_line('El nombre del empleado '
                         || numero
                         || ' es '
                         || nombre
                         || '.');

EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('No se ha encontrado empleado con ese número.');
END;
/

-- Ejemplo de llamada
EXEC nombre_empleado(&cod);

-- Actividad 3
CREATE OR REPLACE FUNCTION nombre_departamento (
    numero NUMBER
) RETURN VARCHAR2 AS
    nombre VARCHAR2(20 BYTE);
BEGIN
    SELECT
        nomde
    INTO nombre
    FROM
        tdepto
    WHERE
        numde = numero;

    RETURN nombre;
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('No se ha encontrado departamento con ese número.');
        RETURN '';
END;
/

-- Ejemplo de llamada
EXEC dbms_output.put_line(nombre_departamento(&cod));

-- Actividad 4
CREATE OR REPLACE FUNCTION maximo (
    n1   NUMBER,
    n2   NUMBER,
    n3   NUMBER
) RETURN NUMBER AS
    maximo NUMBER := n1;
BEGIN
    IF n2 > maximo THEN
        maximo := n2;
    END IF;
    IF n3 > maximo THEN
        maximo := n3;
    END IF;
    RETURN maximo;
END;
/

-- Ejemplo de llamada
EXEC dbms_output.put_line(maximo(&n1, &n2, &n3));

-- Actividad 5
CREATE OR REPLACE FUNCTION salario_empleado (
    numero NUMBER
) RETURN VARCHAR2 AS
    salario NUMBER;
BEGIN
    SELECT
        salar
    INTO salario
    FROM
        temple
    WHERE
        numem = numero;

    IF salario < 1500 THEN
        RETURN 'Bajo';
    ELSIF salario >= 3000 THEN
        RETURN 'Alto';
    ELSE
        RETURN 'Regular';
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('No se ha encontrado empleado con ese número.');
        RETURN '';
END;
/

-- Ejemplo de llamada
EXEC dbms_output.put_line(salario_empleado(&n));

-- Actividad 6 a
CREATE OR REPLACE FUNCTION factorial (
    numero NUMBER
) RETURN NUMBER AS
    resultado   NUMBER := 1;
    iteracion   NUMBER := 1;
BEGIN
    LOOP
        resultado := resultado * iteracion;
        iteracion := iteracion + 1;
        EXIT WHEN iteracion > numero;
    END LOOP;

    RETURN resultado;
END;
/

-- Ejemplo de llamada
EXEC dbms_output.put_line(factorial(&n));

-- Actividad 6 b
CREATE OR REPLACE FUNCTION factorial_b (
    numero NUMBER
) RETURN NUMBER AS
    resultado NUMBER := 1;
BEGIN
    FOR i IN 1..numero LOOP resultado := resultado * i;
    END LOOP;
    RETURN resultado;
END;
/

-- Ejemplo de llamada
EXEC dbms_output.put_line(factorial_b(&n));

-- Actividad 7 a
CREATE OR REPLACE PROCEDURE tabla_10 (
    numero NUMBER
) AS
BEGIN
    FOR i IN 1..10 LOOP
        dbms_output.put_line(numero
                             || ' x '
                             || i
                             || ' = '
                             || numero * i);
    END LOOP;
END;
/

-- Ejemplo de llamada
EXEC tabla_10(&n);

-- Actividad 7 b
CREATE OR REPLACE PROCEDURE tabla (
    numero   NUMBER,
    fin      NUMBER
) AS
BEGIN
    FOR i IN 1..fin LOOP
        dbms_output.put_line(numero
                             || ' x '
                             || i
                             || ' = '
                             || numero * i);
    END LOOP;
END;
/

-- Ejemplo de llamada
EXEC tabla(&n1, &n2);

-- Actividad 8
CREATE OR REPLACE FUNCTION par (
    numero NUMBER
) RETURN BOOLEAN AS
BEGIN
    RETURN MOD(numero, 2) = 0;
END;
/

-- Ejemplo de llamada
BEGIN
    IF par(&n) THEN
        dbms_output.put_line('Par.');
    ELSE
        dbms_output.put_line('Impar.');
    END IF;
END;
/

-- Actividad 9
CREATE OR REPLACE procedure datos (
    numero NUMBER
) AS
    departamento tdepto%rowtype;
BEGIN
    SELECT
        *
    INTO departamento
    FROM
        tdepto
    WHERE
        numde = numero;
        
    dbms_output.put_line('Número: ' || departamento.numde);
    dbms_output.put_line('Centro: ' || departamento.numce);
    dbms_output.put_line('Director: ' || departamento.direc);
    dbms_output.put_line('Tipo de director: ' || departamento.tidir);
    dbms_output.put_line('Presupuesto: ' || departamento.presu * 1000 || ' €');
    dbms_output.put_line('Depende de departamento: ' || departamento.depde);
    dbms_output.put_line('Nombre: ' || departamento.nomde);

END;
/

-- Ejemplo de llamada
EXEC datos(&n);

-- Actividad 10
CREATE OR REPLACE PROCEDURE plantilla (
    numero NUMBER
) AS
    empleados   NUMBER;
    salario     NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO empleados
    FROM
        temple
    WHERE
        numde = numero;

    SELECT
        SUM(salar)
    INTO salario
    FROM
        temple
    WHERE
        numde = numero;

    dbms_output.put_line('Número de empleados: ' || empleados);
    dbms_output.put_line('Suma de salarios de los empleados: '
                         || salario
                         || ' €');
END;
/

-- Ejemplo de llamada
EXEC plantilla(&n);

-- Actividad 11
CREATE OR REPLACE PROCEDURE nuevo_departamento (
    numero   NUMBER,
    nombre   VARCHAR2
) AS
BEGIN
    INSERT INTO tdepto (
        numde,
        nomde
    ) VALUES (
        numero,
        nombre
    );

END;
/

-- Ejemplo de llamada
EXEC nuevo_departamento(&num, &nom);

-- Actividad 12
CREATE TABLE resumendep (
    -- Atributos
    numde    NUMBER(3, 0) PRIMARY KEY,
    totemp   NUMBER(3),
    totsal   NUMBER(10)
);

INSERT INTO resumendep ( numde )
    SELECT
        numde
    FROM
        tdepto;
        
CREATE OR REPLACE PROCEDURE resumen_dep AS
    deps        NUMBER;
    empleados   NUMBER;
    salario     NUMBER;
    numero      NUMBER;
BEGIN
    SELECT
        COUNT(numde)
    INTO deps
    FROM
        tdepto;

    FOR i IN 1..deps LOOP
        SELECT
            numde
        INTO numero
        FROM
            (
                SELECT
                    numde,
                    ROW_NUMBER() OVER(
                        ORDER BY
                            numde
                    ) r
                FROM
                    tdepto
            ) d
        WHERE
            d.r = i;

        SELECT
            COUNT(*)
        INTO empleados
        FROM
            temple
        WHERE
            numde = numero;

        SELECT
            SUM(salar)
        INTO salario
        FROM
            temple
        WHERE
            numde = numero;

        UPDATE resumendep
        SET
            totemp = empleados,
            totsal = salario
        WHERE
            numde = numero;

    END LOOP;

END;
/

-- Ejemplo de llamada
EXEC resumen_dep;

-- Actividad 13
CREATE OR REPLACE PROCEDURE borra_dep (
    numero NUMBER
) AS
    empleados NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO empleados
    FROM
        temple
    WHERE
        numde = numero;

    IF empleados <= 0 THEN
        DELETE FROM tdepto
        WHERE
            numde = numero;

        dbms_output.put_line('Departamento eliminado.');
    ELSE
        dbms_output.put_line('No se puede eliminar el departamento.');
    END IF;

END;
/

-- Ejemplo de llamada
EXEC borra_dep(&n);

-- Actividad 14
CREATE OR REPLACE PROCEDURE suma (
    n1   NUMBER,
    n2   NUMBER
) AS
BEGIN
    dbms_output.put_line(n1 + n2);
END;
/

-- Ejemplo de llamada
EXEC suma(&n1, &n2);

-- Ejercicio 2

-- Actividad 1
declare
    Num1 number(8,2) := 0 -- Necesita fin de instrucción ;
    Num2 number(8,2) not null default 0;
    Num3 number(8,2) not null; -- Necesita inicialización := o default
    Cantidad Integer(3);
    Precio, Descuento number(6); -- No puedes declarar dos variables a la vez
    Num4 Num1%rowtype; -- Cambiar %rowtype por %type
    Dto constant integer; -- Necesita inicialización := o default
begin
    ...
end;

-- Actividad 2
EXEC crear_depart; -- Necesita argumentos. Número de departamento como mínimo.

EXEC crear_depart(50); -- Correcto

EXEC crear_depart('COMPRAS'); -- Necesita número de departamento como argumento

EXEC crear_depart(50,'COMPRAS'); -- Correcto

EXEC crear_depart('COMPRAS', 50); -- El orden de los argumentos es incorrecto
EXEC crear_depart(50,'COMPRAS'); -- Corrección

EXEC crear_depart('COMPRAS', 'VALENCIA'); -- Necesita número de departamento como argumento

EXEC crear_depart(50, 'COMPRAS', 'VALENCIA'); -- Correcto

EXEC crear_depart('COMPRAS', 50, 'VALENCIA'); -- El orden de los argumentos es incorrecto
EXEC crear_depart(50, 'COMPRAS', 'VALENCIA'); -- Corrección

EXEC crear_depart('VALENCIA', 'COMPRAS'); -- Necesita número de departamento como argumento

EXEC crear_depart('VALENCIA', 50); -- El orden de los argumentos es incorrecto
EXEC crear_depart(50,v_loc => 'VALENCIA'); -- Corrección

-- Actividad 3
CREATE OR REPLACE PROCEDURE reves (
    cadena VARCHAR2
) AS
    reves varchar2(100);
BEGIN
    FOR i IN REVERSE 1..length(cadena) LOOP
        reves := reves || substr(cadena, i, 1);
    END LOOP;

    dbms_output.put_line(reves);
END;
/

-- Ejemplo de llamada
EXEC reves(&s);

-- Actividad 4
CREATE OR REPLACE FUNCTION reves_f (
    cadena VARCHAR2
) RETURN VARCHAR2 AS
    reves VARCHAR2(100);
BEGIN
    FOR i IN REVERSE 1..length(cadena) LOOP 
        reves := reves || substr(cadena, i, 1);
    END LOOP;

    RETURN reves;
END;
/

-- Ejemplo de llamada
EXEC dbms_output.put_line(reves_f(&s));

-- Actividad 5
CREATE OR REPLACE FUNCTION año (
    fecha DATE
) RETURN NUMBER AS
BEGIN
    RETURN extract(YEAR FROM fecha);
END;
/

-- Ejemplo de llamada
EXEC dbms_output.put_line(año(&s));

-- Actividad 6
DECLARE
    vaño NUMBER;
BEGIN
    vaño := año(&tu_nacimiento);
    IF vaño < 2001 THEN
        dbms_output.put_line('Naciste en el siglo 20.');
    ELSE
        dbms_output.put_line('Naciste en el siglo 21.');
    END IF;

END;
/

-- Actividad 7
CREATE OR REPLACE FUNCTION años (
    inicial   DATE,
    ultima    DATE
) RETURN NUMBER AS
BEGIN
    RETURN trunc((ultima - inicial) / 365);
END;
/

-- Ejemplo de llamada
EXEC dbms_output.put_line(años(&s1, &s2));

-- Actividad 8
CREATE OR REPLACE FUNCTION trienios (
    inicial   DATE,
    ultima    DATE
) RETURN NUMBER AS
BEGIN
    RETURN trunc(años(inicial, ultima) / 3);
END;
/

-- Ejemplo de llamada
EXEC dbms_output.put_line(trienios(&s1, &s2));

-- Actividad 9
CREATE OR REPLACE FUNCTION suma_multiple (
    n1   NUMBER,
    n2   NUMBER,
    n3   NUMBER DEFAULT 0,
    n4   NUMBER DEFAULT 0,
    n5   NUMBER DEFAULT 0
) RETURN NUMBER AS
BEGIN
    RETURN n1 + n2 + n3 + n4 + n5;
END;
/

-- Ejemplo de llamada
EXEC dbms_output.put_line(suma_multiple(9, 4, 5));

-- Actividad 10
CREATE OR REPLACE FUNCTION es_alfa (
    caracter VARCHAR2
) return boolean AS BEGIN
    RETURN ( ascii(caracter) BETWEEN 65 AND 90 ) OR ( ascii(caracter) BETWEEN 97 AND 122 );
END;
/

CREATE OR REPLACE FUNCTION alfa (
    cadena VARCHAR2
) RETURN VARCHAR2 AS
    caracter   VARCHAR2(100);
    alfa       VARCHAR2(100);
BEGIN
    FOR i IN 1..length(cadena) LOOP
        caracter := substr(cadena, i, 1);
        IF es_alfa(caracter) THEN
            alfa := alfa || caracter;
        ELSE
            alfa := alfa || ' ';
        END IF;

    END LOOP;
    
    RETURN alfa;
END;
/

-- Ejemplo de llamada
EXEC dbms_output.put_line(alfa(&s));

-- Actividad 11
CREATE OR REPLACE PROCEDURE borrar_empleado (
    numero NUMBER
) AS
BEGIN
    DELETE FROM temple
    WHERE
        numem = numero;

END;
/

-- Ejemplo de llamada
EXEC borrar_empleado(&n);

-- Actividad 12
-- Los departamentos no tienen campo "localidad". Puede hacerse un método que cambie la dirección del centro pero afectará a todos los departamentos asociados.
/*
CREATE OR REPLACE PROCEDURE cambia_localidad (
    numero      NUMBER,
    direccion   VARCHAR2
) AS
BEGIN
    UPDATE tcentr
    SET
        dirce = direccion
    WHERE
        numce IN (
            SELECT
                numce
            FROM
                tdepto
            WHERE
                numde = numero
        );

END;
/
*/

-- Ejemplo de llamada
-- EXEC cambia_localidad(&n, &s);

-- Actividad 13
SELECT
    object_name   bloque,
    status        situación
FROM
    user_objects
WHERE
    object_type IN (
        'PROCEDURE',
        'FUNCTION'
    );