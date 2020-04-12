-- Požadavek: dotazy s klauzulí GROUP BY a agregační funkcí
-- Koľko kúziel majú jednotlivé elementy s farbou magie 'Violet'.
-- Evidujte id elementu, nazov elementu, barvu_elementu, počet kuziel
SELECT "ELEMENT"."idElement" el, "ELEMENT"."elementName", spell_main_elements.count num_of_spells
FROM "ELEMENT",
    (SELECT "SPELL"."mainElement" element, COUNT("SPELL"."mainElement") count
        FROM "SPELL"
        GROUP BY "SPELL"."mainElement") spell_main_elements ,
    (SELECT "ELEMENT"."idElement" element
        FROM "ELEMENT"
        WHERE "ELEMENT"."colorMagic"= 'Violet') violet_elements
WHERE spell_main_elements.element = "ELEMENT"."idElement" and violet_elements.element = "ELEMENT"."idElement";

-- Požadavek: dotazy s klauzulí GROUP BY a agregační funkcí
-- Koľko kuziel ma silu väčšiu ako 50
-- Evidujte počet kuziel splnujuce podmienku
SELECT COUNT(strong_spells.id) count
FROM (SELECT "SPELL"."idSpell" id
    FROM "SPELL"
    WHERE "SPELL"."strength" > 50
    GROUP BY "SPELL"."idSpell") strong_spells;