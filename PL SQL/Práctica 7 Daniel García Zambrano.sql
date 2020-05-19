-- Práctica 7

CREATE TABLE auditoria_empleados (
    descripcion VARCHAR2(200)
);

CREATE VIEW sede_departamentos AS
    SELECT
        c.numce,
        c.nomce,
        c.dirce,
        d.numde,
        d.nomde,
        d.presu,
        d.direc,
        d.tidir,
        d.depde
    FROM
        tcentr         c
        JOIN tdepto   d ON c.numce = d.numce;
        
INSERT INTO tdepto VALUES (
    0,
    10,
    260,
    'F',
    10,
    100,
    'TEMP'
);

-- 1. Crea un trigger que, cada vez que se inserte o elimine un empleado, registre una entrada en la tabla AUDITORIA_EMPLEADOS con la fecha del suceso,
-- número y nombre de empleado, así como el tipo de operación realizada (INSERCIÓN o ELIMINACIÓN).
CREATE OR REPLACE TRIGGER ins_el_empleado AFTER
    INSERT OR DELETE ON temple
    FOR EACH ROW
DECLARE
    descrip VARCHAR2(200);
BEGIN
    descrip := sysdate;
    IF inserting THEN
        descrip := descrip || ' Insertado empleado ';
    ELSIF deleting THEN
        descrip := descrip || ' Eliminado empleado ';
    END IF;

    descrip := descrip
               || :new.numem
               || ' ('
               || :new.nomem
               || ').';
    INSERT INTO auditoria_empleados VALUES ( descrip );

END;
/

-- Ejemplo
INSERT INTO temple (
    numem,
    nomem
) VALUES (
    687,
    'SÁNCHEZ, MARTA'
);

-- 2. Crea un trigger que, cada vez que se modifiquen datos de un empleado, registre una entrada en la tabla AUDITORIA_EMPLEADOS con la fecha del suceso,
-- valor antiguo y valor nuevo de cada campo, así como el tipo de operación realizada (en este caso MODIFICACIÓN).
CREATE OR REPLACE TRIGGER mod_empleado AFTER
    UPDATE ON temple
    FOR EACH ROW
DECLARE
    descrip VARCHAR2(200);
BEGIN
    descrip := sysdate
               || ' Modificado empleado '
               || :new.numem
               || ': ';
    IF :old.numem <> :new.numem THEN
        descrip := descrip
                   || :old.numem
                   || ' => '
                   || :new.numem
                   || ', ';

    END IF;

    IF :old.numde <> :new.numde THEN
        descrip := descrip
                   || :old.numde
                   || ' => '
                   || :new.numde
                   || ', ';
    END IF;

    IF :old.extel <> :new.extel THEN
        descrip := descrip
                   || :old.extel
                   || ' => '
                   || :new.extel
                   || ', ';
    END IF;

    IF :old.fecna <> :new.fecna THEN
        descrip := descrip
                   || :old.fecna
                   || ' => '
                   || :new.fecna
                   || ', ';
    END IF;

    IF :old.fecin <> :new.fecin THEN
        descrip := descrip
                   || :old.fecin
                   || ' => '
                   || :new.fecin
                   || ', ';
    END IF;

    IF :old.salar <> :new.salar THEN
        descrip := descrip
                   || :old.salar
                   || ' => '
                   || :new.salar
                   || ', ';
    END IF;

    IF :old.comis <> :new.comis THEN
        descrip := descrip
                   || :old.comis
                   || ' => '
                   || :new.comis
                   || ', ';
    END IF;

    IF :old.numhi <> :new.numhi THEN
        descrip := descrip
                   || :old.numhi
                   || ' => '
                   || :new.numhi
                   || ', ';
    END IF;

    IF :old.nomem <> :new.nomem THEN
        descrip := descrip
                   || :old.nomem
                   || ' => '
                   || :new.nomem;
    END IF;

    INSERT INTO auditoria_empleados VALUES ( descrip );

END;
/

-- Ejemplo
UPDATE temple
SET
    numem = 199
WHERE
    numem = 548;
    
-- 3. Crea un trigger para que registre en la tabla AUDITORIA_EMPLEADOS las subidas de salarios superiores al 5 %.
CREATE OR REPLACE TRIGGER mod_salar_05 AFTER
    UPDATE OF salar ON temple
    FOR EACH ROW
    WHEN ( new.salar > old.salar * 1.05 )
DECLARE
    descrip VARCHAR2(200);
BEGIN
    descrip := sysdate
               || ' Modificado salario de empleado '
               || :new.numem
               || ': '
               || :old.salar
               || ' => '
               || :new.salar
               || '.';
               
    INSERT INTO auditoria_empleados VALUES ( descrip );
END;
/

-- Ejemplo
UPDATE temple
SET
    salar = salar * 1.10
WHERE
    numem = 110;

-- 4. Deseamos operar sobre los datos de los departamentos y los centros donde se hallan. Para ello haremos uso de la vista SEDE_DEPARTAMENTOS creada anteriormente.
-- Al tratarse de una vista que involucra más de una tabla, necesitaremos crear un trigger de sustitución para gestionar las operaciones de actualización de la información.
-- Crea el trigger necesario para realizar inserciones, eliminaciones y modificaciones en la vista anterior.
CREATE OR REPLACE TRIGGER tr_sede_depart INSTEAD OF
    INSERT OR UPDATE OR DELETE ON sede_departamentos
    FOR EACH ROW
DECLARE
    ccount   NUMBER;
    dcount   NUMBER;
BEGIN
    IF inserting THEN
        SELECT
            COUNT(*)
        INTO ccount
        FROM
            tcentr
        WHERE
            numce = :new.numce;

        IF ccount = 0 THEN
            INSERT INTO tcentr (
                numce,
                nomce,
                dirce
            ) VALUES (
                :new.numce,
                :new.nomce,
                :new.dirce
            );

        END IF;

        SELECT
            COUNT(*)
        INTO dcount
        FROM
            tdepto
        WHERE
            numde = :new.numde;

        IF dcount = 0 THEN
            INSERT INTO tdepto (
                numce,
                numde,
                nomde,
                presu,
                direc,
                tidir,
                depde
            ) VALUES (
                :new.numce,
                :new.numde,
                :new.nomde,
                :new.presu,
                :new.direc,
                :new.tidir,
                :new.depde
            );

        END IF;

    ELSIF updating THEN
        UPDATE tcentr
        SET
            numce = :new.numce,
            nomce = :new.nomce,
            dirce = :new.dirce
        WHERE
            numce = :old.numce;

        UPDATE tdepto
        SET
            numce = :new.numce,
            numde = :new.numde,
            nomde = :new.nomde,
            presu = :new.presu,
            direc = :new.direc,
            tidir = :new.tidir,
            depde = :new.depde
        WHERE
            numde = :old.numde;

    ELSIF deleting THEN
        DELETE FROM tdepto
        WHERE
            numde = :old.numde;

    END IF;
END;
/

-- Ejemplo
INSERT INTO sede_departamentos VALUES (
    40,
    'SEDE',
    'C. ESPAÑA, BARCELONA',
    150,
    'MARKETING',
    60,
    180,
    'P',
    100
);

UPDATE sede_departamentos
SET
    presu = 80
WHERE
    numde = 100;

DELETE FROM sede_departamentos
WHERE
    numde = 140;