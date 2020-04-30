-- vytvoření alespoň dvou netriviálních databázových triggerů vč. jejich předvedení, z toho právě jeden trigger pro
-- automatické generování hotnot primárního klíče nějaké tabulky ze sekvence (např. pokud bude při vkládání záznamů
-- do dané tabulky hodnota primárního klíče nedefinována, tj. NULL),



CREATE OR REPLACE TRIGGER GRIMOIRE_TRIGGER BEFORE
INSERT ON GRIMOIRE
FOR EACH ROW
WHEN ( NEW."idElement" IS NULL  )
BEGIN
   :NEW."idElement" := 'elem01918';
END;



INSERT INTO GRIMOIRE (ID_GRIMOAR,"Name_of_grimoire","State_of_charged_magic")
VALUES ( SYS_GUID(),'hello world' ,1);