DROP TABLE "CHARGING_PLACE" CASCADE CONSTRAINTS;
DROP TABLE "SECONDARY_ELEMENTS" CASCADE CONSTRAINTS;
DROP TABLE "SPELL" CASCADE CONSTRAINTS;
DROP TABLE "ELEMENT_SPECIALIZATION" CASCADE CONSTRAINTS;
DROP TABLE "SPECIALIZATION" CASCADE CONSTRAINTS;
DROP TABLE "CURSED_BEING" CASCADE CONSTRAINTS ;
DROP TABLE "POSITIVE_SYNERGY" CASCADE CONSTRAINTS;
---
DROP TABLE "SCROLL" CASCADE CONSTRAINTS;
DROP TABLE "MAGICAL_BEING" CASCADE CONSTRAINTS;
DROP TABLE "MAGICAL_BEING_CAN_HAVE" CASCADE CONSTRAINTS;
DROP TABLE "MAGICAL_BEING_HAD" CASCADE CONSTRAINTS ;
DROP TABLE "GRIMOIRE" CASCADE CONSTRAINTS;
DROP TABLE "GRIMOIRE_CONTAINS_SPELLS" CASCADE CONSTRAINTS ;
DROP TABLE "ELEMENT" CASCADE CONSTRAINTS;


--Predstavuje tabuľku element
CREATE TABLE "ELEMENT"
(
    "idElement" CHARACTER VARYING(100)
        CONSTRAINT "element_idElement_PK" PRIMARY KEY,
    "elementName" CHARACTER VARYING(100)
        CONSTRAINT "elementName_NN" NOT NULL,
    "colorMagic" CHARACTER VARYING(100)
        CONSTRAINT "colorMagic_NN" NOT NULL
);

--Predstavuje tabuľku kúzlo s tým že stĺpec "mainElement" predstavuje vzťah "Má hlavný" medzi Elementom a kúzlom kde sa ukladá hlavný element kúzla (Nenullový)
CREATE TABLE "SPELL"
(
    "idSpell" CHARACTER VARYING(100)
        CONSTRAINT "spell_idSpell_PK" PRIMARY KEY,
    "spellName" CHARACTER VARYING(100),
    "difficultyOfCasting" CHARACTER VARYING(100) CHECK ( "difficultyOfCasting" = 'HARD' OR
                                                         "difficultyOfCasting" = 'MEDIUM' OR
                                                         "difficultyOfCasting" = 'EASY'),
    "type" CHARACTER VARYING(100)
        CONSTRAINT "spell_type_NN" NOT NULL,
    "strength" INTEGER DEFAULT 0 CHECK ( "strength" >= 0 AND "strength" <= 100),
    "mainElement" CHARACTER VARYING(100)
        CONSTRAINT "spell_idElement_NN" NOT NULL,

    CONSTRAINT "spell_idElement_FK" FOREIGN KEY("mainElement") REFERENCES ELEMENT ("idElement") ON DELETE CASCADE -- Ma hlavny
);

-- Tabuľka predstavuje vzťah "Môže mať vedlajší" medzi Elementom a kúzlom. Vytvorili sme ju ako novú tabuľku pretože to je vzťah many to many.
CREATE TABLE "SECONDARY_ELEMENTS"
(
    "idSpell" CHARACTER VARYING(100),
    "idElement" CHARACTER VARYING(100),

    CONSTRAINT "secondaryElements_idSpell_idElement_PK" PRIMARY KEY("idSpell", "idElement"),
    CONSTRAINT "secondaryElements_idSpell_FK" FOREIGN KEY("idSpell") REFERENCES "SPELL"("idSpell") ON DELETE CASCADE,
    CONSTRAINT "secondaryElements_idElement_FK" FOREIGN KEY("idElement") REFERENCES "ELEMENT"("idElement") ON DELETE CASCADE
);

--Tabuľka predstavujúca entitnú množinu "Specializace"
CREATE TABLE "SPECIALIZATION"
(
    "idSpecialization" CHARACTER VARYING(100)
        CONSTRAINT "specializ_idSpecialization_PK" PRIMARY KEY,
    "type" CHARACTER VARYING(100) NOT NULL
);

-- Predstavuje vzťah "Element moze mat viac", znova vzťah many to many s tým že jednotlivé stĺpce nemôžu byť NULL.
CREATE TABLE "ELEMENT_SPECIALIZATION"
(
    "idSpecialization" CHARACTER VARYING(100) NOT NULL,
    "idElement" CHARACTER VARYING(100) NOT NULL,

    CONSTRAINT "elemSpecializ_idSpecialization_idElement_PK" PRIMARY KEY("idSpecialization", "idElement"),
    CONSTRAINT "elemSpecializ_idSpecialization_FK" FOREIGN KEY("idSpecialization") REFERENCES "SPECIALIZATION"("idSpecialization") ON DELETE CASCADE,
    CONSTRAINT "elemSpecializ_idElement_FK" FOREIGN KEY("idElement") REFERENCES "ELEMENT"("idElement") ON DELETE CASCADE
);

-- Predstavuje entitnú množinu "Dobíjecí místo" a zároveň vzťah "Prosakuje", je to vzťah 0/1 to many teda postačí ak ho modelujeme ako nový stĺpec v
-- entitnej množine "Dobíjecí místo", ktoré môže byť aj NULL
CREATE TABLE "CHARGING_PLACE"
(
    "idPlace" CHARACTER VARYING(100)
        CONSTRAINT "charging_idPlace_PK" PRIMARY KEY,
    "xCoordinate" INTEGER DEFAULT 0,
    "yCoordinate" INTEGER DEFAULT 0,
    "rateOfSeekage" DECIMAL(3,2) DEFAULT 0,
    "idElement" CHARACTER VARYING(100),

    CONSTRAINT "charging_idElement_FK" FOREIGN KEY("idElement") REFERENCES ELEMENT ("idElement") ON DELETE CASCADE -- Prosakuje
);


