USE OrganizatorEvenimente;

-- Furnizorii ce au asociat un eveniment si au numele format din minim 4 caractere // INNER JOIN + WHERE + DISTINCT + RELATIE m-n + LIKE
SELECT DISTINCT F.Nume AS NumeFurnizor
FROM Furnizori F
INNER JOIN EvidentaFurnizori EF ON F.Fid=EF.Fid
INNER JOIN Evenimente E ON EF.Eid=E.Eid
WHERE F.NUME LIKE '____%';

-- Numarul de asocieri ale unui vehicul in cadrul evenimentelor // INNER JOIN + GROUP BY + RELATIE MAI MULT DE 3 TABELE
SELECT V.NrInmatriculare as NumarInmatriculare, COUNT(*) AS NumarAsocieri
FROM Vehicule V
INNER JOIN EvidentaVehicule EV ON V.Vid=EV.Vid
INNER JOIN Furnizori F ON EV.Fid=F.Fid
INNER JOIN EvidentaFurnizori EF ON F.Fid=EF.Fid
INNER JOIN Evenimente E ON EF.Eid=E.Eid
GROUP BY V.NrInmatriculare;

-- Participantii care participa la minim 2 evenimente si numele sa inceapa cu M // INNER JOIN + GROUP BY + HAVING + RELATIE m-n + LIKE
SELECT P.Nume, P.Prenume, COUNT(*) AS NumarEvenimente
FROM Participanti P
INNER JOIN EvidentaParticipanti EP ON P.Pid=EP.Pid
INNER JOIN Evenimente E ON EP.Eid=E.Eid
GROUP BY P.Nume, P.Prenume
HAVING COUNT(*) >= 2 AND P.Nume LIKE 'M%';

-- Angajatii asociati unui eveniment care au acelasi nume si prenume cu un participant // INNER JOIN + WHERE + RELATIE MAI MULT DE 3 TABELE
SELECT A.Nume as NumeAngajat, A.Prenume AS PrenumeAngajat, P.Nume AS NumeParticipant, P.Prenume as PrenumeParticipant
FROM Angajati A
INNER JOIN EvidentaAngajati EA ON A.Aid=EA.Aid
INNER JOIN Evenimente E ON EA.Eid=E.Eid
INNER JOIN EvidentaParticipanti EP ON E.Eid=EP.Eid
INNER JOIN Participanti P ON EP.Pid=P.Pid
WHERE A.Nume=P.Nume AND A.Prenume=P.Prenume;

-- Angajatii care au acelasi nume si prenume cu un contabil // INNER JOIN + WHERE + RELATIE MAI MULT DE 3 TABELE
SELECT A.Nume as NumeAngajat, A.Prenume AS PrenumeAngajat, C.Nume AS NumeContabil, C.Prenume as PrenumeContabil
FROM Angajati A
INNER JOIN EvidentaAngajati EA ON A.Aid=EA.Aid
INNER JOIN Evenimente E ON EA.Eid=E.Eid
INNER JOIN Contabil C ON E.Eid=C.Eid
WHERE A.Nume=C.Nume AND A.Prenume=C.Prenume;

-- Vehiculele cu combustibil Diesel care au mai mult de 3 inventare asociate
-- INNER JOIN + GROUP BY + HAVING + WHERE + RELATIE MAI MULTE TABELE
SELECT V.NrInmatriculare, COUNT(*) AS NumarInventareAsociate
FROM Vehicule V
INNER JOIN EvidentaVehicule EV ON V.Vid=EV.Vid
INNER JOIN Furnizori F ON EV.Fid=F.Fid
INNER JOIN EvidentaFurnizori EF ON F.Fid=EF.Fid
INNER JOIN Evenimente E ON EF.Eid=E.Eid
INNER JOIN Inventar I ON E.Eid=I.Eid
WHERE V.Combustibil='Diesel'
GROUP BY V.NrInmatriculare
HAVING COUNT(*) > 3;

-- Vehicule cu combustibil Benzina care au inventare asociate doar o singura data
-- INNER JOIN + DISTINCT + WHERE
SELECT DISTINCT V.NrInmatriculare
FROM Vehicule V
INNER JOIN EvidentaVehicule EV ON V.Vid=EV.Vid
INNER JOIN Furnizori F ON EV.Fid=F.Fid
INNER JOIN EvidentaFurnizori EF ON F.Fid=EF.Fid
INNER JOIN Evenimente E ON EF.Eid=E.Eid
INNER JOIN Inventar I ON E.Eid=I.Eid
WHERE V.Combustibil='Benzina';

-- Nume_Prenume Angajat + Nume Eveniment + Nume_Prenume Contabil pentru evenimente cu minim 50 de participanti
-- INNER JOIN + WHERE + MAI MULTE TABELE
SELECT A.Nume AS NumeAngajat, A.Prenume AS PrenumeAngajat, E.Nume AS NumeEveniment, C.Nume as NumeContabil, C.Prenume AS PrenumeContabil
FROM Angajati A
INNER JOIN EvidentaAngajati EA ON A.Aid=EA.Aid
INNER JOIN Evenimente E ON EA.Eid=E.Eid
INNER JOIN Contabil C ON E.Eid=C.Eid
WHERE E.NrParticipanti >= 50;

-- Numar_Inmatriculare Vehicul + Nume Furnizor + Produs Inventar pentru inventarele cu o capacitate > 50 + Cantitate Inventar
-- INNER JOIN + WHERE
SELECT V.NrInmatriculare, F.Nume, I.Produs, I.Cantitate
FROM Vehicule V
INNER JOIN EvidentaVehicule EV ON V.Vid=EV.Vid
INNER JOIN Furnizori F ON EV.Fid=F.Fid
INNER JOIN EvidentaFurnizori EF ON F.Fid=EF.Fid
INNER JOIN Evenimente E ON EF.Eid=E.Eid
INNER JOIN Inventar I ON E.Eid=I.Eid
WHERE F.Specializare=I.Produs AND I.Cantitate > 50;

-- Nume_Prenume Angajat al caror nume incepe cu litera M + Produs Inventar + Cantitate Inventar de gestionat
-- INNER JOIN + WHERE
SELECT A.Nume AS NumeAngajat, A.Prenume as PrenumeAngajat, I.Produs, I.Cantitate
FROM Angajati A
INNER JOIN EvidentaAngajati EA ON A.Aid=EA.Aid
INNER JOIN Evenimente E ON EA.Eid=E.Eid
INNER JOIN Inventar I ON E.Eid=I.Eid
WHERE A.Nume LIKE 'M%';