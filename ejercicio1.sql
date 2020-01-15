/*Creamos la tabla TIENDAS */
CREATE TABLE TIENDAS(
    NIF VARCHAR2(20),
    NOMBRE VARCHAR2(20),
    DIRECCION VARCHAR2(20),
    POBLACION VARCHAR2(20),
    PROVINCIA VARCHAR2(20),
    CODPOSTAL NUMBER(5)
);
/* Modificamos la tabla para establecer NIF como PK y no nulo
Establecemos que compruebe que provincia está en mayúsculas.
Establecemos nombre con una longitud variable de 30 caracteres y la restricción de no nulo
*/
ALTER TABLE TIENDAS MODIFY(

    NIF PRIMARY KEY NOT NULL,
    PROVINCIA CHECK (PROVINCIA = UPPER(PROVINCIA)),
    NOMBRE VARCHAR2(30) NOT NULL
    );
/* Se crea la tabla FABRICANTES */
CREATE TABLE FABRICANTES(

COD_FABRICANTE NUMBER(3),
NOMBRE VARCHAR2(15),
PAIS VARCHAR2(15)
)
/* Se modifica la tabla FABRICANTES para:
Establecer COD_FABRICANTE como clave primaria.
Comprobar que NOMBRE y PAIS está en mayúsculas.
*/
ALTER TABLE FABRICANTES MODIFY(
    COD_FABRICANTE PRIMARY KEY,
    NOMBRE CHECK (NOMBRE = UPPER(NOMBRE)),
    PAIS CHECK (PAIS = UPPER(PAIS))
);