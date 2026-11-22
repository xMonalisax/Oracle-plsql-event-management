CREATE OR REPLACE PACKAGE pck_utilizatori AS
    PROCEDURE adauga_utilizator(p_id NUMBER, p_nume VARCHAR2, p_email VARCHAR2);
    PROCEDURE sterge_utilizator(p_id NUMBER);
    FUNCTION nr_evenimente_utilizator(p_id NUMBER) RETURN NUMBER;
END pck_utilizatori;
/
CREATE OR REPLACE PACKAGE BODY pck_utilizatori AS
    PROCEDURE adauga_utilizator(p_id NUMBER, p_nume VARCHAR2, p_email VARCHAR2) IS
    BEGIN
        INSERT INTO Utilizatori(Id_utilizator, Nume, Email) 
        VALUES (p_id, p_nume, p_email);
    END;
    PROCEDURE sterge_utilizator(p_id NUMBER) IS
    BEGIN
        DELETE FROM Utilizatori WHERE Id_utilizator = p_id;
    END;
    FUNCTION nr_evenimente_utilizator(p_id NUMBER) RETURN NUMBER IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM Evenimente WHERE Id_utilizator = p_id;
        RETURN v_count;
    END;
END pck_utilizatori;
/

CREATE OR REPLACE PACKAGE pck_evenimente AS
    PROCEDURE actualizeaza_descriere(p_id NUMBER, p_descriere VARCHAR2);
    FUNCTION eveniment_este_viitor(p_id NUMBER) RETURN VARCHAR2;
END pck_evenimente;
/
CREATE OR REPLACE PACKAGE BODY pck_evenimente AS
    PROCEDURE actualizeaza_descriere(p_id NUMBER, p_descriere VARCHAR2) IS
    BEGIN
        UPDATE Evenimente SET Descriere = p_descriere WHERE Id_eveniment = p_id;
    END;
    FUNCTION eveniment_este_viitor(p_id NUMBER) RETURN VARCHAR2 IS
        v_date DATE;
    BEGIN
        SELECT Data_eveniment INTO v_date FROM Evenimente WHERE Id_eveniment = p_id;
        IF v_date > SYSDATE THEN
            RETURN 'DA';
        ELSE
            RETURN 'NU';
        END IF;
    END;
END pck_evenimente;
/

CREATE OR REPLACE PACKAGE pck_analiza_evenimente AS
    FUNCTION numar_evenimente_totale RETURN NUMBER;
    FUNCTION utilizator_cu_cele_mai_multe_evenimente RETURN VARCHAR2;
    FUNCTION exista_evenimente_pe_zi(p_data DATE) RETURN VARCHAR2;
    PROCEDURE afiseaza_evenimente_utilizator(p_id_utilizator NUMBER);
END pck_analiza_evenimente;
/
CREATE OR REPLACE PACKAGE BODY pck_analiza_evenimente AS
    FUNCTION numar_evenimente_totale RETURN NUMBER IS
        v_total NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_total FROM Evenimente;
        RETURN v_total;
    END;
    FUNCTION utilizator_cu_cele_mai_multe_evenimente RETURN VARCHAR2 IS
        v_nume VARCHAR2(100);
    BEGIN
        SELECT U.Nume INTO v_nume
        FROM Utilizatori U
        JOIN Evenimente E ON U.Id_utilizator = E.Id_utilizator
        GROUP BY U.Nume
        ORDER BY COUNT(E.Id_eveniment) DESC
        FETCH FIRST 1 ROWS ONLY;
        RETURN v_nume;
    END;
    FUNCTION exista_evenimente_pe_zi(p_data DATE) RETURN VARCHAR2 IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM Evenimente WHERE TRUNC(Data_eveniment) = TRUNC(p_data);
        IF v_count > 0 THEN
            RETURN 'DA';
        ELSE
            RETURN 'NU';
        END IF;
    END;
    PROCEDURE afiseaza_evenimente_utilizator(p_id_utilizator NUMBER) IS
        CURSOR c_evenimente IS
            SELECT Nume_eveniment, Data_eveniment
            FROM Evenimente
            WHERE Id_utilizator = p_id_utilizator;
        v_nume VARCHAR2(100);
        v_data DATE;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Evenimentele utilizatorului cu ID ' || p_id_utilizator || ':');
        OPEN c_evenimente;
        LOOP
            FETCH c_evenimente INTO v_nume, v_data;
            EXIT WHEN c_evenimente%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('- ' || v_nume || ' (' || TO_CHAR(v_data, 'DD-MM-YYYY') || ')');
        END LOOP;
        CLOSE c_evenimente;
    END;
END pck_analiza_evenimente;
/
