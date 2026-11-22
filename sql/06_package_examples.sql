-- Examples from the original project document. Run after installing the packages.
-- The first block updates event 2. Run examples individually.

BEGIN
    pck_evenimente.actualizeaza_descriere(2, 'Actualizat: petrecere de 1 mai');
    DBMS_OUTPUT.PUT_LINE('Este un eveniment viitor?' || pck_evenimente.eveniment_este_viitor(2));
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('Număr total de evenimente: ' || pck_analiza_evenimente.numar_evenimente_totale);
    DBMS_OUTPUT.PUT_LINE('Utilizator cu cele mai multe evenimente: ' || pck_analiza_evenimente.utilizator_cu_cele_mai_multe_evenimente);
    DBMS_OUTPUT.PUT_LINE('Există evenimente pe 20 mai 2025? ' || pck_analiza_evenimente.exista_evenimente_pe_zi(TO_DATE('2025-05-20', 'YYYY-MM-DD')));
    pck_analiza_evenimente.afiseaza_evenimente_utilizator(1);
END;
/

