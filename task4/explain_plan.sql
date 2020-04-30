-- alespoň jedno použití EXPLAIN PLAN pro výpis plánu provedení databazového dotazu se spojením alespoň dvou tabulek,
-- agregační funkcí a klauzulí GROUP BY, přičemž v dokumentaci musí být srozumitelně popsáno, jak proběhne dle toho
-- výpisu plánu provedení dotazu, vč. objasnění použitých prostředků pro jeho urychlení (např. použití indexu, druhu
-- spojení, atp.), a dále musí být navrnut způsob, jak konkrétně by bylo možné dotaz dále urychlit (např. zavedením
-- nového indexu), navržený způsob proveden (např. vytvořen index), zopakován EXPLAIN PLAN a jeho výsledek porovnán s
-- výsledkem před provedením navrženého způsobu urychlení
--
-- explicitní vytvoření alespoň jednoho indexu tak, aby pomohl optimalizovat zpracování dotazů, přičemž musí být uveden
-- také příslušný dotaz, na který má index vliv, a v dokumentaci popsán způsob využití indexu v tomto dotazy (toto lze
-- zkombinovat s EXPLAIN PLAN, vizte dále),




EXPLAIN PLAN  FOR
SELECT "SPELL"."idSpell" id
    FROM "SPELL"
    WHERE "SPELL"."strength" > 50
    GROUP BY "SPELL"."idSpell";

SELECT PLAN_TABLE_OUTPUT  FROM TABLE(DBMS_XPLAN.DISPLAY());



CREATE INDEX INDEX_SPELL ON SPELL ("idSpell", "strength");



EXPLAIN PLAN  FOR
SELECT "SPELL"."idSpell" id
    FROM "SPELL"
    WHERE "SPELL"."strength" > 50
    GROUP BY "SPELL"."idSpell";

SELECT PLAN_TABLE_OUTPUT  FROM TABLE(DBMS_XPLAN.DISPLAY());
