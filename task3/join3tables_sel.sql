-- POŽADAVEK: spojení tří tabulek
-- Najdite element ktory má pozitívnej synergiu s nejakou magickou bytosťou a súčasne má
-- špecializáciu s typom "turpis"
-- Evidujte id elementu, nazov elementu, barvu_elementu, typ špecializacie, limit poz. synergie

SELECT "ELEMENT"."idElement", "ELEMENT"."elementName",  "ELEMENT"."colorMagic"
FROM "ELEMENT"
JOIN "POSITIVE_SYNERGY"
    ON "POSITIVE_SYNERGY"."idElement" = "ELEMENT"."idElement"
    JOIN "ELEMENT_SPECIALIZATION"
        ON "ELEMENT_SPECIALIZATION"."idElement" = "POSITIVE_SYNERGY"."idElement"
            JOIN "SPECIALIZATION" ON "SPECIALIZATION"."idSpecialization" = "ELEMENT_SPECIALIZATION"."idSpecialization"
            WHERE "SPECIALIZATION"."type" = 'turpis';