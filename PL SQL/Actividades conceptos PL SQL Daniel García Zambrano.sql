-- Actividades conceptos PL/SQL

SET SERVEROUTPUT ON;

-- A. Funci�n

-- 1. Funci�n que devuelva el n�mero total de artistas que aparecen en una pel�cula (cuyo id de pel�cula se pasa como par�metro).
-- Control de errores, si la pel�cula no existe devolver� -1. 
CREATE OR REPLACE FUNCTION num_art_pel (
    pelicula NUMBER -- Id de la pelicula
) RETURN NUMBER AS
    artistas      NUMBER; -- N�mero de artistas retornado
    n_peliculas   NUMBER; -- N�mero de pel�culas con el id pasado por par�metro
BEGIN
    -- Comprobar si la pel�cula existe
    SELECT
        COUNT(*)
    INTO n_peliculas
    FROM
        peliculas
    WHERE
        pelicula_id = pelicula;
    
    -- Si no se han encontrado resultados, la pel�cula no existe

    IF n_peliculas = 0 THEN
        RETURN -1;
    END IF;
    
    -- Cada fila de pel_art con la misma pel�cula tiene un artista distinto. Contarlos para obtener el total.
    SELECT
        COUNT(*)
    INTO artistas
    FROM
        pel_art
    WHERE
        pelicula_id = pelicula;
    
    -- Devolver el recuento obtenido

    RETURN artistas;
END;
/

-- Utilizar la funci�n para ver el t�tulo de la pel�cula, el a�o y el n�mero total de actores que participan.
SELECT
    titulo,
    peli_anno AS a�o,
    num_art_pel(pelicula_id) AS actores
FROM
    peliculas;

-- 2. Funci�n que devuelve el n�mero total de pel�culas de un determinado director cuyo id se pasa como par�metro.
-- Si no existe el director devolver� 0.
CREATE OR REPLACE FUNCTION num_pel_dir (
    director NUMBER -- Id del director
) RETURN NUMBER AS
    n_peliculas NUMBER; -- Numero de peliculas a devolver
BEGIN
    -- Contar el n�mero de filas en PELICULAS que tienen como id_director el pasado por par�metro
    SELECT
        COUNT(*)
    INTO n_peliculas
    FROM
        peliculas
    WHERE
        director_id = director;
    
    -- Devolver el recuento obtenido. Si no existe el director, el recuento ser� 0, luego no son necesarios pasos adicionales
    RETURN n_peliculas;
END;
/

-- Utilizar la funci�n para mostrar la siguiente consulta: ver el nombre del director y el n�mero total de pel�culas que ha dirigido.
SELECT DISTINCT
    nombre,
    num_pel_dir(director_id) AS peliculas
FROM
    artistas,
    peliculas
WHERE
    artista_id = director_id;

-- 3. Funci�n que devuelve el n�mero de a�os transcurridos desde la grabaci�n de una pel�cula.
CREATE OR REPLACE FUNCTION antig_pel (
    pelicula NUMBER -- Id de la pelicula
) RETURN NUMBER AS
    antiguedad NUMBER; -- N�mero de a�os a devolver
BEGIN
    -- La base de datos solo guarda el a�o, de manera que no es posible obtener la cantidad de a�os con exactitud
    -- La mejor aproximaci�n que puede hacerse es restar el a�o de publicaci�n al actual
    SELECT
        EXTRACT(YEAR FROM sysdate) - peli_anno
    INTO antiguedad
    FROM
        peliculas
    WHERE
        pelicula_id = pelicula;
    
    -- Devolver la diferencia obtenida
    RETURN antiguedad;

-- Si la pel�cula no existe, devolver� -1
EXCEPTION
    WHEN no_data_found THEN
        RETURN -1;
END;
/

-- Utilizar la funci�n para mostrar la siguiente consulta: ver el t�tulo de la pel�cula, el a�o de grabaci�n, los a�os transcurridos
-- y el nombre del director.
SELECT
    titulo,
    peli_anno   AS a�o,
    antig_pel(pelicula_id) AS antig�edad,
    nombre      AS director
FROM
    peliculas   p
    JOIN artistas    a ON p.director_id = a.artista_id;

-- B. Procedimiento

-- 4. Realizar un procedimiento al que se le pasa un id del director de una pel�cula y muestre el t�tulo de cada pel�cula y los
-- nombres de los actores que han participado (ordenado por t�tulo y nombre del artista). Realizar control de errores necesario. 
-- Comprobar su funcionamiento.

