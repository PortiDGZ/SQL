ALTER SESSION SET nls_date_format = 'DD-MM-YYYY';
--Borramos primero las tablas que tienen alguna clave referenciada en otra tabla 

DROP TABLE temple CASCADE CONSTRAINTS;

DROP TABLE tdepto CASCADE CONSTRAINTS;

DROP TABLE tcentr CASCADE CONSTRAINTS;

--Creamos primero las tablas que no tienen ninguna clave referenciada en otra tabla 

CREATE TABLE tcentr (
    numce   NUMBER(2),
    nomce   VARCHAR2(25),
    dirce   VARCHAR2(25),
    PRIMARY KEY ( numce )
);

CREATE TABLE tdepto (
    numde   NUMBER(3),
    numce   NUMBER(2),
    direc   NUMBER(3),
    tidir   VARCHAR2(1),
    presu   NUMBER(2),
    depde   NUMBER(3),
    nomde   VARCHAR2(20),
    PRIMARY KEY ( numde ),
    FOREIGN KEY ( numce )
        REFERENCES tcentr ( numce )
);

ALTER TABLE tdepto ADD CONSTRAINT fk2_depto FOREIGN KEY ( depde )
    REFERENCES tdepto;

CREATE TABLE temple (
    numem   NUMBER(3),
    numde   NUMBER(3),
    extel   NUMBER(3),
    fecna   DATE,
    fecin   DATE,
    salar   NUMBER(5),
    comis   NUMBER(3),
    numhi   NUMBER(1),
    nomem   VARCHAR2(20),
    PRIMARY KEY ( numem ),
    FOREIGN KEY ( numde )
        REFERENCES tdepto ( numde )
);

DELETE FROM tcentr;

INSERT INTO tcentr VALUES (
    10,
    'SEDE CENTRAL',
    'C. ALCALA, 820, MADRID'
);

INSERT INTO tcentr VALUES (
    20,
    'RELACIÓN CON CLIENTES',
    'C. ATOCHA, 405, 
MADRID'
);

DELETE FROM tdepto;

INSERT INTO tdepto VALUES (
    100,
    10,
    260,
    'P',
    72,
    NULL,
    'DIRECCIÓN GENERAL'
);

INSERT INTO tdepto VALUES (
    110,
    20,
    180,
    'P',
    90,
    100,
    'DIRECCIÓN COMERCIAL'
);

INSERT INTO tdepto VALUES (
    111,
    20,
    180,
    'F',
    66,
    110,
    'SECTOR INDUSTRIAL'
);

INSERT INTO tdepto VALUES (
    112,
    20,
    270,
    'P',
    54,
    110,
    'SECTOR SERVICIOS'
);

INSERT INTO tdepto VALUES (
    120,
    10,
    150,
    'F',
    18,
    100,
    'ORGANIZACIÓN'
);

INSERT INTO tdepto VALUES (
    121,
    10,
    150,
    'P',
    12,
    120,
    'PERSONAL'
);

INSERT INTO tdepto VALUES (
    122,
    10,
    350,
    'P',
    36,
    120,
    'PROCESO DE DATOS'
);

INSERT INTO tdepto VALUES (
    130,
    10,
    310,
    'P',
    12,
    100,
    'FINANZAS'
);

DELETE FROM temple;

INSERT INTO temple (
    numem,
    numde,
    extel,
    fecna,
    fecin,
    salar,
    comis,
    numhi,
    nomem
) VALUES (
    '110',
    '121',
    '350',
    TO_DATE('10/11/1970', 'DD/MM/YYYY'),
    TO_DATE('15/02/1985', 'DD/MM/YYYY'),
    '1800',
    NULL,
    '3',
    'PONS, CESAR'
);

INSERT INTO temple (
    numem,
    numde,
    extel,
    fecna,
    fecin,
    salar,
    comis,
    numhi,
    nomem
) VALUES (
    '120',
    '112',
    '340',
    TO_DATE('09/06/1968', 'DD/MM/YYYY'),
    TO_DATE('01/10/1988', 'DD/MM/YYYY'),
    '1900',
    '110',
    '1',
    'LASA, MARIO'
);

INSERT INTO temple (
    numem,
    numde,
    extel,
    fecna,
    fecin,
    salar,
    comis,
    numhi,
    nomem
) VALUES (
    '130',
    '112',
    '810',
    TO_DATE('09/09/1965', 'DD/MM/YYYY'),
    TO_DATE('01/02/1981', 'DD/MM/YYYY'),
    '1500',
    '110',
    '2',
    'TEROL, LUCIANO'
);

