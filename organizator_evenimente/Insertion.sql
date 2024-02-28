USE OrganizatorEvenimente;

-- inserting values into the Evenimente table
INSERT INTO Evenimente(Nume, DataEv, NrParticipanti) VALUES ('Targ de cariere', '2023-10-28 10:00', 200);
INSERT INTO Evenimente(Nume, DataEv, NrParticipanti) VALUES ('Targ de cariere', '2023-10-30 16:00', 300);
INSERT INTO Evenimente(Nume, DataEv, NrParticipanti) VALUES ('Coding Contest',  '2023-11-05 16:00', 200);
INSERT INTO Evenimente(Nume, DataEv, NrParticipanti) VALUES ('Auto Show', '2023-11-30 15:00', 125);
INSERT INTO Evenimente(Nume, DataEv, NrParticipanti) VALUES ('Movie Night', '2023-11-16 19:30', 55);
INSERT INTO Evenimente(Nume, DataEv, NrParticipanti) VALUES ('Hackathon', '2023-12-30 14:00', 170);
INSERT INTO Evenimente(Nume, DataEv, NrParticipanti) VALUES ('Halloween Party', '2023-10-31 20:00', 160);
INSERT INTO Evenimente(Nume, DataEv, NrParticipanti) VALUES ('IT Webinar', '2023-10-30 16:00', 55);
INSERT INTO Evenimente(Nume, DataEv, NrParticipanti) VALUES ('TeamBuilding IT Company', '2023-12-20 15:00', 100);
INSERT INTO Evenimente(Nume, DataEv, NrParticipanti) VALUES ('Stand-Up', '2023-11-17 20:00', 100);

-- inserting values into the Contabil table
INSERT INTO Contabil(Eid, Nume, Prenume, SumaPlata) VALUES (1, 'Pop', 'Marian', 200000);
INSERT INTO Contabil(Eid, Nume, Prenume, SumaPlata) VALUES (1, 'Muresan', 'Florin', 10000);
INSERT INTO Contabil(Eid, Nume, Prenume, SumaPlata) VALUES (4, 'Ionescu', 'Marius', 20000);
INSERT INTO Contabil(Eid, Nume, Prenume, SumaPlata) VALUES (7, 'Pop', 'Maria', 30000);
INSERT INTO Contabil(Eid, Nume, Prenume, SumaPlata) VALUES (9, 'Popescu', 'Malina', 50000);

-- inserting values into the Inventar table
INSERT INTO Inventar(Eid, Produs, Cantitate) VALUES (1,		'Televizor',	20);
INSERT INTO Inventar(Eid, Produs, Cantitate) VALUES (1,		'Apa',			2000);
INSERT INTO Inventar(Eid, Produs, Cantitate) VALUES (2,		'Apa',			4000);
INSERT INTO Inventar(Eid, Produs, Cantitate) VALUES (3,		'Prelungitor',	50);
INSERT INTO Inventar(Eid, Produs, Cantitate) VALUES (3,		'Pizza',		500);
INSERT INTO Inventar(Eid, Produs, Cantitate) VALUES (5,		'Popcorn',		50);
INSERT INTO Inventar(Eid, Produs, Cantitate) VALUES (6,		'Prelungitor',	100);
INSERT INTO Inventar(Eid, Produs, Cantitate) VALUES (6,		'Mancare',		1000);
INSERT INTO Inventar(Eid, Produs, Cantitate) VALUES (7,		'Bere',			2000);
INSERT INTO Inventar(Eid, Produs, Cantitate) VALUES (7,		'Confetti',		20);
INSERT INTO Inventar(Eid, Produs, Cantitate) VALUES (8,		'Televizor',	3);
INSERT INTO Inventar(Eid, Produs, Cantitate) VALUES (9,		'Autobuz',		5);
INSERT INTO Inventar(Eid, Produs, Cantitate) VALUES (9,		'Alcool',		60);
INSERT INTO Inventar(Eid, Produs, Cantitate) VALUES (9,		'Snacks',		100);
INSERT INTO Inventar(Eid, Produs, Cantitate) VALUES (10,	'Snacks',		200);