-- Este procedimiento imprime los actores de una pel�cula pasada por par�metro
CREATE OR REPLACE PROCEDURE actores_pel (
    pelicula NUMBER -- Id de la pel�cula
) AS

    CURSOR actores IS -- Cursor que almacena los nombres de actores de la pel�cula pasada por par�metro
    SELECT
        nombre
    FROM
        artistas
    WHERE
        artista_id IN (
            SELECT
                artista_id
            FROM
                pel_art
            WHERE
                pelicula_id = pelicula
        );

BEGIN
    -- Iterar por cada actor en el cursor
    FOR actor IN actores LOOP
        -- Imprimir el nombre del actor actual
        dbms_output.put_line(actor.nombre);
    END LOOP;
    
-- Si la pel�cula no tiene actores o no existe
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('Ning�n actor en la base de datos.');
END;
/

-- Procedimiento principal
CREATE OR REPLACE PROCEDURE peliculas_dir (
    director NUMBER -- Id del director
) AS
    CURSOR pelis IS -- Cursor que almacena ids y nombres de pel�culas del director pasado por par�metro
    SELECT
        pelicula_id,
        titulo
    FROM
        peliculas
    WHERE
        director_id = director;

    n_pelis NUMBER; -- N�mero de pel�culas del director
BEGIN
    -- Contar n�mero de pel�culas del director
    SELECT
        COUNT(*)
    INTO n_pelis
    FROM
        peliculas
    WHERE
        director_id = director;
    
    -- Si existen

    IF n_pelis > 0 THEN
        -- Iterar por cada pel�cula en el cursor
        FOR pelicula IN pelis LOOP
            -- Imprimir el t�tulo de la pel�cula
            dbms_output.put_line(pelicula.titulo || ':');
            
            -- Llamada a procedimiento que imprime los actores de la pel�cula
            actores_pel(pelicula.pelicula_id);
            dbms_output.put_line('');
        END LOOP;

    ELSE -- Si el director no tiene pel�culas
        dbms_output.put_line('Ninguna pel�cula en la base de datos.');
    END IF;

END;
/

-- Ejemplo
EXEC peliculas_dir (&director);

-- 5. Crea un procedimiento que inserte una fila en PEL_ART. El procedimiento recibe como par�metros el id de la pel�cula y el id del artista.
-- Se controlar�n todos los errores posibles, enviando los correspondientes mensajes. Comprobar su funcionamiento.
CREATE OR REPLACE PROCEDURE insert_pel_art (
    pelicula   NUMBER, -- Id de la pel�cula
    artista    NUMBER -- Id del actor
) AS
BEGIN
    -- Se realiza la inserci�n
    INSERT INTO pel_art VALUES (
        pelicula,
        artista,
        0
    );

    dbms_output.put_line('Valor insertado correctamente.');
    
EXCEPTION
    WHEN dup_val_on_index THEN -- Si las id ya est�n en la tabla
        dbms_output.put_line('Error: Clave primaria repetida.');
        
    WHEN OTHERS THEN -- Si una o las dos id no existe en su tabla correspondiente
        dbms_output.put_line('Error: Clave for�nea no encontrada');
END;
/

-- Ejemplo
EXEC insert_pel_art(&pelicula, &artista);

-- 6. Realizar un procedimiento al que se le pasa un id de un estudio y muestre el nombre del estudio, t�tulo de cada pel�cula
-- y n�mero total de actores que han participado en la misma (ordenado por estudio y por t�tulo).
-- Realizar control de errores necesario. Comprobar su funcionamiento.
CREATE OR REPLACE PROCEDURE datos_estudio (
    estudio NUMBER -- Id del estudio
) AS

    nom       estudios.nombre%TYPE; -- Nombre del estudio
    
    CURSOR pelis IS -- Ids y t�tulos de las pel�culas del estudio
    SELECT
        pelicula_id,
        titulo
    FROM
        peliculas
    WHERE
        estudio_id = estudio
    ORDER BY
        estudio_id,
        2;

    actores   NUMBER; -- Variable que almacena el n�mero de actores de cada peli