Create Table "GRIMOIRE"(
        "ID_GRIMOAR" CHARACTER VARYING(100) CONSTRAINT "ID_Grimoar_PK" PRIMARY KEY,
        "State_of_charged_magic" integer  constraint "State_of_charged_magic_NN" NOT NULL,
        "Name_of_grimoire" CHARACTER VARYING(100) CONSTRAINT "Name_of_grimoire_NN" NOT NULL,
        "idElement" CHARACTER VARYING(100) NOT NULL ,
         CONSTRAINT "idElement_FK " FOREIGN KEY ( "idElement")  REFERENCES "ELEMENT" ("idElement")  ON DELETE CASCADE
    );
-- Vytvorit id rodne cislo
Create Table "MAGICAL_BEING"(
        "ID_MAGICAL_BEING" CHARACTER VARYING(200) CONSTRAINT "ID_Magical_Being_PK" PRIMARY KEY,
        "Story"CHARACTER VARYING(200)  constraint "MAGICAL_BEING_Story_NN" NOT NULL,
        "Name" CHARACTER VARYING(200) CONSTRAINT "MAGICAL_BEING_Name_NN" NOT NULL,
        "Type" CHARACTER VARYING(100) CONSTRAINT "MAGICAL_BEING_Type_NN" CHECK ( "Type"='ELF' OR "Type"='MAGICIAN'),
        "Mana size" integer CHECK ("Mana size">= 0)  ,
        "Level" integer CHECK ( "Level" >= 0) ,
        "Age" integer CHECK ("Age">=0),
        "Ability of magic" integer CHECK ("Ability of magic" >= 0)



);

-- Moze mat vedlajsi
CREATE TABLE "MAGICAL_BEING_CAN_HAVE"
(
    "ID_MAGICAL_BEING" CHARACTER VARYING(100),
    "ID_GRIMOAR" CHARACTER VARYING(100),

    CONSTRAINT "MAGICAL_BEING_CAN_HAVE_ID_MAGICAL_BEING_ID_GRIMOAR_PK" PRIMARY KEY("ID_MAGICAL_BEING", "ID_GRIMOAR"),
    CONSTRAINT "MAGICAL_BEING_CAN_HAVE_ID_MAGICAL_BEING_FK" FOREIGN KEY("ID_MAGICAL_BEING") REFERENCES "MAGICAL_BEING" ("ID_MAGICAL_BEING") ON DELETE CASCADE,
    CONSTRAINT "MAGICAL_BEING_CAN_HAVE_ID_GRIMOAR_FK" FOREIGN KEY("ID_GRIMOAR") REFERENCES "GRIMOIRE"("ID_GRIMOAR") ON DELETE CASCADE
);

CREATE TABLE "MAGICAL_BEING_HAD"
(
    "ID_MAGICAL_BEING" CHARACTER VARYING(100),
    "ID_GRIMOAR" CHARACTER VARYING(100),

    CONSTRAINT "MAGICAL_BEING_HAD_ID_MAGICAL_BEING_ID_GRIMOAR_PK" PRIMARY KEY("ID_MAGICAL_BEING", "ID_GRIMOAR"),
    CONSTRAINT "MAGICAL_BEING_HAD_ID_MAGICAL_BEING_FK" FOREIGN KEY("ID_MAGICAL_BEING") REFERENCES "MAGICAL_BEING" ("ID_MAGICAL_BEING") ON DELETE CASCADE,
    CONSTRAINT "MAGICAL_BEING_HAD_ID_GRIMOAR_FK" FOREIGN KEY("ID_GRIMOAR") REFERENCES "GRIMOIRE"("ID_GRIMOAR") ON DELETE CASCADE
);




-- Vytvorit id isbn





-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------

Create Table "SCROLL" (
    "ID_SCROLL" INTEGER CONSTRAINT "ID_SCROLL_PK" PRIMARY KEY,
    "Name" CHARACTER VARYING(100) CONSTRAINT "SCROLL_Name_NN" NOT NULL,
    "USED" integer CONSTRAINT "SCROLL_USED_NN"  CHECK ( "USED" = 1 OR "USED" = 0),
    "ID_MAGICAL_BEING" CHARACTER VARYING(100) NOT NULL ,
    "idSpell" CHARACTER VARYING(100) NOT NULL  ,

    CONSTRAINT "ID_MAGICAL_BEING_FK" FOREIGN KEY("ID_MAGICAL_BEING") REFERENCES "MAGICAL_BEING"("ID_MAGICAL_BEING") ON DELETE CASCADE,
    CONSTRAINT "idSpell_FK" FOREIGN KEY("idSpell") REFERENCES "SPELL"("idSpell") ON DELETE CASCADE


);



