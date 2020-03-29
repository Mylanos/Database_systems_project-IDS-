CREATE TABLE "ELEMENT"
(
    "idElement" CHARACTER VARYING(100)
        CONSTRAINT "element_idElement_PK" PRIMARY KEY,
    "elementName" CHARACTER VARYING(100)
        CONSTRAINT "elementName_NN" NOT NULL,
    "colorMagic" CHARACTER VARYING(100)
        CONSTRAINT "colorMagic_NN" NOT NULL
);

CREATE TABLE "SPELL"
(
    "idSpell" CHARACTER VARYING(100)
        CONSTRAINT "spell_idSpell_PK" PRIMARY KEY,
    "spellName" CHARACTER VARYING(100),
    "difficultyOfCasting" CHARACTER VARYING(100) CHECK ( "difficultyOfCasting" = 'HARD' OR
                                                         "difficultyOfCasting" = 'MEDIUM' OR
                                                         "difficultyOfCasting" = 'EASY'),
    "type" CHARACTER VARYING(100) NOT NULL ,
    "strength" INTEGER DEFAULT 0 CHECK ( "strength" >= 0 AND "strength" <= 100),
    "mainElement" CHARACTER VARYING(100)
        CONSTRAINT "spell_idElement_NN" NOT NULL,

    CONSTRAINT "spell_idElement_FK" FOREIGN KEY("mainElement") REFERENCES ELEMENT ("idElement") ON DELETE CASCADE -- Ma hlavny
);

-- Moze mat vedlajsi
CREATE TABLE "SECONDARY_ELEMENTS"
(
    "idSpell" CHARACTER VARYING(100),
    "idElement" CHARACTER VARYING(100),

    CONSTRAINT "secondaryElements_idSpell_idElement_PK" PRIMARY KEY("idSpell", "idElement"),
    CONSTRAINT "secondaryElements_idSpell_FK" FOREIGN KEY("idSpell") REFERENCES "SPELL"("idSpell") ON DELETE CASCADE,
    CONSTRAINT "secondaryElements_idElement_FK" FOREIGN KEY("idElement") REFERENCES "ELEMENT"("idElement") ON DELETE CASCADE
);

CREATE TABLE "SPECIALIZATION"
(
    "idSpecialization" CHARACTER VARYING(100)
        CONSTRAINT "specializ_idSpecialization_PK" PRIMARY KEY,
    "type" CHARACTER VARYING(100) NOT NULL
);

-- Element moze mat viac
CREATE TABLE "ELEMENT_SPECIALIZATION"
(
    "idSpecialization" CHARACTER VARYING(100),
    "idElement" CHARACTER VARYING(100),

    CONSTRAINT "elemSpecializ_idSpecialization_idElement_PK" PRIMARY KEY("idSpecialization", "idElement"),
    CONSTRAINT "elemSpecializ_idSpecialization_FK" FOREIGN KEY("idSpecialization") REFERENCES "SPECIALIZATION"("idSpecialization") ON DELETE CASCADE,
    CONSTRAINT "elemSpecializ_idElement_FK" FOREIGN KEY("idElement") REFERENCES "ELEMENT"("idElement") ON DELETE CASCADE
);

CREATE TABLE "CHARGING_PLACE"
(
    "idPlace" CHARACTER VARYING(100)
        CONSTRAINT "charging_idPlace_PK" PRIMARY KEY,
    "xCoordinate" INTEGER DEFAULT 0,
    "yCoordinate" INTEGER DEFAULT 0,
    "rateOfSeekage" DECIMAL(3,2) DEFAULT 0,
    "idElement" CHARACTER VARYING(100)
        CONSTRAINT "charging_idElement_NN" NOT NULL,

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
        "ID_MAGICAL_BEING" CHARACTER VARYING(100) CONSTRAINT "ID_Magical_Being_PK" PRIMARY KEY,
        "Story"CHARACTER VARYING(200)  constraint "MAGICAL_BEING_Story_NN" NOT NULL,
        "Name" CHARACTER VARYING(100) CONSTRAINT "MAGICAL_BEING_Name_NN" NOT NULL,
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
    "ID_SCROLL" NUMBER CONSTRAINT "ID_SCROLL_PK" PRIMARY KEY,
    "Name" CHARACTER VARYING(100) CONSTRAINT "SCROLL_Name_NN" NOT NULL,
    "USED" integer CONSTRAINT "SCROLL_USED_NN"  CHECK ( "USED" = 0 OR "USED" = 1),
    "ID_MAGICAL_BEING" CHARACTER VARYING(100) NOT NULL ,
    "idSpell" CHARACTER VARYING(100) NOT NULL UNIQUE ,

    CONSTRAINT "ID_MAGICAL_BEING_FK" FOREIGN KEY("ID_MAGICAL_BEING") REFERENCES "MAGICAL_BEING"("ID_MAGICAL_BEING") ON DELETE CASCADE,
    CONSTRAINT "idSpell_FK" FOREIGN KEY("idSpell") REFERENCES "SPELL"("idSpell") ON DELETE CASCADE


);



CREATE TABLE "GRIMOIRE_CONTAINS_SPELLS"(
    "ID_GRIMOAR" CHARACTER VARYING(100) CONSTRAINT "ID_GRIMOIRE_CONTAINS_SPELLS_ID" PRIMARY KEY REFERENCES "GRIMOIRE"("ID_GRIMOAR") ON DELETE CASCADE,

"1_idSpell" CHARACTER VARYING(100) NOT NULL UNIQUE ,
"2_idSpell" CHARACTER VARYING(100) NOT NULL UNIQUE ,
"3_idSpell" CHARACTER VARYING(100) NOT NULL UNIQUE ,
"4_idSpell" CHARACTER VARYING(100) NOT NULL UNIQUE ,
"5_idSpell" CHARACTER VARYING(100) NOT NULL UNIQUE ,
"6_idSpell" CHARACTER VARYING(100) NOT NULL UNIQUE ,
"7_idSpell" CHARACTER VARYING(100) NOT NULL UNIQUE ,
"8_idSpell" CHARACTER VARYING(100) NOT NULL UNIQUE ,
"9_idSpell" CHARACTER VARYING(100) NOT NULL UNIQUE ,
"10_idSpell" CHARACTER VARYING(100) NOT NULL UNIQUE ,
"11_idSpell" CHARACTER VARYING(100)UNIQUE ,
"12_idSpell" CHARACTER VARYING(100)UNIQUE ,
"13_idSpell" CHARACTER VARYING(100)UNIQUE ,
"14_idSpell" CHARACTER VARYING(100)UNIQUE ,
"15_idSpell" CHARACTER VARYING(100)UNIQUE ,


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

CREATE TABLE "CURSED_BEING"(
        "duration" INTEGER DEFAULT 0 CHECK ( "duration" >= 0 ),
        "ID_MAGICAL_BEING" CHARACTER VARYING(100) UNIQUE ,
        "idSpell" CHARACTER VARYING(100) UNIQUE,

        CONSTRAINT "CURSED_BEING_ID_MAGICAL_BEING_ID_GRIMOAR_PK" PRIMARY KEY("ID_MAGICAL_BEING", "idSpell"),
        CONSTRAINT "CURSED_BEING_ID_MAGICAL_BEING_FK" FOREIGN KEY("ID_MAGICAL_BEING") REFERENCES "MAGICAL_BEING" ("ID_MAGICAL_BEING") ON DELETE CASCADE,
        CONSTRAINT "CURSED_BEING_ID_SPELL_FK" FOREIGN KEY("idSpell") REFERENCES "SPELL"("idSpell") ON DELETE CASCADE
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
