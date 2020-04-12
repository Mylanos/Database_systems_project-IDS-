-- POŽADAVEK: dotaz s predikátem IN s vnořeným selectem
-- Nájdite elementy ktoré sú main elementom nejakého kúzla
-- Evidujte id elementu, nazov elementu, barvu_elementu
SELECT *
FROM "ELEMENT"
WHERE "ELEMENT"."idElement"
          IN (SELECT "SPELL"."mainElement"
              FROM "SPELL");