CREATE TABLE "GRIMOIRE_CONTAINS_SPELLS"(
"ID_GRIMOAR" CHARACTER VARYING(100) CONSTRAINT "ID_GRIMOIRE_CONTAINS_SPELLS_ID" PRIMARY KEY REFERENCES "GRIMOIRE"("ID_GRIMOAR") ON DELETE CASCADE,

"1_idSpell" CHARACTER VARYING(100) NOT NULL  ,
"2_idSpell" CHARACTER VARYING(100) NOT NULL  ,
"3_idSpell" CHARACTER VARYING(100) NOT NULL  ,
"4_idSpell" CHARACTER VARYING(100) NOT NULL  ,
"5_idSpell" CHARACTER VARYING(100) NOT NULL  ,
"6_idSpell" CHARACTER VARYING(100) NOT NULL  ,
"7_idSpell" CHARACTER VARYING(100) NOT NULL  ,
"8_idSpell" CHARACTER VARYING(100) NOT NULL  ,
"9_idSpell" CHARACTER VARYING(100) NOT NULL  ,
"10_idSpell" CHARACTER VARYING(100) NOT NULL ,
"11_idSpell" CHARACTER VARYING(100) ,
"12_idSpell" CHARACTER VARYING(100) ,
"13_idSpell" CHARACTER VARYING(100) ,
"14_idSpell" CHARACTER VARYING(100) ,
"15_idSpell" CHARACTER VARYING(100) ,


CONSTRAINT "1_idSpell_FK" FOREIGN KEY ("1_idSpell") REFERENCES "SPELL" ("idSpell") ON DELETE CASCADE,
CONSTRAINT "2_idSpell_FK" FOREIGN KEY ("2_idSpell") REFERENCES "SPELL" ("idSpell") ON DELETE CASCADE,
CONSTRAINT "3_idSpell_FK" FOREIGN KEY ("3_idSpell") REFERENCES "SPELL" ("idSpell") ON DELETE CASCADE,
CONSTRAINT "4_idSpell_FK" FOREIGN KEY ("4_idSpell") REFERENCES "SPELL" ("idSpell") ON DELETE CASCADE,
CONSTRAINT "5_idSpell_FK" FOREIGN KEY ("5_idSpell") REFERENCES "SPELL" ("idSpell") ON DELETE CASCADE,
CONSTRAINT "6_idSpell_FK" FOREIGN KEY ("6_idSpell") REFERENCES "SPELL" ("idSpell") ON DELETE CASCADE,
CONSTRAINT "7_idSpell_FK" FOREIGN KEY ("7_idSpell") REFERENCES "SPELL" ("idSpell") ON DELETE CASCADE,
CONSTRAINT "8_idSpell_FK" FOREIGN KEY ("8_idSpell") REFERENCES "SPELL" ("idSpell") ON DELETE CASCADE,
CONSTRAINT "9_idSpell_FK" FOREIGN KEY ("9_idSpell") REFERENCES "SPELL" ("idSpell") ON DELETE CASCADE,
CONSTRAINT "10_idSpell_FK" FOREIGN KEY ("10_idSpell") REFERENCES "SPELL" ("idSpell") ON DELETE CASCADE,
CONSTRAINT "11_idSpell_FK" FOREIGN KEY ("11_idSpell") REFERENCES "SPELL" ("idSpell") ON DELETE CASCADE,
CONSTRAINT "12_idSpell_FK" FOREIGN KEY ("12_idSpell") REFERENCES "SPELL" ("idSpell") ON DELETE CASCADE,
CONSTRAINT "13_idSpell_FK" FOREIGN KEY ("13_idSpell") REFERENCES "SPELL" ("idSpell") ON DELETE CASCADE,
CONSTRAINT "14_idSpell_FK" FOREIGN KEY ("14_idSpell") REFERENCES "SPELL" ("idSpell") ON DELETE CASCADE,
CONSTRAINT "15_idSpell_FK" FOREIGN KEY ("15_idSpell") REFERENCES "SPELL" ("idSpell") ON DELETE CASCADE

);

-- Predstavuje entitnú množinu "Kliatba", ktorá dedí z "Kouzla" a zároveň predstavuje vzťah many to many "bola zoslana na"
-- medzi entitami kliatba a magicka bytost
CREATE TABLE "CURSED_BEING"(
        "duration" INTEGER DEFAULT 0 CHECK ( "duration" >= 0 ),
        "ID_MAGICAL_BEING" CHARACTER VARYING(100),
        "idSpell" CHARACTER VARYING(100),

        CONSTRAINT "CURSED_BEING_ID_MAGICAL_BEING_ID_GRIMOAR_PK" PRIMARY KEY("ID_MAGICAL_BEING", "idSpell"),
        CONSTRAINT "CURSED_BEING_ID_MAGICAL_BEING_FK" FOREIGN KEY("ID_MAGICAL_BEING") REFERENCES "MAGICAL_BEING" ("ID_MAGICAL_BEING") ON DELETE CASCADE,
        CONSTRAINT "CURSED_BEING_ID_SPELL_FK" FOREIGN KEY("idSpell") REFERENCES "SPELL"("idSpell") ON DELETE CASCADE
);

-- Predstavuje many to many vzťah "Pozitívna synergia", navrhujeme znova ako vlastnú tabuľku kde zároveň ukladáme pre každý záznam limit.
-- nie každá magická bytosť môže mať pozitivnu synergiu ale keď už má element nemôže byť nula(Preto idElement je NOT NULL)
CREATE TABLE POSITIVE_SYNERGY(
        "limit" INTEGER DEFAULT 0 CHECK ( "limit" >= 0 ),
        "ID_MAGICAL_BEING" CHARACTER VARYING(100),
        "idElement" CHARACTER VARYING(100) NOT NULL,

        CONSTRAINT "POSITIVE_SYNERGY_ID_MAGICAL_BEING_ID_GRIMOAR_PK" PRIMARY KEY("ID_MAGICAL_BEING", "idElement"),
        CONSTRAINT "POSITIVE_SYNERGY_ID_MAGICAL_BEING_FK" FOREIGN KEY("ID_MAGICAL_BEING") REFERENCES "MAGICAL_BEING" ("ID_MAGICAL_BEING") ON DELETE CASCADE,
        CONSTRAINT "POSITIVE_SYNERGY_ID_SPELL_FK" FOREIGN KEY("idElement") REFERENCES "ELEMENT"("idElement") ON DELETE CASCADE
);

