-- Pr�ctica 5

SET SERVEROUTPUT ON;

-- 1. Escribe un procedimiento que muestre el n�mero de empleados y el salario m�nimo, m�ximo y medio del departamento
-- de FINANZAS. Debe hacerse uso de cursores impl�citos, es decir utilizar SELECT ... INTO.
CREATE OR REPLACE PROCEDURE empleados_finanzas AS
    numero   NUMBER;
    minimo   NUMBER;
    maximo   NUMBER;
    medio    NUMBER;
BEGIN
    SELECT
        COUNT(*),
        MIN(salar),
        MAX(salar),
        round(AVG(salar), 2)
    INTO
        numero,
        minimo,
        maximo,
        medio
    FROM
        temple
    WHERE
        numde = (
            SELECT
                numde
            FROM
                tdepto
            WHERE
                nomde LIKE ( '%FINANZAS%' )
        );

    dbms_output.put_line('Empleados: ' || numero);
    dbms_output.put_line('Salario m�nimo: '
                         || minimo
                         || ' �');
    dbms_output.put_line('Salario m�ximo: '
                         || maximo
                         || ' �');
    dbms_output.put_line('Salario medio: '
                         || medio
                         || ' �');
END;
/

-- Ejemplo de llamada
EXEC empleados_finanzas;

-- 2. Escribe un procedimiento que suba un 10 % el salario a los EMPLEADOS con m�s de 2 hijos y que ganen menos de 2000 C.
-- Para cada empleado se mostrar� por pantalla el c�digo de empleado, nombre, salario anterior y final. Utiliza un cursor
-- expl�cito. La transacci�n no puede quedarse a medias. Si por cualquier raz�n no es posible actualizar todos estos 
-- salarios, debe deshacerse el trabajo a la situaci�n inicial.
CREATE OR REPLACE PROCEDURE empleados_10 AS

    CURSOR empleados IS
    SELECT
        numem
    FROM
        temple
    WHERE
        nvl(numhi, 0) > 2
        AND salar < 2000;

    i NUMBER := 1;
BEGIN
    FOR elem IN empleados LOOP
        UPDATE temple
        SET
            salar = salar * 1.1
        WHERE
            numem = elem.numem;

    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
END;
/

-- Ejemplo de llamada
EXEC empleados_10;

-- 3. Escribe un procedimiento que reciba dos par�metros (n�mero de departamento, hijos). Deber� crearse un cursor expl�cito 
-- al que se le pasar�n estos par�metros y que mostrar� los datos de los empleados que pertenezcan al departamento y con el 
-- n�mero de hijos indicados. Al final se indicar� el n�mero de empleados obtenidos.
CREATE OR REPLACE PROCEDURE mostrar_empleados (
    departamento   NUMBER,
    hijos          NUMBER
) AS

    total NUMBER := 0;
    CURSOR empleados IS
    SELECT
        *
    FROM
        temple
    WHERE
        numde = departamento
        AND nvl(numhi, 0) = hijos;

BEGIN
    FOR elem IN empleados LOOP
        dbms_output.put_line('Empleado: ' || elem.numem);
        dbms_output.put_line('Nombre: ' || elem.nomem);
        dbms_output.put_line('Departamento: ' || elem.numde);
        dbms_output.put_line('Extensi�n telef�nica: ' || elem.extel);
        dbms_output.put_line('Fecha de nacimiento: ' || elem.fecna);
        dbms_output.put_line('Fecha de ingreso: ' || elem.fecin);
        dbms_output.put_line('Salario: '
                             || elem.salar
                             || ' �');
        dbms_output.put_line('Comisi�n: ' || elem.comis);
        dbms_output.put_line('N�mero de hijos: ' || elem.numhi);
        dbms_output.put_line('');
        
        total := total + 1;
    END LOOP;

    dbms_output.put_line('Empleados totales: ' || total);
END;
/

-- Ejemplo de llamada
EXEC mostrar_empleados(&departamento, &hijos);

-- 4. Escribe un procedimiento con un par�metro para el nombre de empleado, que nos muestre la edad de dicho empleado en a�os, meses y d�as.
CREATE OR REPLACE PROCEDURE edad_empleado (
    nombre VARCHAR2
) AS
    edad NUMBER;
BEGIN
    SELECT
        sysdate - fecna
    INTO edad
    FROM
        temple
    WHERE
        upper(nomem) LIKE '%, '
                           || upper(nombre)
                           || '%';

    dbms_output.put_line('Edad: ' || trunc(edad / 365));
    dbms_output.put_line('Edad en meses: ' || trunc(edad / 12));
    dbms_output.put_line('Edad en d�as: ' || trunc(edad));
END;
/

-- Ejemplo de llamada
EXEC edad_empleado(&nombre);