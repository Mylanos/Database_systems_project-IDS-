Create Table "GRIMOIRE"(
        "ID_GRIMOAR" CHARACTER VARYING(100) CONSTRAINT "ID_Grimoar_PK" PRIMARY KEY,
        "State_of_charged_magic" integer  constraint "State_of_charged_magic_NN" NOT NULL,
        "Name_of_grimoire" CHARACTER VARYING(100) CONSTRAINT "NOT NULL" NOT NULL
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
Create Table "SCROLL" (
    "ID_SCROLL" NUMBER CONSTRAINT "ID_SCROLL_PK" PRIMARY KEY,
    "Name" CHARACTER VARYING(100) CONSTRAINT "SCROLL_Name_NN" NOT NULL,
    "USED" integer CONSTRAINT "SCROLL_USED_NN"  CHECK ( "USED" = 0 OR "USED" = 1),
    "ID_MAGICAL_BEING_FK" CHARACTER VARYING(100) NOT NULL ,
    CONSTRAINT "ID_MAGICAL_BEING_FK" FOREIGN KEY("ID_MAGICAL_BEING_FK") REFERENCES "MAGICAL_BEING"("ID_MAGICAL_BEING") ON DELETE CASCADE
);



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
    "difficultyOfCasting" CHARACTER VARYING(100),
    "type" CHARACTER VARYING(100),
    "power" INTEGER DEFAULT 0,
    "mainElement" CHARACTER VARYING(100)
        CONSTRAINT "spell_idElement_NN" NOT NULL
        CONSTRAINT "spell_idElement_U" UNIQUE,

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
    "Type" CHARACTER VARYING(100)
        CONSTRAINT "specializType_NN" NOT NULL
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
    "measurementOfSeekage" INTEGER DEFAULT 0,
    "idElement" CHARACTER VARYING(100)
        CONSTRAINT "charging_idElement_U" UNIQUE,

    CONSTRAINT "charging_idElement_FK" FOREIGN KEY("idElement") REFERENCES ELEMENT ("idElement") ON DELETE CASCADE -- Prosakuje
);

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