----------------------------------DEMO DATA----------------------------------

insert into ELEMENT ("idElement", "elementName", "colorMagic") values ('elem45703', 'nulla', 'Goldenrod');
insert into ELEMENT ("idElement", "elementName", "colorMagic") values ('elem70284', 'sagittis', 'Violet');
insert into ELEMENT ("idElement", "elementName", "colorMagic") values ('elem55873', 'dis', 'Pink');
insert into ELEMENT ("idElement", "elementName", "colorMagic") values ('elem01918', 'in', 'Maroon');
insert into ELEMENT ("idElement", "elementName", "colorMagic") values ('elem11780', 'ac', 'Mauv');
insert into ELEMENT ("idElement", "elementName", "colorMagic") values ('elem68667', 'feugiat', 'Indigo');
insert into ELEMENT ("idElement", "elementName", "colorMagic") values ('elem66085', 'luctus', 'Fuscia');
insert into ELEMENT ("idElement", "elementName", "colorMagic") values ('elem06711', 'lorem', 'Puce');
insert into ELEMENT ("idElement", "elementName", "colorMagic") values ('elem35673', 'semper', 'Maroon');
insert into ELEMENT ("idElement", "elementName", "colorMagic") values ('elem88714', 'leo', 'Violet');


insert into SPELL ("idSpell", "spellName", "difficultyOfCasting", "type", "strength", "mainElement") values ('spell25274', 'quam'      , 'HARD', 'HEX'     , 18,  'elem88714');
insert into SPELL ("idSpell", "spellName", "difficultyOfCasting", "type", "strength", "mainElement") values ('spell44205', 'donec'     , 'MEDIUM', 'CURSE'   , 29,'elem88714');
insert into SPELL ("idSpell", "spellName", "difficultyOfCasting", "type", "strength", "mainElement") values ('spell63377', 'amet'      , 'HARD', 'STUN'    , 55,  'elem55873');
insert into SPELL ("idSpell", "spellName", "difficultyOfCasting", "type", "strength", "mainElement") values ('spell79943', 'nec'       , 'EASY', 'CURSE'   , 97,  'elem68667');
insert into SPELL ("idSpell", "spellName", "difficultyOfCasting", "type", "strength", "mainElement") values ('spell64124', 'iaculis'   , 'MEDIUM', 'FIREBALL', 81,'elem01918');
insert into SPELL ("idSpell", "spellName", "difficultyOfCasting", "type", "strength", "mainElement") values ('spell74840', 'imperdiet' , 'HARD', 'CURSE'   , 31,  'elem06711');
insert into SPELL ("idSpell", "spellName", "difficultyOfCasting", "type", "strength", "mainElement") values ('spell15592', 'sit'       , 'EASY', 'STUN'    , 74,  'elem68667');
insert into SPELL ("idSpell", "spellName", "difficultyOfCasting", "type", "strength", "mainElement") values ('spell78728', 'pharetra'  , 'HARD', 'HEX'      , 94, 'elem01918');
insert into SPELL ("idSpell", "spellName", "difficultyOfCasting", "type", "strength", "mainElement") values ('spell75992', 'orci'      , 'EASY', 'STUN'    , 100, 'elem88714');
insert into SPELL ("idSpell", "spellName", "difficultyOfCasting", "type", "strength", "mainElement") values ('spell40001', 'vel'       , 'MEDIUM', 'CURSE'   , 51,'elem68667');

insert into SECONDARY_ELEMENTS  ("idSpell", "idElement") values ('spell15592', 'elem06711');
insert into SECONDARY_ELEMENTS  ("idSpell", "idElement") values ('spell74840', 'elem68667');
insert into SECONDARY_ELEMENTS  ("idSpell", "idElement") values ('spell79943', 'elem88714');
insert into SECONDARY_ELEMENTS  ("idSpell", "idElement") values ('spell79943', 'elem68667');

insert into SPECIALIZATION ("idSpecialization", "type") values ('spec03658', 'integer');
insert into SPECIALIZATION ("idSpecialization", "type") values ('spec99567', 'ligula');
insert into SPECIALIZATION ("idSpecialization", "type") values ('spec93292', 'turpis');
insert into SPECIALIZATION ("idSpecialization", "type") values ('spec33775', 'suspendisse');
insert into SPECIALIZATION ("idSpecialization", "type") values ('spec85181', 'turpis');

insert into ELEMENT_SPECIALIZATION  ("idSpecialization", "idElement") values ('spec85181', 'elem68667');
insert into ELEMENT_SPECIALIZATION  ("idSpecialization", "idElement") values ('spec93292', 'elem88714');
insert into ELEMENT_SPECIALIZATION  ("idSpecialization", "idElement") values ('spec99567', 'elem55873');
insert into ELEMENT_SPECIALIZATION  ("idSpecialization", "idElement") values ('spec85181', 'elem06711');