-- inserting values into the Participanti table
INSERT INTO Participanti(Nume, Prenume, NrTelefon, Email) VALUES ('Marius',		'Costel',		'0773214543', 'marius.costel@mail.com');
INSERT INTO Participanti(Nume, Prenume, NrTelefon, Email) VALUES ('Marius',		'Florin',		'0733414893', 'marius.florin@mail.com');
INSERT INTO Participanti(Nume, Prenume, NrTelefon, Email) VALUES ('Marian',		'Popescu',		'0743214543', 'marian.popescu@mail.com');
INSERT INTO Participanti(Nume, Prenume, NrTelefon, Email) VALUES ('Mariana',	'Suciu',		'0721342313', 'mariana.suciu@mail.com');
INSERT INTO Participanti(Nume, Prenume, NrTelefon, Email) VALUES ('Andreea',	'Pop',			'0762231114', 'andreea.pop@mail.com');
INSERT INTO Participanti(Nume, Prenume, NrTelefon, Email) VALUES ('Camelia',	'Popa',			'0779000101', 'camelia.popa@mail.com');
INSERT INTO Participanti(Nume, Prenume, NrTelefon, Email) VALUES ('Sergiu',		'Suciu',		'0768813213', 'sergiu.suciu@mail.com');
INSERT INTO Participanti(Nume, Prenume, NrTelefon, Email) VALUES ('Flavia',		'Serban',		'0779319999', 'flavia.serban@mail.com');
INSERT INTO Participanti(Nume, Prenume, NrTelefon, Email) VALUES ('Serban',		'Pop',			'0731332333', 'serban.pop@mail.com');
INSERT INTO Participanti(Nume, Prenume, NrTelefon, Email) VALUES ('Andrei',		'Lobont',		'0769990000', 'andrei.lobont@mail.com');
INSERT INTO Participanti(Nume, Prenume, NrTelefon, Email) VALUES ('Elena',		'Ionescu',		'0731334413', 'elena.ionescu@mail.com');

-- linking events and participants
INSERT INTO EvidentaParticipanti(Eid, Pid) VALUES(1, 1);
INSERT INTO EvidentaParticipanti(Eid, Pid) VALUES(5, 1);
INSERT INTO EvidentaParticipanti(Eid, Pid) VALUES(5, 3);
INSERT INTO EvidentaParticipanti(Eid, Pid) VALUES(5, 4);
INSERT INTO EvidentaParticipanti(Eid, Pid) VALUES(3, 6);
INSERT INTO EvidentaParticipanti(Eid, Pid) VALUES(3, 8);
INSERT INTO EvidentaParticipanti(Eid, Pid) VALUES(3, 9);
INSERT INTO EvidentaParticipanti(Eid, Pid) VALUES(3, 4);
INSERT INTO EvidentaParticipanti(Eid, Pid) VALUES(7, 2);
INSERT INTO EvidentaParticipanti(Eid, Pid) VALUES(7, 8);

-- inserting values into Furnizori table
INSERT INTO Furnizori(Nume, Specializare) VALUES('Nutline', 'Snacks');
INSERT INTO Furnizori(Nume, Specializare) VALUES('Samsung', 'Tech');
INSERT INTO Furnizori(Nume, Specializare) VALUES('LG', 'Tech');
INSERT INTO Furnizori(Nume, Specializare) VALUES('Loto', 'Snacks');
INSERT INTO Furnizori(Nume, Specializare) VALUES('Lidl', 'Groceries');
INSERT INTO Furnizori(Nume, Specializare) VALUES('Captain Bean', 'Coffee');
INSERT INTO Furnizori(Nume, Specializare) VALUES('Dorna', 'Apa');
INSERT INTO Furnizori(Nume, Specializare) VALUES('Philips', 'Televizor');
INSERT INTO Furnizori(Nume, Specializare) VALUES('Becks', 'Bere');
INSERT INTO Furnizori(Nume, Specializare) VALUES('Lays', 'Snacks');
INSERT INTO Furnizori(Nume, Specializare) VALUES('Borsec', 'Apa');
INSERT INTO Furnizori(Nume, Specializare) VALUES('Chio', 'Popcorn');
INSERT INTO Furnizori(Nume, Specializare) VALUES('Party SRL', 'Confetti');
INSERT INTO Furnizori(Nume, Specializare) VALUES('Dell', 'Tech');
INSERT INTO Furnizori(Nume, Specializare) VALUES('Nei', 'Televizor');
INSERT INTO Furnizori(Nume, Specializare) VALUES('Sony', 'Audio');
INSERT INTO Furnizori(Nume, Specializare) VALUES('Black Guard', 'Securitate');
INSERT INTO Furnizori(Nume, Specializare) VALUES('Asus', 'Tech');
INSERT INTO Furnizori(Nume, Specializare) VALUES('Jacobs', 'Coffee');
INSERT INTO Furnizori(Nume, Specializare) VALUES('Taxi Cluj', 'Transport');

