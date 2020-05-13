-- PR�CTICA 3


-- 1. Muestra el valor de las siguientes variables:
-- USER, ESCAPE, LINESIZE, COLSEP, PAGESIZE, ECHO, SQLPROMPT.
SHOW USER;

SHOW escape;

SHOW linesize;

SHOW colsep;

SHOW pagesize;

SHOW echo;

SHOW sqlprompt;

-- 2. Muestra el valor de las variables AUTOCOMMIT y SERVEROUTPUT.

SHOW autocommit;

SHOW serveroutput;

-- 3. Ejecuta el comando HELP SHOW para ver la ayuda acerca del comando SHOW.

HELP show;

-- 4. Ejecuta el comando HELP SET para ver la ayuda acerca del comando SET.

HELP set;

-- 5. Poner a ON las variables SERVEROUTPUT y AUTOCOMMIT.
SET SERVEROUTPUT ON;

SET AUTOCOMMIT ON;

-- 6. Crea un esquema llamado PLSQL con contrase�a PLSQL y rol DBA para realizar las siguientes actividades, en todos los casos indica cu�l es la salida junto con una peque�a explicaci�n

-- Crear usuario
CREATE USER plsql IDENTIFIED BY plsql;

-- Conceder dba
GRANT dba TO plsql;

    -- a. Ejecuta el siguiente bloque. Indica cu�l es la salida.
    BEGIN
        IF 10 > 5 THEN
            dbms_output.put_line('Cierto');
        ELSE
            dbms_output.put_line('Falso');
        END IF;
    END;
    
    -- CIERTO, DADO QUE LA CONDICI�N 10 > 5 ES VERDADERA
    
    -- b. Ejecuta el siguiente bloque. Indica cu�l es la salida.
    
    BEGIN
        IF 10 > 5 AND 5 > 1 THEN
            dbms_output.put_line('Cierto');
        ELSE
            dbms_output.put_line('Falso');
        END IF;
    END;
    
    -- CIERTO, DADO QUE TANTO LA CONDICI�N 10 > 5 COMO LA CONDICI�N 5 > 1 SON VERDADERAS
    
    -- c. Ejecuta el siguiente bloque. Indica cu�l es la salida.

    BEGIN
        IF 10 > 5 AND 5 > 50 THEN
            dbms_output.put_line('Cierto');
        ELSE
            dbms_output.put_line('Falso');
        END IF;
    END;
    
    -- FALSO, DADO QUE LA CONDICI�N 5 > 50 ES FALSA. BOOLEAN AND FALSO = FALSO.
    
    -- d. Ejecuta el siguiente bloque. Indica cu�l es la salida.

    BEGIN
        CASE
            WHEN 10 > 5 AND 5 > 50 THEN
                dbms_output.put_line('Cierto');
            ELSE
                dbms_output.put_line('Falso');
        END CASE;
    END;
    
    -- FALSO, DADO QUE LA CONDICI�N 5 > 50 ES FALSA. BOOLEAN AND FALSO = FALSO.
    
    -- e. Ejecuta el siguiente bloque. Indica cu�l es la salida.

    BEGIN
        FOR i IN 1..10 LOOP
            dbms_output.put_line(i);
        END LOOP;
    END;
    
    -- LOS N�MEROS DEL 1 AL 10, DADO QUE SE INVOCA UN BUCLE FOR DE 1 A 10 Y SE MUESTRA SU VARIABLE DE CONTROL.
    
    -- f. Ejecuta el siguiente bloque. Indica cu�l es la salida.

    BEGIN
        FOR i IN REVERSE 1..10 LOOP
            dbms_output.put_line(i);
        END LOOP;
    END;
    
    -- LOS N�MEROS DEL 10 AL 1, DADO QUE SE INVOCA UN BUCLE FOR DE 1 A 10 INVERTIDO Y SE MUESTRA SU VARIABLE DE CONTROL.
    
    -- g. Ejecuta el siguiente bloque. Indica cu�l es la salida.

    DECLARE
        num NUMBER(3) := 0;
    BEGIN
        WHILE num <= 100 LOOP
            dbms_output.put_line(num);
            num := num + 2;
        END LOOP;
    END;
    
    -- LOS N�MEROS PARES DEL 2 AL 100, DADO QUE TRAS ESE N�MERO SE ROMPE LA CONDICI�N NUM <= 100 Y SE INCREMENTA NUM DE 2 EN 2
    
    -- h. Ejecuta el siguiente bloque. Indica cu�l es la salida.

    DECLARE
        num NUMBER(3) := 0;
    BEGIN
        LOOP
            dbms_output.put_line(num);
            IF num > 100 THEN
                EXIT;
            END IF;
            num := num + 2;
        END LOOP;
    END;
    
    -- LOS N�MEROS DEL 0 AL 102, TRAS MOSTRAR 102 SE CUMPLE LA CONDICI�N DEL IF Y SE SALE DEL BUCLE
    
    -- i. Ejecuta el siguiente bloque. Indica cu�l es la salida.

    DECLARE
        num NUMBER(3) := 0;
    BEGIN
        LOOP
            dbms_output.put_line(num);
            EXIT WHEN num > 100;
            num := num + 2;
        END LOOP;
    END;
    
    -- LOS N�MEROS DEL 0 AL 102, TRAS MOSTRAR 102 SE CUMPLE LA CONDICI�N DEL WHEN Y SE SALE DEL BUCLE