insert into CHARGING_PLACE ("idPlace", "xCoordinate", "yCoordinate", "rateOfSeekage", "idElement") values ('place78969', 774, 994, 0.46, 'elem35673');
insert into CHARGING_PLACE ("idPlace", "xCoordinate", "yCoordinate", "rateOfSeekage", "idElement") values ('place91879', 509, 160, 0.25, 'elem70284');
insert into CHARGING_PLACE ("idPlace", "xCoordinate", "yCoordinate", "rateOfSeekage", "idElement") values ('place36930', 223, 437, 0.79, 'elem11780');
insert into CHARGING_PLACE ("idPlace", "xCoordinate", "yCoordinate", "rateOfSeekage", "idElement") values ('place09959', 825, 261, 0.96, 'elem66085');
insert into CHARGING_PLACE ("idPlace", "xCoordinate", "yCoordinate", "rateOfSeekage", "idElement") values ('place60126', 3, 25, 0.64, 'elem11780');

insert into MAGICAL_BEING ("ID_MAGICAL_BEING" , "Story" , "Name" , "Type" , "Age" , "Ability of magic" ) values ('bd41658c-15d4-4a6f-bd8c-330cdfcde63d', 'Whether we like it or not, our arrival has altered the landscape. —Malcolm, navigator of the Belligerent', 'Octinoxate and Oxybenzone', 'ELF', '959', '9821');
insert into MAGICAL_BEING ("ID_MAGICAL_BEING" , "Story" , "Name" , "Type", "Mana size", "Level") values ('78b2c328-f6d2-434b-a44b-637ae95e4684', 'I can tell you what you wish to know. But first, there is the matter of my fee', 'Malathion', 'MAGICIAN', '06968', '0588');
insert into MAGICAL_BEING ("ID_MAGICAL_BEING" , "Story" , "Name" , "Type",  "Age" , "Ability of magic" ) values ('5a88d488-9211-4bac-b129-f1a030d084a3', 'Beware the generosity of demons', 'ALUMINUM CHLOROHYDRATE', 'ELF', '7', '87');
insert into MAGICAL_BEING ("ID_MAGICAL_BEING" , "Story" , "Name" , "Type",  "Age" , "Ability of magic" ) values ('340ea254-09af-4afb-852c-6da0b1fe4af5', 'Potions! Mana potions, health potions, energy potions—get your potions here!', 'Triclosan', 'ELF', '9', '2684');
insert into MAGICAL_BEING ("ID_MAGICAL_BEING" , "Story" , "Name" , "Type", "Mana size", "Level") values ('e3f92c06-0f66-43d7-9f5d-0d7d324f2266', 'They danced like puppets to a tune only Yawgmoth could hear.', 'OCTINOXlATE, OCTISALATE, OXYBENZONE, TITANIUM DIOXIDE', 'MAGICIAN', '70227', '634');
insert into MAGICAL_BEING ("ID_MAGICAL_BEING" , "Story" , "Name" , "Type", "Mana size", "Level") values ('c13827fa-2ec2-40d9-8e60-a26eab1a6d32', 'Surely it won’t notice if I take Theria the Sly, last words', 'Lithium', 'MAGICIAN', '97', '13');
insert into MAGICAL_BEING ("ID_MAGICAL_BEING" , "Story" , "Name" , "Type",  "Age" , "Ability of magic" ) values ('3b91c534-5a83-47b1-9c40-61bf3450218a', '﻿By the time their enemies noticed the sea’s changing mood, the Vodalians had often shifted formation and were ready to attack.', 'EPINEPHRINE', 'ELF', '2', '49');
insert into MAGICAL_BEING ("ID_MAGICAL_BEING" , "Story" , "Name" , "Type", "Mana size", "Level" ) values ('bab2f53b-2339-445d-b28b-5bff72b109ef', 'The earth cannot hold that which magic commands.', 'losartan potassium', 'MAGICIAN', '0', '7');

insert into GRIMOIRE ("ID_GRIMOAR", "State_of_charged_magic", "Name_of_grimoire","idElement") values ('8d14e285-a7e6-4c4d-8ab4-5528c7ba6e61', '2800', 'Intéressant','elem45703');
insert into GRIMOIRE ("ID_GRIMOAR", "State_of_charged_magic", "Name_of_grimoire","idElement") values ('7f2d4f24-15f2-4cc8-8bfe-4cbe85780a86', '9391', 'Stévina','elem70284');
insert into GRIMOIRE ("ID_GRIMOAR", "State_of_charged_magic", "Name_of_grimoire","idElement") values ('d715a9f6-180d-41a0-8f4b-eae109ddaf36', '9436', 'Tán','elem55873');
insert into GRIMOIRE ("ID_GRIMOAR", "State_of_charged_magic", "Name_of_grimoire","idElement") values ('2c2d59b3-56cb-4c9a-be9d-c36ce6c409ea', '257', 'Kévina','elem01918');

