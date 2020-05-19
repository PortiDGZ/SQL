-- Ejercicio 2

SET SERVEROUTPUT ON;

-- 1) Desarrollar un procedimiento que visualice el apellido y la fecha de alta de todos los empleados ordenados por apellido.
CREATE OR REPLACE PROCEDURE datos_por_apellido AS
    CURSOR empleados IS
    SELECT
        nomem,
        fecin
    FROM
        temple
    ORDER BY
        1;

BEGIN
    FOR elem IN empleados LOOP
        dbms_output.put_line(substr(elem.nomem, 1, instr(elem.nomem, ',') - 1)
                             || ' ingresó el '
                             || elem.fecin
                             || '.');
    END LOOP;
END;
/

-- Ejemplo de uso
EXEC datos_por_apellido;

-- 2) Codificar un procedimiento que muestre el nombre de cada departamento y el número de empleados que tiene.
CREATE OR REPLACE PROCEDURE empleados_ AS

    CURSOR departs IS
    SELECT
        nomde,
        COUNT(*) total
    FROM
        temple   e
        JOIN tdepto   d ON e.numde = d.numde
    GROUP BY
        nomde;

BEGIN
    FOR elem IN departs LOOP
        dbms_output.put_line('El departamento de '
                             || elem.nomde
                             || ' tiene '
                             || elem.total
                             || ' empleados.');
    END LOOP;
END;
/

-- Ejemplo de uso
EXEC empleados_;

-- 3) Escribir un procedimiento que reciba una cadena y visualice el apellido y el número de empleado de todos los empleados cuyo 
-- apellido contenga la cadena especificada. Al finalizar visualizar el número de empleados mostrados.
CREATE OR REPLACE PROCEDURE buscar_empleado (
    apellido VARCHAR2
) AS

    CURSOR empl IS
    SELECT
        numem,
        substr(nomem, 1, instr(nomem, ',') - 1) AS apell
    FROM
        temple
    WHERE
        instr(substr(nomem, 1, instr(nomem, ',') - 1), upper(apellido)) <> 0;

    total NUMBER := 0;
BEGIN
    FOR elem IN empl LOOP
        dbms_output.put_line('Empleado '
                             || elem.numem
                             || ': '
                             || elem.apell);

        total := total + 1;
    END LOOP;

    dbms_output.put_line('Empleados encontrados: ' || total);
END;
/

-- Ejemplo de uso
EXEC buscar_empleado(&apellido);

-- 4) Escribir un procedimiento que visualice el apellido y el salario de los cinco empleados que tienen el salario más alto.
CREATE OR REPLACE PROCEDURE cinco_mas_altos AS

    CURSOR emple IS
    SELECT
        salar,
        substr(nomem, 1, instr(nomem, ',') - 1) AS apellido
    FROM
        temple
    ORDER BY
        salar DESC;

    ciclo NUMBER := 0;
BEGIN
    FOR elem IN emple LOOP
        dbms_output.put_line('Salario de '
                             || elem.apellido
                             || ': '
                             || elem.salar
                             || ' €');

        ciclo := ciclo + 1;
        IF ciclo = 5 THEN
            EXIT;
        END IF;
    END LOOP;
END;
/

-- Ejemplo de uso
EXEC cinco_mas_altos;

-- 5) Codificar un programa que visualice los dos empleados que ganan menos de cada DEPARTAMENTO.
CREATE OR REPLACE FUNCTION e_menos_sal (
    dep   NUMBER,
    pos   NUMBER
) RETURN temple%rowtype AS

    CURSOR empleados IS
    SELECT
        *
    FROM
        temple
    WHERE
        numde = dep
    ORDER BY
        salar;

    ciclo NUMBER := 0;
BEGIN
    FOR elem IN empleados LOOP
        ciclo := ciclo + 1;
        IF ciclo = pos THEN
            RETURN elem;
        END IF;
    END LOOP;
    RETURN NULL;
END;
/

CREATE OR REPLACE PROCEDURE dos_menos_departamento IS
    CURSOR departamentos IS
    SELECT
        numde
    FROM
        tdepto;

    ciclo      NUMBER := 0;
    empleado   temple%rowtype;
