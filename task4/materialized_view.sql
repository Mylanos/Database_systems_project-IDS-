-- vytvořen alespoň jeden  ed patřící druhému členu týmu a používající tabulky definované prvním
-- členem týmu (nutno mít již definována přístupová práva), vč. SQL příkazů/dotazů ukazujících, jak materializovaný
-- pohled funguje,

DROP MATERIALIZED VIEW SPELLS_WITH_ELEMENTS_td;


CREATE  MATERIALIZED VIEW SPELLS_WITH_ELEMENTS_td
    CACHE
    BUILD IMMEDIATE
    ENABLE QUERY REWRITE
AS
 -- Ktoré kúzla má hlavný element farbu Indigo ? Vypiste názov kúzla a názov elementu
    Select spells."spellName" , elements."elementName" from
        ( Select * from SPELL ) spells
        inner join
        ( Select * From ELEMENT where "colorMagic" = 'Indigo' ) elements
    on spells."mainElement" = elements."idElement";


GRANT ALL ON SPELLS_WITH_ELEMENTS_td TO xosval03;