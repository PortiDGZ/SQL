SELECT nomem, comis FROM temple WHERE numde LIKE 110 AND comis IS NOT NULL ORDER BY nomem;

SELECT nomde FROM tdepto WHERE nomde NOT LIKE 'DIRECCIÓN %' AND nomde NOT LIKE 'SECTOR %';

SELECT nomem, salar FROM temple WHERE (numhi = 0 AND salar > 1500) OR (numhi > 0 AND salar < 1000) ORDER BY nomem;

SELECT numem, (salar+comis) FROM temple WHERE comis IS NOT NULL AND salar+comis >= ALL (SELECT salar FROM temple);