BEGIN
    -- Obtener nombre del estudio
    SELECT
        nombre
    INTO nom
    FROM
        estudios
    WHERE
        estudio_id = estudio;
    
    -- Mostrar nombre del estudio

    dbms_output.put_line(nom);
    dbms_output.put_line('');
    
    -- Iterar por cada pel�cula
    FOR pelicula IN pelis LOOP
        -- Obtener el n�mero de actores
        SELECT
            COUNT(*)
        INTO actores
        FROM
            pel_art
        WHERE
            pelicula_id = pelicula.pelicula_id;
        -- Tambi�n puede usarse la funci�n num_art_pel del ejercicio 1
        
        -- Mostrar el t�tulo de la pel�cula junto al n�mero de actores
        dbms_output.put_line(pelicula.titulo
                             || ': '
                             || actores
                             || ' actores');
    END LOOP;

-- Si el estudio no existe
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('Estudio no encontrado.');
END;
/

-- Ejemplo
EXEC datos_estudio(&estudio);

-- C. Disparador

-- 7. Crea un disparador que impida introducir pel�culas cuyo a�o de realizaci�n sea superior al actual. Comprueba su funcionamiento.
CREATE OR REPLACE TRIGGER pelis_del_futuro BEFORE
    INSERT ON peliculas
    FOR EACH ROW
BEGIN
    -- Comprobar si el a�o es posterior al actual
    IF :new.peli_anno > extract(YEAR FROM sysdate) THEN
        -- Lanzar excepci�n para detener el insert
        raise_application_error(-20000, 'Error: A�o posterior al actual.');
    END IF;
END;
/

-- Ejemplo
INSERT INTO peliculas VALUES (
    99,
    'pelicula',
    9999,
    1,
    1,
    99
);

-- 8. Crear un disparador de modo que cada vez que se introduzca un nuevo estudio, calcule el n�mero del nuevo estudio sumando 5 unidades al �ltimo.
-- Ejemplo: Si el �ltimo n�mero de estudio es el 250, al nuevo estudio le corresponder� el n�mero 255. Comprobar su funcionamiento.
CREATE OR REPLACE TRIGGER num_estudio BEFORE
    INSERT ON estudios
    FOR EACH ROW
DECLARE
    ult_est NUMBER; -- �ltimo estudio
BEGIN
    -- Obtener �ltimo estudio
    SELECT
        MAX(estudio_id)
    INTO ult_est
    FROM
        estudios;
    
    -- Sumar 5 unidades
    ult_est := ult_est + 5;
    
    -- Sustituir n�mero de estudio
    :new.estudio_id := ult_est;

END;
/

-- Ejemplo
INSERT INTO estudios VALUES (
    4,
    'Estudio',
    'estudio@estudio.com',
    'C. Estudio 25'
);

-- 9. Crea un disparador que guarde en tabla AUDITORIA_ESTUDIO todos los cambios producidos en la tabla ESTUDIOS.
CREATE TABLE auditoria_estudio (
    numestudio   NUMBER(5),
    operacion    VARCHAR2(20),
    usuario      VARCHAR2(15),
    fecha        DATE
);
-- La columna OPERACI�N contiene el tipo de operaci�n (INSERCI�N, BORRADO, MODIFICACI�N). Comprueba su funcionamiento.
CREATE OR REPLACE TRIGGER guardar_cambios_estudios AFTER
    INSERT OR UPDATE OR DELETE ON estudios
    FOR EACH ROW
BEGIN
    -- Para INSERT
    IF inserting THEN
        INSERT INTO auditoria_estudio VALUES (
            :new.estudio_id, -- Solo se permite new
            'INSERT',
            user,
            sysdate
        );
    -- Para UPDATE
    ELSIF updating THEN
        INSERT INTO auditoria_estudio VALUES (
            :new.estudio_id, -- Guardar el id final, no el inicial
            'UPDATE',
            user,
            sysdate
        );
    -- Para DELETE
    ELSIF deleting THEN
        INSERT INTO auditoria_estudio VALUES (
            :old.estudio_id, -- New guardar�a NULL y no nos informar�a de nada
            'DELETE',
            user,
            sysdate
        );

    END IF;
END;
/

-- Ejemplos
INSERT INTO estudios VALUES (
    4,
    'Estudio',
    'estudio@estudio.com',
    'C. Estudio 25'
);

UPDATE estudios
SET
    nombre = 'GRAN ESTUDIO'
WHERE
    estudio_id = 3;
    
DELETE FROM estudios
WHERE
    estudio_id = 8;