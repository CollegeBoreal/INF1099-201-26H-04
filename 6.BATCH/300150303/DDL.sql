-- ============================================================
--  DDL.sql — Définition des données (Data Definition Language)
--  Projet  : Gestion d'un Salon de Coiffure
--  SGBD    : PostgreSQL
--  Auteur  : Jesmina
-- ============================================================

-- Suppression des tables si elles existent déjà (ordre inverse des FK)
DROP TABLE IF EXISTS PAYEMENT     CASCADE;
DROP TABLE IF EXISTS RENDEZ_VOUS  CASCADE;
DROP TABLE IF EXISTS MODELE       CASCADE;
DROP TABLE IF EXISTS SERVICE      CASCADE;
DROP TABLE IF EXISTS COIFFEUSE    CASCADE;
DROP TABLE IF EXISTS CLIENT       CASCADE;

-- ------------------------------------------------------------
--  Table CLIENT
-- ------------------------------------------------------------
CREATE TABLE CLIENT (
    id_client   SERIAL        PRIMARY KEY,
    Nom         VARCHAR(100)  NOT NULL,
    Prenom      VARCHAR(100)  NOT NULL,
    Telephone   VARCHAR(20)   UNIQUE,
    Email       VARCHAR(150)  NOT NULL UNIQUE
);

-- ------------------------------------------------------------
--  Table COIFFEUSE
-- ------------------------------------------------------------
CREATE TABLE COIFFEUSE (
    id_coiffeuse  SERIAL        PRIMARY KEY,
    Nom           VARCHAR(100)  NOT NULL,
    Specialite    VARCHAR(100)
);

-- ------------------------------------------------------------
--  Table SERVICE
-- ------------------------------------------------------------
CREATE TABLE SERVICE (
    id_service   SERIAL        PRIMARY KEY,
    Nom_service  VARCHAR(150)  NOT NULL,
    Prix         NUMERIC(8,2)  NOT NULL CHECK (Prix >= 0)
);

-- ------------------------------------------------------------
--  Table MODELE
-- ------------------------------------------------------------
CREATE TABLE MODELE (
    id_modele   SERIAL        PRIMARY KEY,
    Nom_modele  VARCHAR(150)  NOT NULL,
    Description TEXT
);

-- ------------------------------------------------------------
--  Table RENDEZ_VOUS
-- ------------------------------------------------------------
CREATE TABLE RENDEZ_VOUS (
    id_rdv        SERIAL   PRIMARY KEY,
    Date_rdv      DATE     NOT NULL,
    Heure_rdv     TIME     NOT NULL,
    id_client     INTEGER  NOT NULL,
    id_coiffeuse  INTEGER  NOT NULL,
    id_service    INTEGER  NOT NULL,
    id_modele     INTEGER  NOT NULL,

    CONSTRAINT fk_rdv_client     FOREIGN KEY (id_client)    REFERENCES CLIENT(id_client),
    CONSTRAINT fk_rdv_coiffeuse  FOREIGN KEY (id_coiffeuse) REFERENCES COIFFEUSE(id_coiffeuse),
    CONSTRAINT fk_rdv_service    FOREIGN KEY (id_service)   REFERENCES SERVICE(id_service),
    CONSTRAINT fk_rdv_modele     FOREIGN KEY (id_modele)    REFERENCES MODELE(id_modele)
);

-- ------------------------------------------------------------
--  Table PAYEMENT
-- ------------------------------------------------------------
CREATE TABLE PAYEMENT (
    id_payement    SERIAL        PRIMARY KEY,
    Date_payement  DATE          NOT NULL,
    Montant        NUMERIC(8,2)  NOT NULL CHECK (Montant >= 0),
    Mode_payement  VARCHAR(50)   NOT NULL,
    id_rdv         INTEGER       NOT NULL,

    CONSTRAINT fk_pay_rdv FOREIGN KEY (id_rdv) REFERENCES RENDEZ_VOUS(id_rdv)
);

-- ------------------------------------------------------------
--  Index pour optimisation des performances
-- ------------------------------------------------------------
CREATE INDEX idx_rv_client     ON RENDEZ_VOUS(id_client);
CREATE INDEX idx_rv_coiffeuse  ON RENDEZ_VOUS(id_coiffeuse);
CREATE INDEX idx_rv_service    ON RENDEZ_VOUS(id_service);
CREATE INDEX idx_rv_modele     ON RENDEZ_VOUS(id_modele);
CREATE INDEX idx_rv_date       ON RENDEZ_VOUS(Date_rdv);
CREATE INDEX idx_rv_date_coif  ON RENDEZ_VOUS(Date_rdv, id_coiffeuse);
CREATE INDEX idx_pay_rdv       ON PAYEMENT(id_rdv);
CREATE INDEX idx_client_email  ON CLIENT(Email);