INSERT  Into GRIMOIRE_CONTAINS_SPELLS("ID_GRIMOAR","1_idSpell","2_idSpell","3_idSpell","4_idSpell","5_idSpell","6_idSpell","7_idSpell","8_idSpell","9_idSpell","10_idSpell") values ('8d14e285-a7e6-4c4d-8ab4-5528c7ba6e61','spell25274','spell44205','spell63377','spell79943','spell64124','spell74840','spell15592','spell78728','spell75992','spell40001');
INSERT  Into GRIMOIRE_CONTAINS_SPELLS("ID_GRIMOAR","1_idSpell","2_idSpell","3_idSpell","4_idSpell","5_idSpell","6_idSpell","7_idSpell","8_idSpell","9_idSpell","10_idSpell") values ('7f2d4f24-15f2-4cc8-8bfe-4cbe85780a86','spell25274','spell44205','spell63377','spell79943','spell64124','spell74840','spell15592','spell78728','spell75992','spell40001');
INSERT  Into GRIMOIRE_CONTAINS_SPELLS("ID_GRIMOAR","1_idSpell","2_idSpell","3_idSpell","4_idSpell","5_idSpell","6_idSpell","7_idSpell","8_idSpell","9_idSpell","10_idSpell") values ('d715a9f6-180d-41a0-8f4b-eae109ddaf36','spell25274','spell44205','spell63377','spell79943','spell64124','spell74840','spell15592','spell78728','spell75992','spell40001');
INSERT  Into GRIMOIRE_CONTAINS_SPELLS("ID_GRIMOAR","1_idSpell","2_idSpell","3_idSpell","4_idSpell","5_idSpell","6_idSpell","7_idSpell","8_idSpell","9_idSpell","10_idSpell") values ('2c2d59b3-56cb-4c9a-be9d-c36ce6c409ea','spell25274','spell44205','spell63377','spell79943','spell64124','spell74840','spell15592','spell78728','spell75992','spell40001');

INSERT INTO MAGICAL_BEING_HAD("ID_MAGICAL_BEING","ID_GRIMOAR") values('bd41658c-15d4-4a6f-bd8c-330cdfcde63d','8d14e285-a7e6-4c4d-8ab4-5528c7ba6e61');
INSERT INTO MAGICAL_BEING_HAD("ID_MAGICAL_BEING","ID_GRIMOAR") values('78b2c328-f6d2-434b-a44b-637ae95e4684','d715a9f6-180d-41a0-8f4b-eae109ddaf36');

INSERT INTO MAGICAL_BEING_CAN_HAVE(ID_MAGICAL_BEING, ID_GRIMOAR) values ('5a88d488-9211-4bac-b129-f1a030d084a3','d715a9f6-180d-41a0-8f4b-eae109ddaf36');
INSERT INTO MAGICAL_BEING_CAN_HAVE(ID_MAGICAL_BEING, ID_GRIMOAR) values ('340ea254-09af-4afb-852c-6da0b1fe4af5','d715a9f6-180d-41a0-8f4b-eae109ddaf36');
INSERT INTO MAGICAL_BEING_CAN_HAVE(ID_MAGICAL_BEING, ID_GRIMOAR) values ('e3f92c06-0f66-43d7-9f5d-0d7d324f2266','d715a9f6-180d-41a0-8f4b-eae109ddaf36');
INSERT INTO MAGICAL_BEING_CAN_HAVE(ID_MAGICAL_BEING, ID_GRIMOAR) values ('c13827fa-2ec2-40d9-8e60-a26eab1a6d32','d715a9f6-180d-41a0-8f4b-eae109ddaf36');
INSERT INTO MAGICAL_BEING_CAN_HAVE(ID_MAGICAL_BEING, ID_GRIMOAR) values ('3b91c534-5a83-47b1-9c40-61bf3450218a','d715a9f6-180d-41a0-8f4b-eae109ddaf36');
INSERT INTO MAGICAL_BEING_CAN_HAVE(ID_MAGICAL_BEING, ID_GRIMOAR) values ('bab2f53b-2339-445d-b28b-5bff72b109ef','d715a9f6-180d-41a0-8f4b-eae109ddaf36');
INSERT INTO MAGICAL_BEING_CAN_HAVE(ID_MAGICAL_BEING, ID_GRIMOAR) values ('5a88d488-9211-4bac-b129-f1a030d084a3','8d14e285-a7e6-4c4d-8ab4-5528c7ba6e61');
INSERT INTO MAGICAL_BEING_CAN_HAVE(ID_MAGICAL_BEING, ID_GRIMOAR) values ('340ea254-09af-4afb-852c-6da0b1fe4af5','8d14e285-a7e6-4c4d-8ab4-5528c7ba6e61');
INSERT INTO MAGICAL_BEING_CAN_HAVE(ID_MAGICAL_BEING, ID_GRIMOAR) values ('e3f92c06-0f66-43d7-9f5d-0d7d324f2266','8d14e285-a7e6-4c4d-8ab4-5528c7ba6e61');
INSERT INTO MAGICAL_BEING_CAN_HAVE(ID_MAGICAL_BEING, ID_GRIMOAR) values ('c13827fa-2ec2-40d9-8e60-a26eab1a6d32','8d14e285-a7e6-4c4d-8ab4-5528c7ba6e61');
INSERT INTO MAGICAL_BEING_CAN_HAVE(ID_MAGICAL_BEING, ID_GRIMOAR) values ('3b91c534-5a83-47b1-9c40-61bf3450218a','8d14e285-a7e6-4c4d-8ab4-5528c7ba6e61');
INSERT INTO MAGICAL_BEING_CAN_HAVE(ID_MAGICAL_BEING, ID_GRIMOAR) values ('bab2f53b-2339-445d-b28b-5bff72b109ef','8d14e285-a7e6-4c4d-8ab4-5528c7ba6e61');

