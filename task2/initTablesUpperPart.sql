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
    "type" CHARACTER VARYING(100) NOT NULL,
    "strength" INTEGER DEFAULT 0 CHECK ( "strength" >= 0 AND "strength" <= 100),
    "mainElement" CHARACTER VARYING(100 ) NOT NULL,

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
    "idElement" CHARACTER VARYING(100) NOT NULL,

    CONSTRAINT "charging_idElement_FK" FOREIGN KEY("idElement") REFERENCES ELEMENT ("idElement") ON DELETE CASCADE -- Prosakuje
);


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
