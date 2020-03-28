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
