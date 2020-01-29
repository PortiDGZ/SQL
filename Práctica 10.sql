DESCRIBE temple;

SELECT
    nomem,
    fecna
FROM
    temple
WHERE
    EXTRACT(MONTH FROM fecna) = 11;

SELECT
    nomem
FROM
    temple
WHERE
    EXTRACT(MONTH FROM fecna) = EXTRACT(MONTH FROM sysdate)
    AND ( EXTRACT(DAY FROM fecna) ) = EXTRACT(DAY FROM sysdate);

SELECT
    nomem,
    fecna
FROM
    temple
WHERE
    EXTRACT(YEAR FROM fecna) < 1950;

SELECT
    nomem,
    fecin
FROM
    temple
WHERE
    EXTRACT(YEAR FROM fecin) < 1970;

SELECT
    nomem,
    fecna,
    fecin
FROM
    temple
WHERE
    EXTRACT(YEAR FROM fecin) - EXTRACT(YEAR FROM fecna) < 30;