-- linking providers and events
INSERT INTO EvidentaFurnizori(Eid, Fid) VALUES(1, 8);
INSERT INTO EvidentaFurnizori(Eid, Fid) VALUES(1, 7);
INSERT INTO EvidentaFurnizori(Eid, Fid) VALUES(1, 11);
INSERT INTO EvidentaFurnizori(Eid, Fid) VALUES(7, 9);
INSERT INTO EvidentaFurnizori(Eid, Fid) VALUES(7, 13);
INSERT INTO EvidentaFurnizori(Eid, Fid) VALUES(9, 1);
INSERT INTO EvidentaFurnizori(Eid, Fid) VALUES(9, 2);
INSERT INTO EvidentaFurnizori(Eid, Fid) VALUES(10, 2);
INSERT INTO EvidentaFurnizori(Eid, Fid) VALUES(1, 6);
INSERT INTO EvidentaFurnizori(Eid, Fid) VALUES(4, 20);
INSERT INTO EvidentaFurnizori(Eid, Fid) VALUES(5, 4);

-- inserting values into Vehicule table
INSERT INTO Vehicule(NrInmatriculare, Capacitate, Culoare, NrLocuri, Combustibil) VALUES('CJ81TOP', 200, 'rosu', 4, 'Diesel');
INSERT INTO Vehicule(NrInmatriculare, Capacitate, Culoare, NrLocuri, Combustibil) VALUES('B100LOC', 800, 'galben', 8, 'Electric');
INSERT INTO Vehicule(NrInmatriculare, Capacitate, Culoare, NrLocuri, Combustibil) VALUES('BV98BOS', 183, 'verde', 4, 'Electric');
INSERT INTO Vehicule(NrInmatriculare, Capacitate, Culoare, NrLocuri, Combustibil) VALUES('SV11PIP', 68, 'negru', 2, 'Benzina');
INSERT INTO Vehicule(NrInmatriculare, Capacitate, Culoare, NrLocuri, Combustibil) VALUES('VS85PES', 267, 'gri', 4, 'Diesel');
INSERT INTO Vehicule(NrInmatriculare, Capacitate, Culoare, NrLocuri, Combustibil) VALUES('VS99PWP', 150, 'alb', 4, 'Hibrid Benzina');
INSERT INTO Vehicule(NrInmatriculare, Capacitate, Culoare, NrLocuri, Combustibil) VALUES('IS99LOL', 700, 'gri', 2, 'Diesel');
INSERT INTO Vehicule(NrInmatriculare, Capacitate, Culoare, NrLocuri, Combustibil) VALUES('AB27HUG', 780, 'alb', 3, 'Diesel');
INSERT INTO Vehicule(NrInmatriculare, Capacitate, Culoare, NrLocuri, Combustibil) VALUES('B99LLA', 341, 'violet', 4, 'Hibrid Diesel');
INSERT INTO Vehicule(NrInmatriculare, Capacitate, Culoare, NrLocuri, Combustibil) VALUES('NT99YTR', 75, 'albastru', 2, 'Hibrid Benzina');