INSERT INTO MAGICAL_BEING_CAN_HAVE(ID_MAGICAL_BEING, ID_GRIMOAR) values ('bd41658c-15d4-4a6f-bd8c-330cdfcde63d','7f2d4f24-15f2-4cc8-8bfe-4cbe85780a86');
INSERT INTO MAGICAL_BEING_CAN_HAVE(ID_MAGICAL_BEING, ID_GRIMOAR) values ('78b2c328-f6d2-434b-a44b-637ae95e4684','7f2d4f24-15f2-4cc8-8bfe-4cbe85780a86');
INSERT INTO MAGICAL_BEING_CAN_HAVE(ID_MAGICAL_BEING, ID_GRIMOAR) values ('5a88d488-9211-4bac-b129-f1a030d084a3','7f2d4f24-15f2-4cc8-8bfe-4cbe85780a86');
INSERT INTO MAGICAL_BEING_CAN_HAVE(ID_MAGICAL_BEING, ID_GRIMOAR) values ('340ea254-09af-4afb-852c-6da0b1fe4af5','7f2d4f24-15f2-4cc8-8bfe-4cbe85780a86');
INSERT INTO MAGICAL_BEING_CAN_HAVE(ID_MAGICAL_BEING, ID_GRIMOAR) values ('e3f92c06-0f66-43d7-9f5d-0d7d324f2266','7f2d4f24-15f2-4cc8-8bfe-4cbe85780a86');
INSERT INTO MAGICAL_BEING_CAN_HAVE(ID_MAGICAL_BEING, ID_GRIMOAR) values ('c13827fa-2ec2-40d9-8e60-a26eab1a6d32','7f2d4f24-15f2-4cc8-8bfe-4cbe85780a86');
INSERT INTO MAGICAL_BEING_CAN_HAVE(ID_MAGICAL_BEING, ID_GRIMOAR) values ('3b91c534-5a83-47b1-9c40-61bf3450218a','7f2d4f24-15f2-4cc8-8bfe-4cbe85780a86');
INSERT INTO MAGICAL_BEING_CAN_HAVE(ID_MAGICAL_BEING, ID_GRIMOAR) values ('bab2f53b-2339-445d-b28b-5bff72b109ef','7f2d4f24-15f2-4cc8-8bfe-4cbe85780a86');
INSERT INTO MAGICAL_BEING_CAN_HAVE(ID_MAGICAL_BEING, ID_GRIMOAR) values ('bd41658c-15d4-4a6f-bd8c-330cdfcde63d','2c2d59b3-56cb-4c9a-be9d-c36ce6c409ea');
INSERT INTO MAGICAL_BEING_CAN_HAVE(ID_MAGICAL_BEING, ID_GRIMOAR) values ('78b2c328-f6d2-434b-a44b-637ae95e4684','2c2d59b3-56cb-4c9a-be9d-c36ce6c409ea');
INSERT INTO MAGICAL_BEING_CAN_HAVE(ID_MAGICAL_BEING, ID_GRIMOAR) values ('5a88d488-9211-4bac-b129-f1a030d084a3','2c2d59b3-56cb-4c9a-be9d-c36ce6c409ea');
INSERT INTO MAGICAL_BEING_CAN_HAVE(ID_MAGICAL_BEING, ID_GRIMOAR) values ('340ea254-09af-4afb-852c-6da0b1fe4af5','2c2d59b3-56cb-4c9a-be9d-c36ce6c409ea');
INSERT INTO MAGICAL_BEING_CAN_HAVE(ID_MAGICAL_BEING, ID_GRIMOAR) values ('e3f92c06-0f66-43d7-9f5d-0d7d324f2266','2c2d59b3-56cb-4c9a-be9d-c36ce6c409ea');
INSERT INTO MAGICAL_BEING_CAN_HAVE(ID_MAGICAL_BEING, ID_GRIMOAR) values ('c13827fa-2ec2-40d9-8e60-a26eab1a6d32','2c2d59b3-56cb-4c9a-be9d-c36ce6c409ea');
INSERT INTO MAGICAL_BEING_CAN_HAVE(ID_MAGICAL_BEING, ID_GRIMOAR) values ('3b91c534-5a83-47b1-9c40-61bf3450218a','2c2d59b3-56cb-4c9a-be9d-c36ce6c409ea');
INSERT INTO MAGICAL_BEING_CAN_HAVE(ID_MAGICAL_BEING, ID_GRIMOAR) values ('bab2f53b-2339-445d-b28b-5bff72b109ef','2c2d59b3-56cb-4c9a-be9d-c36ce6c409ea');

insert into SCROLL (ID_SCROLL, "Name", USED,"idSpell","ID_MAGICAL_BEING") values (1, 'Ibuprofen (NSAID) Pain Reliever/Fever Reducer', 0,'spell25274','bd41658c-15d4-4a6f-bd8c-330cdfcde63d');
insert into SCROLL (ID_SCROLL, "Name", USED,"idSpell","ID_MAGICAL_BEING") values (2, 'leader miconazole 1',  0,'spell79943','bd41658c-15d4-4a6f-bd8c-330cdfcde63d');
insert into SCROLL (ID_SCROLL, "Name", USED,"idSpell","ID_MAGICAL_BEING") values (3, 'Cool Melon',  0,'spell44205','3b91c534-5a83-47b1-9c40-61bf3450218a');
insert into SCROLL (ID_SCROLL, "Name", USED,"idSpell","ID_MAGICAL_BEING") values (4, 'Old Spice Wild Collection', 1,'spell75992','340ea254-09af-4afb-852c-6da0b1fe4af5');
insert into SCROLL (ID_SCROLL, "Name", USED,"idSpell","ID_MAGICAL_BEING") values (5, 'TONYMOLY INTENSE CARE GOLD 24K SNAIL',  0,'spell78728','340ea254-09af-4afb-852c-6da0b1fe4af5');
insert into SCROLL (ID_SCROLL, "Name", USED,"idSpell","ID_MAGICAL_BEING") values (6, 'Banana Boat Sport Performance SPF 30 Canada',  0,'spell74840','3b91c534-5a83-47b1-9c40-61bf3450218a');
insert into SCROLL (ID_SCROLL, "Name", USED,"idSpell","ID_MAGICAL_BEING") values (7, 'Soft and Dri Clear Glide IS Antiperspirant Floral Bouquet',1,'spell15592','5a88d488-9211-4bac-b129-f1a030d084a3');
insert into SCROLL (ID_SCROLL, "Name", USED,"idSpell","ID_MAGICAL_BEING") values (8, 'Zolpidem Tartrate',  0 ,'spell64124','340ea254-09af-4afb-852c-6da0b1fe4af5');
insert into SCROLL (ID_SCROLL, "Name", USED,"idSpell","ID_MAGICAL_BEING") values (9, 'Tivicay', 1,'spell75992','340ea254-09af-4afb-852c-6da0b1fe4af5');
insert into SCROLL (ID_SCROLL, "Name", USED,"idSpell","ID_MAGICAL_BEING") values (10, 'Bay Leaf', 1,'spell63377','340ea254-09af-4afb-852c-6da0b1fe4af5');

