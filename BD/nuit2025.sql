DROP TABLE IF EXISTS Objet CASCADE;
DROP TABLE IF EXISTS detien CASCADE;
DROP TABLE IF EXISTS Salle CASCADE;
DROP TABLE IF EXISTS Joueur CASCADE;
DROP TABLE IF EXISTS Eleve CASCADE;
DROP TABLE IF EXISTS Professeur CASCADE;
DROP TABLE IF EXISTS Score CASCADE;
DROP TABLE IF EXISTS Malus CASCADE;
DROP TABLE IF EXISTS Os CASCADE;
DROP TABLE IF EXISTS Etat CASCADE;

CREATE TABLE Joueur {
    id SERIAL PRIMARY KEY,
    nom VARCHAR(255),
    argent INT,
    jour DATE,
    annee DATE,
}

CREATE TABLE Score {
    id SERIAL PRIMARY KEY,
    idJoueur INT NOT NULL,
    scoreFinal INT,
    dateFinal DATE
    FOREIGN KEY (idJoueur) REFERENCES Joueur(id)
}

CREATE TABLE Eleve {
    id SERIAL PRIMARY KEY,
    engagement INT,
}

CREATE TABLE Professeur {
    id SERIAL PRIMARY KEY,
    Interet INT,
    preference VARCHAR(255)
}

CREATE TABLE Salle {
    id SERIAL PRIMARY KEY,
    nbObjet INT,
    idProfesseur INT,
    idEleve INT,
    FOREIGN KEY (idProfesseur) REFERENCES Professeur(id),
    FOREIGN KEY (idEleve) REFERENCES Eleve(id)
}

CREATE TABLE Malus {
    id SERIAL PRIMARY KEY,
    nom VARCHAR(255)
}

CREATE TABLE Os {
    id SERIAL PRIMARY KEY,
    nom VARCHAR(255)
}

CREATE TABLE Etat {
    id SERIAL PRIMARY KEY,
    nom VARCHAR(255)
}

CREATE TABLE Licence {
    id SERIAL PRIMARY KEY,
    nom VARCHAR(255)
}

CREATE TABLE Pc {
    id SERIAL PRIMARY KEY,
    idEtat INT NOT NULL,
    idOs INT NOT NULL,
    idMalus INT NOT NULL,
    idSalle INT NOT NULL,
    idLicence INT NOT NULL,
    FOREIGN KEY (idEtat) REFERENCES Etat(id),
    FOREIGN KEY (idOs) REFERENCES Os(id),
    FOREIGN KEY (idMalus) REFERENCES Malus(id),
    FOREIGN KEY (idSalle) REFERENCES Salle(id),
    FOREIGN KEY (idLicence) REFERENCES Licence(id)
}

CREATE TABLE detien {
    id SERIAL PRIMARY KEY,
    idJoueur INT,
    idPc INT,
    annee DATE,
    FOREIGN KEY (idJoueur) REFERENCES Joueur(id),
    FOREIGN KEY (idPc) REFERENCES Pc(id)
}