-- linking vehicule and furnizori
INSERT INTO EvidentaVehicule(Vid, Fid) VALUES(1, 1);
INSERT INTO EvidentaVehicule(Vid, Fid) VALUES(1, 2);
INSERT INTO EvidentaVehicule(Vid, Fid) VALUES(1, 3);
INSERT INTO EvidentaVehicule(Vid, Fid) VALUES(2, 5);
INSERT INTO EvidentaVehicule(Vid, Fid) VALUES(3, 6);
INSERT INTO EvidentaVehicule(Vid, Fid) VALUES(7, 15);
INSERT INTO EvidentaVehicule(Vid, Fid) VALUES(5, 4);
INSERT INTO EvidentaVehicule(Vid, Fid) VALUES(2, 4);
INSERT INTO EvidentaVehicule(Vid, Fid) VALUES(3, 10);
INSERT INTO EvidentaVehicule(Vid, Fid) VALUES(7, 12);
INSERT INTO EvidentaVehicule(Vid, Fid) VALUES(5, 16);
INSERT INTO EvidentaVehicule(Vid, Fid) VALUES(3, 2);
INSERT INTO EvidentaVehicule(Vid, Fid) VALUES(4, 2);
INSERT INTO EvidentaVehicule(Vid, Fid) VALUES(1, 5);
INSERT INTO EvidentaVehicule(Vid, Fid) VALUES(6, 3);
INSERT INTO EvidentaVehicule(Vid, Fid) VALUES(9, 2);
INSERT INTO EvidentaVehicule(Vid, Fid) VALUES(5, 1);
INSERT INTO EvidentaVehicule(Vid, Fid) VALUES(4, 17);
INSERT INTO EvidentaVehicule(Vid, Fid) VALUES(7, 11);

-- inserting values into Angajati table
INSERT INTO Angajati(CNP, Nume, Prenume, Salariu, DataAngajare) VALUES ('5030131001333', 'Pop', 'Marian', 2400, '2020-04-19');
INSERT INTO Angajati(CNP, Nume, Prenume, Salariu, DataAngajare) VALUES ('6020420143155', 'Pop', 'Florin', 3500, '2021-05-21');
INSERT INTO Angajati(CNP, Nume, Prenume, Salariu, DataAngajare) VALUES ('5001114444156', 'Remus', 'Florin', 4000, '2022-02-27');
INSERT INTO Angajati(CNP, Nume, Prenume, Salariu, DataAngajare) VALUES ('1931226901436', 'Florentin', 'Marius', 5831, '2012-03-31');
INSERT INTO Angajati(CNP, Nume, Prenume, Salariu, DataAngajare) VALUES ('2880611738193', 'Popa', 'Florina', 7893, '2007-04-11');
INSERT INTO Angajati(CNP, Nume, Prenume, Salariu, DataAngajare) VALUES ('2950801040312', 'Popescu', 'Maria', 3914, '2008-08-31');
INSERT INTO Angajati(CNP, Nume, Prenume, Salariu, DataAngajare) VALUES ('2990103111333', 'Andrei', 'Paula', 4000, '2016-09-30');
INSERT INTO Angajati(CNP, Nume, Prenume, Salariu, DataAngajare) VALUES ('1991203935133', 'Popescu', 'Matei', 8391, '2019-04-27');
INSERT INTO Angajati(CNP, Nume, Prenume, Salariu, DataAngajare) VALUES ('5030128910455', 'Balint', 'Leopold', 8491, '2022-10-31');
INSERT INTO Angajati(CNP, Nume, Prenume, Salariu, DataAngajare) VALUES ('2911103913888', 'Ionescu', 'Luiza', 3951, '2023-10-21');
INSERT INTO Angajati(CNP, Nume, Prenume, Salariu, DataAngajare) VALUES ('1781212941555', 'Ionescu', 'Laurentiu', 4788, '2000-07-31');
INSERT INTO Angajati(CNP, Nume, Prenume, Salariu, DataAngajare) VALUES ('5030131999111', 'Mihaita', 'Irimia', 9131, '2023-01-31');
INSERT INTO Angajati(CNP, Nume, Prenume, Salariu, DataAngajare) VALUES ('1980305238513', 'Spiridon', 'Daniel', 4913, '2022-05-13');
INSERT INTO Angajati(CNP, Nume, Prenume, Salariu, DataAngajare) VALUES ('6000213951534', 'Spiridon', 'Maria', 5313, '2021-04-23');
INSERT INTO Angajati(CNP, Nume, Prenume, Salariu, DataAngajare) VALUES ('2930615851315', 'Marian', 'Luiza', 2095, '2022-12-10');
INSERT INTO Angajati(CNP, Nume, Prenume, Salariu, DataAngajare) VALUES ('1940512735666', 'Ioan', 'Vlad', 5413, '2015-10-22');
INSERT INTO Angajati(CNP, Nume, Prenume, Salariu, DataAngajare) VALUES ('2880313888131', 'Enescu', 'Mirabela', 4400, '2016-11-30');
INSERT INTO Angajati(CNP, Nume, Prenume, Salariu, DataAngajare) VALUES ('1750812949133', 'Ulian', 'Marius', 8141, '2009-10-31');
INSERT INTO Angajati(CNP, Nume, Prenume, Salariu, DataAngajare) VALUES ('5010101413333', 'Andrei', 'Catalin', 7344, '2022-10-31');
INSERT INTO Angajati(CNP, Nume, Prenume, Salariu, DataAngajare) VALUES ('2990718489312', 'Pop', 'Catalina', 3899, '2017-07-30');
INSERT INTO Angajati(CNP, Nume, Prenume, Salariu, DataAngajare) VALUES ('5010219841935', 'Marius',	'Costel', 3900, '2020-08-10');
INSERT INTO Angajati(CNP, Nume, Prenume, Salariu, DataAngajare) VALUES ('5010319845935', 'Marian',	'Popescu', 3900, '2021-08-10');
INSERT INTO Angajati(CNP, Nume, Prenume, Salariu, DataAngajare) VALUES ('6010319841935', 'Camelia',	'Popa', 4900, '2020-08-10');
INSERT INTO Angajati(CNP, Nume, Prenume, Salariu, DataAngajare) VALUES ('6010319845935', 'Flavia',	'Serban', 2900, '2020-08-19');
INSERT INTO Angajati(CNP, Nume, Prenume, Salariu, DataAngajare) VALUES ('1980319845935', 'Serban',	'Pop', 3900, '2021-10-10');
INSERT INTO Angajati(CNP, Nume, Prenume, Salariu, DataAngajare) VALUES ('1760812949133', 'Ionescu', 'Marius', 4141, '2007-10-31');

