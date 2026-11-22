INSERT INTO Utilizatori VALUES (1, 'Ana Popescu', 'ana.popescu@example.com');
INSERT INTO Utilizatori VALUES (2, 'Maria Ionescu', 'maria.ionescu@example.com');
INSERT INTO Utilizatori VALUES (3, 'Andrei Marin', 'andrei.marin@example.com');

INSERT INTO Tipuri_evenimente VALUES (1, 'Aniversare');
INSERT INTO Tipuri_evenimente VALUES (2, 'Sarbatoare');
INSERT INTO Tipuri_evenimente VALUES (3, 'Intalnire');

INSERT INTO Evenimente VALUES (1, 'Zi de nastere', DATE '2027-04-15', 'Aniversare familie', 1);
INSERT INTO Evenimente VALUES (2, 'Petrecere de 1 mai', DATE '2027-05-01', 'Petrecere cu prietenii', 1);
INSERT INTO Evenimente VALUES (3, 'Intalnire echipa', DATE '2027-06-12', 'Discutie proiect', 2);
INSERT INTO Evenimente VALUES (4, 'Revelion', DATE '2027-12-31', 'Organizare Revelion', 3);

INSERT INTO Legatura_evenimente_tip VALUES (1, 1);
INSERT INTO Legatura_evenimente_tip VALUES (2, 2);
INSERT INTO Legatura_evenimente_tip VALUES (3, 3);
INSERT INTO Legatura_evenimente_tip VALUES (4, 2);
COMMIT;