insert into POSITIVE_SYNERGY("limit", "ID_MAGICAL_BEING", "idElement") values (100, 'e3f92c06-0f66-43d7-9f5d-0d7d324f2266', 'elem01918');
insert into POSITIVE_SYNERGY("limit", "ID_MAGICAL_BEING", "idElement") values (50, 'bab2f53b-2339-445d-b28b-5bff72b109ef', 'elem55873');
insert into POSITIVE_SYNERGY("limit", "ID_MAGICAL_BEING", "idElement") values (50, '3b91c534-5a83-47b1-9c40-61bf3450218a', 'elem06711');

insert into CURSED_BEING ("duration", ID_MAGICAL_BEING, "idSpell") VALUES (420, '5a88d488-9211-4bac-b129-f1a030d084a3', 'spell44205');
insert into CURSED_BEING ("duration", ID_MAGICAL_BEING, "idSpell") VALUES (720, 'c13827fa-2ec2-40d9-8e60-a26eab1a6d32', 'spell74840');


---------------------------------- SELECTS ----------------------------------
-- POŽADAVEK: spojení dvou tabulek
-- Ktorý kuzelnici vlastnili svitok ?  Vypiste nazov kuzelnika a nazov svitku
Select scroll."Name" , magic_being."Name" From
( Select * From SCROLL ) scroll
inner join
( Select * From MAGICAL_BEING) magic_being
on scroll.ID_MAGICAL_BEING  = magic_being.ID_MAGICAL_BEING ;

-- POŽADAVEK: spojení dvou tabulek
-- Ktoré kúzla majú hlavný element s farbou Indigo ? Vypiste názov kúzla a názov elementu
Select spells."spellName" , elements."elementName" from
( Select * from SPELL ) spells
inner join
( Select * From ELEMENT where "colorMagic" = 'Indigo' ) elements
on spells."mainElement" = elements."idElement";

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

-- Požadavek: 2 dotazy s klauzulí GROUP BY a agregační funkcí
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

-- Požadavek: 2 dotazy s klauzulí GROUP BY a agregační funkcí
-- Koľko kuziel ma silu väčšiu ako 50
-- Evidujte počet kuziel splnujuce podmienku
SELECT COUNT(strong_spells.id) count
FROM (SELECT "SPELL"."idSpell" id
    FROM "SPELL"
    WHERE "SPELL"."strength" > 50
    GROUP BY "SPELL"."idSpell") strong_spells;

-- POŽADAVEK: jeden dotaz obsahující predikát EXISTS
-- Ak existuju kuzelníci ktorí maju pozitivnu synergiu s elementom vacsiu ako 50 tak vypis bytosti s
-- pozitivnou synergiou vacsou ako 50
Select * From
(Select * from MAGICAL_BEING where
exists (
Select * from POSITIVE_SYNERGY Where "limit" > 50) ) magical_being
inner join ( Select * from POSITIVE_SYNERGY Where "limit" > 50) positive
ON  positive.ID_MAGICAL_BEING = magical_being.ID_MAGICAL_BEING;

-- POŽADAVEK: dotaz s predikátem IN s vnořeným selectem
-- Nájdite elementy ktoré sú main elementom nejakého kúzla
-- Evidujte id elementu, nazov elementu, barvu_elementu
SELECT *
FROM "ELEMENT"
WHERE "ELEMENT"."idElement"
          IN (SELECT "SPELL"."mainElement"
              FROM "SPELL");


---------------------------------- ACCESS ----------------------------------
GRANT ALL ON "CHARGING_PLACE" TO xosval03;
GRANT ALL ON "CURSED_BEING" TO xosval03;
GRANT ALL ON "ELEMENT" TO xosval03;
GRANT ALL ON "ELEMENT_SPECIALIZATION" TO xosval03;
GRANT ALL ON "GRIMOIRE" TO xosval03;
GRANT ALL ON "GRIMOIRE_CONTAINS_SPELLS" TO xosval03;
GRANT ALL ON "MAGICAL_BEING" TO xosval03;
GRANT ALL ON "MAGICAL_BEING_CAN_HAVE" TO xosval03;
GRANT ALL ON "MAGICAL_BEING_HAD" TO xosval03;
GRANT ALL ON "POSITIVE_SYNERGY" TO xosval03;
GRANT ALL ON "SCROLL" TO xosval03;
GRANT ALL ON "SECONDARY_ELEMENTS" TO xosval03;
GRANT ALL ON "SPECIALIZATION" TO xosval03;
GRANT ALL ON "SPELL" TO xosval03;