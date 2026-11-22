SET SERVEROUTPUT ON;
SELECT * FROM Utilizatori ORDER BY Id_utilizator;
SELECT * FROM Evenimente ORDER BY Id_eveniment;
SELECT * FROM Tipuri_evenimente ORDER BY Id_tip_eveniment;
SELECT * FROM Legatura_evenimente_tip ORDER BY Id_eveniment;

BEGIN
    DBMS_OUTPUT.PUT_LINE('Total evenimente: ' || pck_analiza_evenimente.numar_evenimente_totale);
    DBMS_OUTPUT.PUT_LINE('Evenimente utilizator 1: ' || pck_utilizatori.nr_evenimente_utilizator(1));
    DBMS_OUTPUT.PUT_LINE('Exista evenimente la 01.05.2027? ' ||
       pck_analiza_evenimente.exista_evenimente_pe_zi(DATE '2027-05-01'));
    pck_analiza_evenimente.afiseaza_evenimente_utilizator(1);
END;
/
