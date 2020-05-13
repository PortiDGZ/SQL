-- Pr�ctica 4

SET SERVEROUTPUT ON;

-- Actividad 1. Crea un procedimiento llamado ESCRIBE para mostrar por pantalla el mensaje HOLA MUNDO.
CREATE OR REPLACE PROCEDURE escribe AS
BEGIN
    dbms_output.put_line('HOLA MUNDO');
END;
/

-- Actividad 2. Crea un procedimiento llamado ESCRIBE_MENSAJE que tenga un par�metro de tipo VARCHAR2 que recibe un texto 
-- y lo muestre por pantalla. La forma del procedimiento ser� la siguiente: ESCRIBE_MENSAJE (mensaje VARCHAR2).
CREATE OR REPLACE PROCEDURE escribe_mensaje (
    mensaje VARCHAR2
) AS
BEGIN
    dbms_output.put_line(mensaje);
END;
/

-- Actividad 3. Crea un procedimiento llamado SERIE que muestre por pantalla una serie de n�meros desde un m�nimo hasta un 
-- m�ximo con un determinado paso. La forma del procedimiento ser� la siguiente: SERIE (minimo NUMBER, maximo NUMBER, paso NUMBER)
CREATE OR REPLACE PROCEDURE serie (
    minimo   NUMBER,
    maximo   NUMBER,
    paso     NUMBER
) AS
    i NUMBER := minimo;
BEGIN
    dbms_output.put_line(minimo);
    WHILE maximo > i LOOP
        i := i + paso;
        dbms_output.put_line(i);
    END LOOP;
END;
/

-- Actividad 4. Crea una funci�n AZAR que reciba dos par�metros y genere un n�mero al azar entre un m�nimo y m�ximo indicado.
-- La forma de la funci�n ser� la siguiente: AZAR (minimo NUMBER, maximo NUMBER) RETURN NUMBER
-- Para obtener el n�mero aleatorio: DBMS_RANDOM.VALUE(MINIMO,MAXIMO);
CREATE OR REPLACE FUNCTION azar (
    minimo   NUMBER,
    maximo   NUMBER
) RETURN NUMBER AS
BEGIN
    RETURN dbms_random.value(minimo, maximo);
END;
/

-- Actividad 5. Crea una funci�n NOTA que reciba un par�metros que ser� una nota num�rica entre 0 y 10 y devuelva una cadena
-- de texto con la calificaci�n (Suficiente, Bien, Notable, ...). La forma de la funci�n ser� la siguiente:
-- NOTA (nota NUMBER) RETURN VARCHAR2
CREATE OR REPLACE FUNCTION nota (
    nota NUMBER
) RETURN VARCHAR2 AS
BEGIN
    IF nota <= 10 AND nota >= 9 THEN
        RETURN 'Sobresaliente.';
    ELSIF nota < 9 AND nota >= 7 THEN
        RETURN 'Notable.';
    ELSIF nota < 7 AND nota >= 6 THEN
        RETURN 'Bien.';
    ELSIF nota < 6 AND nota >= 5 THEN
        RETURN 'Suficiente.';
    ELSIF nota < 5 AND nota >= 0 THEN
        RETURN 'Insuficiente.';
    END IF;

    RETURN 'La nota no se encuentra en un formato correcto.';
END;
/

-- Actividad 6. Escribir un procedimiento que cambie el salario a un empleado. Ejemplo de llamada al procedimiento: cambia_salario(160,2500);
CREATE OR REPLACE PROCEDURE cambia_salario (
    empleado   NUMBER,
    salario    NUMBER
) AS
BEGIN
    UPDATE temple
    SET
        salar = salario
    WHERE
        numem = empleado;

END;
/

-- Actividad 7.  Crear un procedimiento que modifique  el salario de un empleado que es director en funci�n de los empleados que tiene a su cargo.
-- a. Si tiene un empleado se subir�n 80�
-- b. Si tiene 2 empleado se subir�n 100�
-- c. Si tiene m�s de 2 empleados se subir�n 110�.
-- Ejemplo de llamada al procedimiento: mod_sal_director(180);
CREATE OR REPLACE FUNCTION es_director (
    director NUMBER
) RETURN BOOLEAN AS
    encontrados NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO encontrados
    FROM
        tdepto
    WHERE
        direc = director;

    RETURN encontrados > 0;
END;
/

CREATE OR REPLACE FUNCTION empleados (
    director NUMBER
) RETURN NUMBER AS
    encontrados NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO encontrados
    FROM
        temple
    WHERE
        numde IN (
            SELECT
                numde
            FROM
                tdepto
            WHERE
                direc = director
        );

    RETURN encontrados;
END;
/

CREATE OR REPLACE PROCEDURE mod_sal_director (
    director NUMBER
) AS
    aumento NUMBER := 0;
BEGIN
    IF es_director(director) THEN
        CASE empleados(director)
            WHEN 0 THEN
                aumento := 0;
            WHEN 1 THEN
                aumento := 80;
            WHEN 2 THEN
                aumento := 100;
            ELSE
                aumento := 110;
        END CASE;

        UPDATE temple
        SET
            salar = salar + aumento
        WHERE
            numem = director;

    ELSE
        dbms_output.put_line('No existe director con ese n�mero.');
    END IF;
END;
/

-- Modifica el procedimiento utilizando una variable de sustituci�n para el n�mero de director.
CREATE OR REPLACE PROCEDURE mod_sal_director AS
    aumento    NUMBER := 0;
    director   NUMBER := &director;
BEGIN
    IF es_director(director) THEN
        CASE empleados(director)
            WHEN 0 THEN
                aumento := 0;
            WHEN 1 THEN
                aumento := 80;
            WHEN 2 THEN
                aumento := 100;
            ELSE
                aumento := 110;
        END CASE;

        UPDATE temple
        SET
            salar = salar + aumento
        WHERE
            numem = director;

    ELSE
        dbms_output.put_line('No existe director con ese n�mero.');
    END IF;
END;
/

-- 8. Construir un bloque PLSQL que escriba la cadena �HOLA� al rev�s.
DECLARE
    aloh VARCHAR2(4);
BEGIN
    FOR i IN REVERSE 1..4 LOOP 
    aloh := aloh || substr('HOLA', i, 1);
    END LOOP;

    dbms_output.put_line(aloh);
END;