BEGIN
    FOR elem IN departamentos LOOP
        dbms_output.put_line('Departamento '
                             || elem.numde
                             || ':');
        empleado := e_menos_sal(elem.numde, 1);
        IF empleado.numem IS NOT NULL THEN
            dbms_output.put_line('Empleado '
                                 || empleado.numem
                                 || ': '
                                 || empleado.nomem
                                 || ', salario de '
                                 || empleado.salar
                                 || ' €');
        END IF;

        empleado := e_menos_sal(elem.numde, 2);
        IF empleado.numem IS NOT NULL THEN
            dbms_output.put_line('Empleado '
                                 || empleado.numem
                                 || ': '
                                 || empleado.nomem
                                 || ', salario de '
                                 || empleado.salar
                                 || ' €');
        END IF;

    END LOOP;
END;
/

-- Ejemplo de uso
EXEC dos_menos_departamento;

-- 7) Desarrollar un procedimiento que permita insertar nuevos departamentos según las siguientes especificaciones:
-- Se pasará al procedimiento el nombre del departamento.
-- El procedimiento insertará la fila nueva asignando como número de departamento la decena siguiente al número mayor de la tabla.
-- Se incluirá gestión de posibles errores.(El nombre no debe estar duplicado)
CREATE OR REPLACE PROCEDURE crear_departamento_con_nombre (
    nombre VARCHAR2
) AS
    maximo   NUMBER := 0;
    deps     NUMBER := 0;
BEGIN
    SELECT
        COUNT(*)
    INTO deps
    FROM
        tdepto
    WHERE
        nomde = upper(nombre);

    IF deps = 0 THEN
        SELECT
            MAX(numde)
        INTO maximo
        FROM
            tdepto;

        maximo := trunc(maximo / 10) * 10 + 10;
        INSERT INTO tdepto (
            numde,
            nomde
        ) VALUES (
            maximo,
            upper(nombre)
        );

        dbms_output.put_line('Departamento creado correctamente.');
    ELSE
        dbms_output.put_line('Nombre de departamento duplicado.');
    END IF;

END;
/

-- Ejemplo de uso
EXEC crear_departamento_con_nombre(&nombre);

-- 8) Escribir un procedimiento que reciba todos los datos de un nuevo empleado procese la transacción de alta, gestionando posibles errores.
CREATE OR REPLACE PROCEDURE crear_empleado (
    numero         temple.numem%TYPE,
    nombre         temple.nomem%TYPE,
    departamento   temple.numde%TYPE,
    extension      temple.extel%TYPE,
    salario        temple.salar%TYPE,
    comision       temple.comis%TYPE,
    hijos          temple.numhi%TYPE,
    nacimiento     temple.fecna%TYPE,
    ingreso        temple.fecin%TYPE
) AS
BEGIN
    INSERT INTO temple VALUES (
        numero,
        departamento,
        extension,
        nacimiento,
        ingreso,
        salario,
        comision,
        hijos,
        upper(nombre)
    );

    dbms_output.put_line('Empleado creado correctamente.');
EXCEPTION
    WHEN dup_val_on_index THEN
        dbms_output.put_line('Número de empleado duplicado.');
    WHEN OTHERS THEN
        dbms_output.put_line('Error al crear empleado.');
END;
/

-- Ejemplo de uso
EXEC crear_empleado(520, 'alex', 112, 845, 1786, 300, 2, '05-02-1998', '23-12-2018');

-- 9) Codificar un procedimiento reciba como parámetros un numero de departamento, un importe y un porcentaje; y suba el salario 
-- a todos los empleados del departamento indicado en la llamada. La subida será el porcentaje o el importe indicado en la llamada 
-- (el que sea más beneficioso para el empleado en cada caso empleado).
CREATE OR REPLACE PROCEDURE subir_salarios_departamento (
    departamento   tdepto.numde%TYPE,
    importe        NUMBER,
    porcentaje     NUMBER
) AS
    salario1   NUMBER;
    salario2   NUMBER;
    CURSOR empleados IS
    SELECT
        numem,
        salar
    FROM
        temple
    WHERE
        numde = departamento;

BEGIN
    FOR elem IN empleados LOOP
        salario1 := elem.salar * ( 100 + porcentaje ) / 100;
        salario2 := elem.salar + importe;
        IF salario2 > salario1 THEN
            salario1 := salario2;
        END IF;
        UPDATE temple
        SET
            salar = salario1
        WHERE
            numem = elem.numem;

    END LOOP;
    
    dbms_output.put_line('Salario incrementado correctamente.');
END;
/

-- Ejemplo de uso
EXEC subir_salarios_departamento(&departamento, &importe, &porcentaje);