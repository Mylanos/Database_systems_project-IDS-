CREATE TABLE "SPELL"
(
    "idNumber" CHARACTER VARYING(100)
        CONSTRAINT "spell_idNumber_PK" PRIMARY KEY,
    "spellName" CHARACTER VARYING(100)
        CONSTRAINT "spell_spellName_NN" NOT NULL,
    "difficultyOfCasting" CHARACTER VARYING(100)
        CONSTRAINT "spell_difficultyOfCasting_NN" NOT NULL,
    "type" CHARACTER VARYING(100)
        CONSTRAINT "spell_type_NN" NOT NULL,
    "power" INTEGER DEFAULT 0
        CONSTRAINT "spell_power_NN" NOT NULL

    CONSTRAINT "user_accountNumber_FK" FOREIGN KEY("accountNumber") REFERENCES ACCOUNT ("accountNumber") ON DELETE CASCADE
);

CREATE TABLE "ELEMENT"
(
    "idNumber" CHARACTER VARYING(100)
        CONSTRAINT "element_idNumber_PK" PRIMARY KEY,
    "elementName" CHARACTER VARYING(100)
        CONSTRAINT "elementName_NN" NOT NULL,
    "colorMagic" CHARACTER VARYING(100)
        CONSTRAINT "colorMagic_NN" NOT NULL
);
