-------------------------
--  Partie drop table  --
-------------------------
DROP TABLE IF EXISTS Licence CASCADE;
DROP TABLE IF EXISTS Pc CASCADE;
DROP TABLE IF EXISTS detient CASCADE;
DROP TABLE IF EXISTS Salle CASCADE;
DROP TABLE IF EXISTS Joueur CASCADE;
DROP TABLE IF EXISTS Eleve CASCADE;
DROP TABLE IF EXISTS Professeur CASCADE;
DROP TABLE IF EXISTS Score CASCADE;
DROP TABLE IF EXISTS Malus CASCADE;
DROP TABLE IF EXISTS Os CASCADE;
DROP TABLE IF EXISTS Etat CASCADE;

---------------------
--  Partie create  --
---------------------
CREATE TABLE Joueur (
                        id SERIAL PRIMARY KEY,
                        nom VARCHAR(255),
                        argent INT,
                        jour DATE,
                        annee DATE
);

CREATE TABLE Score (
                       id SERIAL PRIMARY KEY,
                       idJoueur INT NOT NULL,
                       scoreFinal INT,
                       dateFinal DATE,
                       FOREIGN KEY (idJoueur) REFERENCES Joueur(id)
);

CREATE TABLE Eleve (
                       id SERIAL PRIMARY KEY,
                       engagement INT
);

CREATE TABLE Professeur (
                            id SERIAL PRIMARY KEY,
                            Interet INT,
                            preference VARCHAR(255)
);

CREATE TABLE Salle (
                       id SERIAL PRIMARY KEY,
                       nbObjet INT,
                       idProfesseur INT,
                       idEleve INT,
                       FOREIGN KEY (idProfesseur) REFERENCES Professeur(id),
                       FOREIGN KEY (idEleve) REFERENCES Eleve(id)
);

CREATE TABLE Malus (
                       id SERIAL PRIMARY KEY,
                       nom VARCHAR(255)
);

CREATE TABLE Os (
                    id SERIAL PRIMARY KEY,
                    nom VARCHAR(255)
);

CREATE TABLE Etat (
                      id SERIAL PRIMARY KEY,
                      nom VARCHAR(255)
);

CREATE TABLE Licence (
                         id SERIAL PRIMARY KEY,
                         nom VARCHAR(255),
                         prix INT
);

CREATE TABLE Pc (
                    id SERIAL PRIMARY KEY,
                    idEtat INT NOT NULL,
                    idOs INT NOT NULL,
                    idMalus INT NOT NULL,
                    idSalle INT NOT NULL,
                    idLicence INT NOT NULL,
                    probaDégradation INT,
                    prix INT,
                    FOREIGN KEY (idEtat) REFERENCES Etat(id),
                    FOREIGN KEY (idOs) REFERENCES Os(id),
                    FOREIGN KEY (idMalus) REFERENCES Malus(id),
                    FOREIGN KEY (idSalle) REFERENCES Salle(id),
                    FOREIGN KEY (idLicence) REFERENCES Licence(id)
);

CREATE TABLE detient (
                         id SERIAL PRIMARY KEY,
                         idJoueur INT,
                         idPc INT,
                         annee DATE,
                         FOREIGN KEY (idJoueur) REFERENCES Joueur(id),
                         FOREIGN KEY (idPc) REFERENCES Pc(id)
);

---------------------
--  Partie insert  --
---------------------
INSERT INTO Etat (nom) VALUES
                           ('neuf'),
                           ('obsolete'),
                           ('hors service'),
                           ('hors d`usage');

INSERT INTO Os (nom) VALUES
                         ('windows 7'),
                         ('windows 10'),
                         ('windows 11'),
                         ('linux');

INSERT INTO Licence (nom, prix) VALUES
                                    ('WinRAR', 100),
                                    ('7-Zip', 100),
                                    ('IntelliJ IDEA', 100),
                                    ('Visual Studio Code', 100),
                                    ('PyCharm', 100),
                                    ('MariaDB', 100),
                                    ('MongoDB', 100),
                                    ('PostgreSQL', 100),
                                    ('MySQL', 100),
                                    ('Apache OpenOffice', 100),
                                    ('OnlyOffice', 100),
                                    ('Google Workspace', 100),
                                    ('LibreOffice', 100),
                                    ('Microsoft Office', 100),
                                    ('Neo4j', 100),
                                    ('Notepad++', 100),
                                    ('BlueJ', 100),
                                    ('Jupyter Notebook', 100),
                                    ('Virtual DJ', 100),
                                    ('SolidWorks', 100),
                                    ('Tinkercad', 100),
                                    ('Canva', 100),
                                    ('RStudio', 100),
                                    ('RapidMiner', 100),
                                    ('MobaXterm', 100),
                                    ('Docker Desktop', 100),
                                    ('Notion', 100),
                                    ('Adobe Acrobat Pro', 100);