INSERT INTO temple (
    numem,
    numde,
    extel,
    fecna,
    fecin,
    salar,
    comis,
    numhi,
    nomem
) VALUES (
    '150',
    '121',
    '340',
    TO_DATE('10/08/1972', 'DD/MM/YYYY'),
    TO_DATE('15/01/1997', 'DD/MM/YYYY'),
    '2600',
    NULL,
    '0',
    'PEREZ, JULIO'
);

INSERT INTO temple (
    numem,
    numde,
    extel,
    fecna,
    fecin,
    salar,
    comis,
    numhi,
    nomem
) VALUES (
    '160',
    '111',
    '740',
    TO_DATE('09/07/1980', 'DD/MM/YYYY'),
    TO_DATE('11/11/2005', 'DD/MM/YYYY'),
    '1800',
    '110',
    '2',
    'AGUIRRE, AUREO'
);

INSERT INTO temple (
    numem,
    numde,
    extel,
    fecna,
    fecin,
    salar,
    comis,
    numhi,
    nomem
) VALUES (
    '180',
    '110',
    '508',
    TO_DATE('18/10/1974', 'DD/MM/YYYY'),
    TO_DATE('18/03/1996', 'DD/MM/YYYY'),
    '2800',
    '50',
    '2',
    'PEREZ, MARCOS'
);

INSERT INTO temple (
    numem,
    numde,
    extel,
    fecna,
    fecin,
    salar,
    comis,
    numhi,
    nomem
) VALUES (
    '190',
    '121',
    '350',
    TO_DATE('12/05/1972', 'DD/MM/YYYY'),
    TO_DATE('11/02/1992', 'DD/MM/YYYY'),
    '1750',
    NULL,
    '4',
    'VEIGA, JULIANA'
);

INSERT INTO temple (
    numem,
    numde,
    extel,
    fecna,
    fecin,
    salar,
    comis,
    numhi,
    nomem
) VALUES (
    '210',
    '100',
    '200',
    TO_DATE('28/09/1970', 'DD/MM/YYYY'),
    TO_DATE('22/01/1999', 'DD/MM/YYYY'),
    '1910',
    NULL,
    '2',
    'GALVEZ, PILAR'
);

INSERT INTO temple (
    numem,
    numde,
    extel,
    fecna,
    fecin,
    salar,
    comis,
    numhi,
    nomem
) VALUES (
    '240',
    '111',
    '760',
    TO_DATE('26/02/1967', 'DD/MM/YYYY'),
    TO_DATE('24/02/1989', 'DD/MM/YYYY'),
    '1700',
    '100',
    '3',
    'SANZ, LAVINIA'
);

INSERT INTO temple (
    numem,
    numde,
    extel,
    fecna,
    fecin,
    salar,
    comis,
    numhi,
    nomem
) VALUES (
    '250',
    '100',
    '250',
    TO_DATE('27/10/1976', 'DD/MM/YYYY'),
    TO_DATE('01/03/1997', 'DD/MM/YYYY'),
    '2700',
    NULL,
    '0',
    'ALBA, ADRIANA'
);

INSERT INTO temple (
    numem,
    numde,
    extel,
    fecna,
    fecin,
    salar,
    comis,
    numhi,
    nomem
) VALUES (
    '260',
    '100',
    '220',
    TO_DATE('03/12/1973', 'DD/MM/YYYY'),
    TO_DATE('12/07/2001', 'DD/MM/YYYY'),
    '720',
    NULL,
    '6',
    'LOPEZ, ANTONIO'
);

INSERT INTO temple (
    numem,
    numde,
    extel,
    fecna,
    fecin,
    salar,
    comis,
    numhi,
    nomem
) VALUES (
    '270',
    '112',
    '850',
    TO_DATE('21/05/1975', 'DD/MM/YYYY'),
    TO_DATE('10/09/2003', 'DD/MM/YYYY'),
    '1910',
    '80',
    '3',
    'GARCIA, OCTAVIO'
);

INSERT INTO temple (
    numem,
    numde,
    extel,
    fecna,
    fecin,
    salar,
    comis,
    numhi,
    nomem
) VALUES (
    '280',
    '130',
    '410',
    TO_DATE('11/01/1978', 'DD/MM/YYYY'),
    TO_DATE('08/10/2010', 'DD/MM/YYYY'),
    '1500',
    NULL,
    '5',
    'FLOR, DOROTEA'
);

INSERT INTO temple (
    numem,
    numde,
    extel,
    fecna,
    fecin,
    salar,
    comis,
    numhi,
    nomem
) VALUES (
    '285',
    '122',
    '620',
    TO_DATE('25/10/1979', 'DD/MM/YYYY'),
    TO_DATE('15/02/2011', 'DD/MM/YYYY'),
    '1910',
    NULL,
    '0',
    'POLO, OTILIA'
);

