-- POŽADAVEK: spojení tří tabulek
-- Najdite element ktorý má pozitívny synergiu s nejakou magickou bytosťou a súčasne má
-- špecializáciu s typom "turpis"
-- Evidujte id elementu, nazov elementu, barvu_elementu, typ špecializacie, limit poz. synergie

SELECT "ELEMENT"."idElement", "ELEMENT"."elementName",  "ELEMENT"."colorMagic", "SPECIALIZATION"."type",
       "POSITIVE_SYNERGY"."limit"
FROM "ELEMENT"
JOIN "POSITIVE_SYNERGY"
    ON "POSITIVE_SYNERGY"."idElement" = "ELEMENT"."idElement"
    JOIN "ELEMENT_SPECIALIZATION"
        ON "ELEMENT_SPECIALIZATION"."idElement" = "POSITIVE_SYNERGY"."idElement"
            JOIN "SPECIALIZATION"
                ON "SPECIALIZATION"."idSpecialization" = "ELEMENT_SPECIALIZATION"."idSpecialization"
            WHERE "SPECIALIZATION"."type" = 'turpis';