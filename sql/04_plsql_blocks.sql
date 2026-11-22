-- Cod din proiectul academic; nu toate exemplele sunt independente.
-- Rulati blocurile individual, dupa initializarea schemei.

-- Exemplul 1 (extras din proiectul academic)
DECLARE
 v_numar_evenimente NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_numar_evenimente
    FROM evenimente
    WHERE id_utilizator = 1;
    DBMS_OUTPUT.PUT_LINE('Utilizatorul 1 are ' || v_numar_evenimente || ' evenimente.');
    DBMS_OUTPUT.PUT_LINE('S-au actualizat ' || SQL%ROWCOUNT || ' rânduri.');
END;
/

-- Exemplul 2 (extras din proiectul academic)
DECLARE
    CURSOR c_evenimente IS
        SELECT Nume_eveniment, Data_eveniment FROM Evenimente;
    v_nume_eveniment VARCHAR2(100);
    v_data_eveniment DATE;
BEGIN
    OPEN c_evenimente;
    LOOP
        FETCH c_evenimente INTO v_nume_eveniment, v_data_eveniment;
        EXIT WHEN c_evenimente%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Eveniment: ' || v_nume_eveniment || ' pe ' || TO_CHAR(v_data_eveniment, 'DD-MON-YYYY'));
    END LOOP;
    CLOSE c_evenimente;
END;
/

-- Exemplul 3 (extras din proiectul academic)
DECLARE
    v_id_eveniment NUMBER := 1;  
    v_descriere VARCHAR2(255);
BEGIN 
    SELECT Descriere INTO v_descriere
    FROM Evenimente
    WHERE Id_eveniment = v_id_eveniment;
    IF v_descriere IS NULL THEN
        DELETE FROM Evenimente WHERE Id_eveniment = v_id_eveniment;     
        DBMS_OUTPUT.PUT_LINE('Evenimentul cu ID ' || v_id_eveniment || ' a fost șters.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Evenimentul are descrierea completă.');
    END IF;
    DBMS_OUTPUT.PUT_LINE('SQL%ROWCOUNT: ' || SQL%ROWCOUNT);
END;
/

-- Exemplul 4 (extras din proiectul academic)
DECLARE
    v_exist NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_exist FROM Utilizatori WHERE Id_utilizator = 4;
    IF v_exist = 0 THEN
        INSERT INTO Utilizatori (Id_utilizator, Nume, Email)
        VALUES (4, 'Elena Georgescu', 'elena.georgescu@example.com');   
        DBMS_OUTPUT.PUT_LINE('Utilizator adăugat cu succes.');  
        INSERT INTO Evenimente (Id_eveniment, Nume_eveniment, Data_eveniment, Descriere, Id_utilizator)
        VALUES (10, 'Petrecere de aniversare', TO_DATE('2025-07-10', 'YYYY-MM-DD'), 'Petrecere pentru aniversarea lui Elena', 4);   
        DBMS_OUTPUT.PUT_LINE('Eveniment adăugat pentru utilizatorul Elena Georgescu.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Utilizatorul există deja.');
    END IF;
END;
/

-- Exemplul 5 (extras din proiectul academic)
DECLARE
    CURSOR c_utilizatori IS
        SELECT Id_utilizator, Nume FROM Utilizatori;
    v_id_utilizator NUMBER;
    v_nume VARCHAR2(100);
    v_numar_evenimente NUMBER;
BEGIN
    OPEN c_utilizatori;
    LOOP
        FETCH c_utilizatori INTO v_id_utilizator, v_nume;
        EXIT WHEN c_utilizatori%NOTFOUND;    
        SELECT COUNT(*) INTO v_numar_evenimente FROM Evenimente WHERE Id_utilizator = v_id_utilizator;      
        DBMS_OUTPUT.PUT_LINE('Utilizator: ' || v_nume || ' are ' || v_numar_evenimente || ' evenimente.');
    END LOOP;
    CLOSE c_utilizatori;
END;
/

-- Exemplul 6 (extras din proiectul academic)
DECLARE
    v_id_utilizator Evenimente.Id_utilizator%TYPE := 1;
    v_nume_eveniment Evenimente.Nume_eveniment%TYPE;
    v_data_eveniment Evenimente.Data_eveniment%TYPE;
    CURSOR c_evenimente(p_id_utilizator NUMBER) IS
        SELECT Nume_eveniment, Data_eveniment
        FROM Evenimente
        WHERE Id_utilizator = p_id_utilizator;