INSERT INTO temple (
    numem,
    numde,
    extel,
    fecna,
    fecin,
    salar,
    comis,
    numhi,
    nomem
) VALUES (
    '290',
    '120',
    '910',
    TO_DATE('30/11/1967', 'DD/MM/YYYY'),
    TO_DATE('14/02/1988', 'DD/MM/YYYY'),
    '1790',
    NULL,
    '3',
    'GIL, GLORIA'
);

INSERT INTO temple (
    numem,
    numde,
    extel,
    fecna,
    fecin,
    salar,
    comis,
    numhi,
    nomem
) VALUES (
    '310',
    '130',
    '480',
    TO_DATE('21/11/1976', 'DD/MM/YYYY'),
    TO_DATE('15/01/2001', 'DD/MM/YYYY'),
    '1950',
    NULL,
    '0',
    'GARCIA, AUGUSTO'
);

INSERT INTO temple (
    numem,
    numde,
    extel,
    fecna,
    fecin,
    salar,
    comis,
    numhi,
    nomem
) VALUES (
    '320',
    '122',
    '620',
    TO_DATE('25/12/1977', 'DD/MM/YYYY'),
    TO_DATE('05/02/2003', 'DD/MM/YYYY'),
    '2400',
    NULL,
    '2',
    'SANZ, CORNELIO'
);

INSERT INTO temple (
    numem,
    numde,
    extel,
    fecna,
    fecin,
    salar,
    comis,
    numhi,
    nomem
) VALUES (
    '330',
    '112',
    '850',
    TO_DATE('19/08/1958', 'DD/MM/YYYY'),
    TO_DATE('01/03/1980', 'DD/MM/YYYY'),
    '1700',
    '90',
    '0',
    'DIEZ, AMELIA'
);

INSERT INTO temple (
    numem,
    numde,
    extel,
    fecna,
    fecin,
    salar,
    comis,
    numhi,
    nomem
) VALUES (
    '350',
    '122',
    '610',
    TO_DATE('13/04/1979', 'DD/MM/YYYY'),
    TO_DATE('10/09/1999', 'DD/MM/YYYY'),
    '2700',
    NULL,
    '1',
    'CAMPS, AURELIO'
);

INSERT INTO temple (
    numem,
    numde,
    extel,
    fecna,
    fecin,
    salar,
    comis,
    numhi,
    nomem
) VALUES (
    '360',
    '111',
    '750',
    TO_DATE('29/10/1978', 'DD/MM/YYYY'),
    TO_DATE('10/10/1998', 'DD/MM/YYYY'),
    '1800',
    '100',
    '2',
    'LARA, DORINDA'
);

INSERT INTO temple (
    numem,
    numde,
    extel,
    fecna,
    fecin,
    salar,
    comis,
    numhi,
    nomem
) VALUES (
    '370',
    '121',
    '360',
    TO_DATE('22/06/1977', 'DD/MM/YYYY'),
    TO_DATE('20/01/2000', 'DD/MM/YYYY'),
    '1860',
    NULL,
    '1',
    'RUIZ, FABIOLA'
);

INSERT INTO temple (
    numem,
    numde,
    extel,
    fecna,
    fecin,
    salar,
    comis,
    numhi,
    nomem
) VALUES (
    '380',
    '112',
    '800',
    TO_DATE('30/03/1978', 'DD/MM/YYYY'),
    TO_DATE('01/01/1999', 'DD/MM/YYYY'),
    '1100',
    NULL,
    '0',
    'MARTIN, MICAELA'
);

INSERT INTO temple (
    numem,
    numde,
    extel,
    fecna,
    fecin,
    salar,
    comis,
    numhi,
    nomem
) VALUES (
    '390',
    '110',
    '500',
    TO_DATE('19/02/1976', 'DD/MM/YYYY'),
    TO_DATE('08/10/2010', 'DD/MM/YYYY'),
    '1290',
    NULL,
    '1',
    'MORAN, CARMEN'
);

INSERT INTO temple (
    numem,
    numde,
    extel,
    fecna,
    fecin,
    salar,
    comis,
    numhi,
    nomem
) VALUES (
    '400',
    '111',
    '780',
    TO_DATE('18/08/1979', 'DD/MM/YYYY'),
    TO_DATE('01/11/2011', 'DD/MM/YYYY'),
    '1150',
    NULL,
    '0',
    'LARA, LUCRECIA'
);

