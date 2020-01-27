SELECT
    nomem
FROM
    temple
WHERE
    extel IN (
        250,
        750
    )
ORDER BY
    nomem;

SELECT
    nomem
FROM
    temple
WHERE
    numde IN (
        SELECT
            numde
        FROM
            temple
        WHERE
            nomem LIKE '%, PILAR'
            OR nomem LIKE '%, DOROTEA'
    )
ORDER BY
    nomem;

SELECT
    nomde, direc
FROM
    tdepto
WHERE
    direc IN (
        SELECT
            direc
        FROM
            tdepto
        WHERE
            nomde LIKE '% COMERCIAL'
            OR nomde LIKE 'PERSONAL'
    )ORDER BY nomde;