-- linking employees to events
INSERT INTO EvidentaAngajati(Eid, Aid) VALUES(1, 1);
INSERT INTO EvidentaAngajati(Eid, Aid) VALUES(2, 3);
INSERT INTO EvidentaAngajati(Eid, Aid) VALUES(1, 3);
INSERT INTO EvidentaAngajati(Eid, Aid) VALUES(1, 10);
INSERT INTO EvidentaAngajati(Eid, Aid) VALUES(8, 10);
INSERT INTO EvidentaAngajati(Eid, Aid) VALUES(3, 10);
INSERT INTO EvidentaAngajati(Eid, Aid) VALUES(2, 14);
INSERT INTO EvidentaAngajati(Eid, Aid) VALUES(5, 9);
INSERT INTO EvidentaAngajati(Eid, Aid) VALUES(3, 1);
INSERT INTO EvidentaAngajati(Eid, Aid) VALUES(10, 2);
INSERT INTO EvidentaAngajati(Eid, Aid) VALUES(10, 4);
INSERT INTO EvidentaAngajati(Eid, Aid) VALUES(2, 1);
INSERT INTO EvidentaAngajati(Eid, Aid) VALUES(5, 2);
INSERT INTO EvidentaAngajati(Eid, Aid) VALUES(6, 7);
INSERT INTO EvidentaAngajati(Eid, Aid) VALUES(6, 6);
INSERT INTO EvidentaAngajati(Eid, Aid) VALUES(1, 4);
INSERT INTO EvidentaAngajati(Eid, Aid) VALUES(1, 22);
INSERT INTO EvidentaAngajati(Eid, Aid) VALUES(3, 22);
INSERT INTO EvidentaAngajati(Eid, Aid) VALUES(3, 23);
INSERT INTO EvidentaAngajati(Eid, Aid) VALUES(3, 24);
INSERT INTO EvidentaAngajati(Eid, Aid) VALUES(3, 25);
INSERT INTO EvidentaAngajati(Eid, Aid) VALUES(5, 26);
INSERT INTO EvidentaAngajati(Eid, Aid) VALUES(4, 26);
INSERT INTO EvidentaAngajati(Eid, Aid) VALUES(4, 5);
INSERT INTO EvidentaAngajati(Eid, Aid) VALUES(4, 10);
INSERT INTO EvidentaAngajati(Eid, Aid) VALUES(5, 5);