INSERT INTO temple (
    numem,
    numde,
    extel,
    fecna,
    fecin,
    salar,
    comis,
    numhi,
    nomem
) VALUES (
    '410',
    '122',
    '660',
    TO_DATE('14/07/1968', 'DD/MM/YYYY'),
    TO_DATE('13/10/1989', 'DD/MM/YYYY'),
    '1010',
    NULL,
    '0',
    'MUÑOZ, AZUCENA'
);

INSERT INTO temple (
    numem,
    numde,
    extel,
    fecna,
    fecin,
    salar,
    comis,
    numhi,
    nomem
) VALUES (
    '420',
    '130',
    '450',
    TO_DATE('22/10/1966', 'DD/MM/YYYY'),
    TO_DATE('19/11/1988', 'DD/MM/YYYY'),
    '2400',
    NULL,
    '0',
    'FIERRO, CLAUDIA'
);

INSERT INTO temple (
    numem,
    numde,
    extel,
    fecna,
    fecin,
    salar,
    comis,
    numhi,
    nomem
) VALUES (
    '430',
    '122',
    '650',
    TO_DATE('26/02/1967', 'DD/MM/YYYY'),
    TO_DATE('19/11/1988', 'DD/MM/YYYY'),
    '1260',
    NULL,
    '1',
    'MORA, VALERIANA'
);

INSERT INTO temple (
    numem,
    numde,
    extel,
    fecna,
    fecin,
    salar,
    comis,
    numhi,
    nomem
) VALUES (
    '440',
    '111',
    '760',
    TO_DATE('26/09/1966', 'DD/MM/YYYY'),
    TO_DATE('28/02/1986', 'DD/MM/YYYY'),
    '1260',
    '100',
    '0',
    'DURAN, LIVIA'
);

INSERT INTO temple (
    numem,
    numde,
    extel,
    fecna,
    fecin,
    salar,
    comis,
    numhi,
    nomem
) VALUES (
    '450',
    '112',
    '880',
    TO_DATE('21/10/1966', 'DD/MM/YYYY'),
    TO_DATE('28/02/1986', 'DD/MM/YYYY'),
    '1260',
    '100',
    '0',
    'PEREZ, SABINA'
);

INSERT INTO temple (
    numem,
    numde,
    extel,
    fecna,
    fecin,
    salar,
    comis,
    numhi,
    nomem
) VALUES (
    '480',
    '111',
    '760',
    TO_DATE('04/04/1965', 'DD/MM/YYYY'),
    TO_DATE('28/02/1986', 'DD/MM/YYYY'),
    '1260',
    '100',
    '1',
    'PINO, DIANA'
);

INSERT INTO temple (
    numem,
    numde,
    extel,
    fecna,
    fecin,
    salar,
    comis,
    numhi,
    nomem
) VALUES (
    '490',
    '112',
    '880',
    TO_DATE('06/06/1964', 'DD/MM/YYYY'),
    TO_DATE('01/01/1988', 'DD/MM/YYYY'),
    '1090',
    '100',
    '0',
    'TORRES, HORACIO'
);

INSERT INTO temple (
    numem,
    numde,
    extel,
    fecna,
    fecin,
    salar,
    comis,
    numhi,
    nomem
) VALUES (
    '500',
    '111',
    '750',
    TO_DATE('08/10/1965', 'DD/MM/YYYY'),
    TO_DATE('01/01/1987', 'DD/MM/YYYY'),
    '1200',
    '100',
    '0',
    'VAZQUEZ, HONORIA'
);

INSERT INTO temple (
    numem,
    numde,
    extel,
    fecna,
    fecin,
    salar,
    comis,
    numhi,
    nomem
) VALUES (
    '510',
    '110',
    '550',
    TO_DATE('04/05/1966', 'DD/MM/YYYY'),
    TO_DATE('01/11/1986', 'DD/MM/YYYY'),
    '1200',
    NULL,
    '1',
    'CAMPOS, ROMULO'
);

INSERT INTO temple (
    numem,
    numde,
    extel,
    fecna,
    fecin,
    salar,
    comis,
    numhi,
    nomem
) VALUES (
    '550',
    '111',
    '780',
    TO_DATE('10/01/1970', 'DD/MM/YYYY'),
    TO_DATE('21/01/1998', 'DD/MM/YYYY'),
    '600',
    '120',
    '0',
    'SANTOS, SANCHO'
);
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
    salar +(numhi-3)*(60) || ' €' AS "Salario Total" FROM temple WHERE numhi >= 4;

-- Práctica 3 Ejercicio 9--

SELECT
    nomem AS "NOMBRE",
    salar +(numhi-3)*(60) || ' €' AS "Salario Total" FROM temple WHERE numhi > (SELECT numhi FROM temple WHERE nomem = ';