BEGIN
    OPEN c_evenimente(v_id_utilizator);
    LOOP
        FETCH c_evenimente INTO v_nume_eveniment, v_data_eveniment;
        EXIT WHEN c_evenimente%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Eveniment: ' || v_nume_eveniment || ' | Data: ' || TO_CHAR(v_data_eveniment, 'YYYY-MM-DD'));
    END LOOP;
    CLOSE c_evenimente;
END;
/

-- Exemplul 7 (extras din proiectul academic)
DECLARE
    v_id_utilizator Utilizatori.Id_utilizator%TYPE := 1;
    v_nume Utilizatori.Nume%TYPE := 'Calin Ioana Monalisa';
    v_email Utilizatori.Email%TYPE := 'ioana.monalisa@example.com';
BEGIN
    INSERT INTO Utilizatori (Id_utilizator, Nume, Email)
    VALUES (v_id_utilizator, v_nume, v_email);
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: Id_utilizator sau Email deja există.');
END;
/

-- Exemplul 8 (extras din proiectul academic)
DECLARE
    v_id_utilizator NUMBER := 5; 
    v_nr_evenimente NUMBER;
    ex_fara_evenimente EXCEPTION;
BEGIN
    SELECT COUNT(*) INTO v_nr_evenimente
    FROM Evenimente
    WHERE Id_utilizator = v_id_utilizator;
    IF v_nr_evenimente = 0 THEN
        RAISE ex_fara_evenimente;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Utilizatorul are ' || v_nr_evenimente || ' evenimente.');
    END IF;
EXCEPTION
    WHEN ex_fara_evenimente THEN
        DBMS_OUTPUT.PUT_LINE('Excepție: Utilizatorul nu are niciun eveniment.');
END;
/

-- Exemplul 9 (extras din proiectul academic)
DECLARE
    v_id_eveniment Evenimente.Id_eveniment%TYPE := 99;
    v_nume_eveniment Evenimente.Nume_eveniment%TYPE := 'Reuniune de familie';
    v_data_eveniment Evenimente.Data_eveniment%TYPE := TO_DATE('2024-12-31', 'YYYY-MM-DD'); 
BEGIN
    INSERT INTO Evenimente (Id_eveniment, Nume_eveniment, Data_eveniment, Descriere, Id_utilizator)
    VALUES (v_id_eveniment, v_nume_eveniment, v_data_eveniment, 'Ne întâlnim cu rudele înainte de Anul Nou', 1);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('A apărut o eroare: ' || SQLERRM);
END;
/

-- Exemplul 10 (extras din proiectul academic)
DECLARE
    v_id_utilizator NUMBER := 10; 
    v_id_eveniment NUMBER := 10;
    v_nume_eveniment VARCHAR2(100) := 'Conferință';
    v_data_eveniment DATE := TO_DATE('2025-05-20', 'YYYY-MM-DD');
    ex_utilizator_inexistent EXCEPTION;
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM Utilizatori
    WHERE Id_utilizator = v_id_utilizator;
    IF v_count = 0 THEN
        RAISE ex_utilizator_inexistent;
    ELSE
        INSERT INTO Evenimente (Id_eveniment, Nume_eveniment, Data_eveniment, Descriere, Id_utilizator)
        VALUES (v_id_eveniment, v_nume_eveniment, v_data_eveniment, 'Eveniment important', v_id_utilizator);
        DBMS_OUTPUT.PUT_LINE('Eveniment adăugat cu succes.');
    END IF;
EXCEPTION
    WHEN ex_utilizator_inexistent THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: Utilizatorul nu există în sistem.');
END;
/

-- Exemplul 11 (extras din proiectul academic)
DECLARE
    v_nume_utilizator Utilizatori.Nume%TYPE;
    v_id_utilizator NUMBER := 999; -- un ID care nu există în tabelă
BEGIN
    -- Încercăm să extragem numele unui utilizator după un ID inexistent
    SELECT Nume INTO v_nume_utilizator
    FROM Utilizatori
    WHERE Id_utilizator = v_id_utilizator;
    DBMS_OUTPUT.PUT_LINE('Numele utilizatorului este: ' || v_nume_utilizator);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Eroare implicită: Nu există utilizator cu ID-ul ' || v_id_utilizator);
END;
/
