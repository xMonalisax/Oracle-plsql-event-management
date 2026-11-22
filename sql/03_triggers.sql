-- Triggere PL/SQL pentru validare si jurnalizarea modificarilor.

CREATE OR REPLACE TRIGGER trg_check_email_format
BEFORE INSERT ON Utilizatori
FOR EACH ROW
BEGIN
    IF INSTR(:NEW.Email, '@') = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Email invalid: trebuie să conțină caracterul @');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_prevent_delete_tip_eveniment
BEFORE DELETE ON Tipuri_evenimente
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM Legatura_evenimente_tip
    WHERE Id_tip_eveniment = :OLD.Id_tip_eveniment;

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Nu se poate șterge tipul de eveniment deoarece este asociat cu unul sau mai multe evenimente.');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_salveaza_descriere_veche
BEFORE UPDATE OF Descriere ON Evenimente
FOR EACH ROW
BEGIN
    IF NVL(:OLD.Descriere, 'NULL') != NVL(:NEW.Descriere, 'NULL') THEN
        INSERT INTO Istoric_Descrieri_Evenimente (Id_eveniment, Descriere_veche)
        VALUES (:OLD.Id_eveniment, :OLD.Descriere);
    END IF;
END;
/
