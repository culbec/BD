CREATE DATABASE OrganizatorEvenimente;
go
use OrganizatorEvenimente;
go

CREATE TABLE Evenimente
(
	Eid INT PRIMARY KEY IDENTITY,
	Nume VARCHAR(100) not NULL,
	DataEv DATETIME,
	NrParticipanti INT not NULL,
)

CREATE TABLE Contabil
(
	Cid INT PRIMARY KEY IDENTITY,
	Eid INT FOREIGN KEY REFERENCES Evenimente(Eid),
	Nume VARCHAR(50),
	Prenume VARCHAR(50),
	SumaPlata INT CHECK(SumaPlata >= 0)
)

CREATE TABLE Inventar
(
	Iid INT PRIMARY KEY IDENTITY,
	Eid INT FOREIGN KEY REFERENCES Evenimente(Eid),
	Produs VARCHAR(50) not NULL,
	Cantitate INT CHECK (Cantitate > 0),
)

CREATE TABLE Angajati
(
	Aid INT PRIMARY KEY IDENTITY,
	CNP CHAR(13) not NULL,
	Nume VARCHAR(50) not NULL,
	Prenume VARCHAR(50) not NULL,
	Salariu INT CHECK (Salariu > 2000),
	DataAngajare DATE
)

CREATE TABLE Furnizori
(
	Fid INT PRIMARY KEY IDENTITY,
	Nume VARCHAR(100) not NULL,
	Specializare VARCHAR(50) not NULL,
)

CREATE TABLE Vehicule
(
	Vid INT PRIMARY KEY IDENTITY,
	NrInmatriculare VARCHAR(7) CHECK (LEN(NrInmatriculare) = 7 OR LEN(NrInmatriculare) = 6) not NULL,
	Capacitate INT CHECK (Capacitate > 0) not NULL,
	Culoare VARCHAR(10),
	NrLocuri INT CHECK (NrLocuri >= 2 AND NrLocuri <= 10),
	Combustibil VARCHAR(20) CHECK(Combustibil = 'Benzina' OR Combustibil = 'Diesel' OR Combustibil = 'Electric' OR Combustibil = 'Hibrid Benzina' OR Combustibil = 'Hibrid Diesel')
)

CREATE TABLE Participanti
(
	Pid INT PRIMARY KEY IDENTITY,
	Nume VARCHAR(50) not NULL,
	Prenume VARCHAR(50) not NULL,
	NrTelefon CHAR(10),
	Email VARCHAR(50),
)

CREATE TABLE EvidentaAngajati
(
	Eid INT FOREIGN KEY REFERENCES Evenimente(Eid),
	Aid INT FOREIGN KEY REFERENCES Angajati(Aid),
	CONSTRAINT pkEvenimenteAngajati PRIMARY KEY (Eid, Aid),
)

CREATE TABLE EvidentaFurnizori
(
	Eid INT FOREIGN KEY REFERENCES Evenimente(Eid),
	Fid INT FOREIGN KEY REFERENCES Furnizori(Fid),
	CONSTRAINT pkEvenimenteFurnizori PRIMARY KEY (Eid, Fid)
)

CREATE TABLE EvidentaParticipanti
(
	Eid INT FOREIGN KEY REFERENCES Evenimente(Eid),
	Pid INT FOREIGN KEY REFERENCES Participanti(Pid),
	CONSTRAINT pkEvenimenteParticipanti PRIMARY KEY (Eid, Pid)
)

CREATE TABLE EvidentaVehicule
(
	Vid INT FOREIGN KEY REFERENCES Vehicule(Vid),
	Fid INT FOREIGN KEY REFERENCES Furnizori(Fid),
	CONSTRAINT pk_EvidentaVehicule PRIMARY KEY(Vid, Fid)

)

create table Versiuni
(
	Vid int primary key not null,
	Operatie nvarchar(50) not null,
	UndoOperatie nvarchar(50) not null
)

insert into Versiuni(Vid, Operatie, UndoOperatie) values(0, '', '');
insert into Versiuni(Vid, Operatie, UndoOperatie) values(1, 'modifyColumn', 'undoModifyColumn');
insert into Versiuni(Vid, Operatie, UndoOperatie) values(2, 'defaultConstraint', 'undoDefaultConstraint');
insert into Versiuni(Vid, Operatie, UndoOperatie) values(3, 'createTable', 'undoCreateTable');
insert into Versiuni(Vid, Operatie, UndoOperatie) values(4, 'addField', 'undoAddField');
insert into Versiuni(Vid, Operatie, UndoOperatie) values(5, 'addFK', 'undoAddFK');

create table VersiuneCurenta
(
	CurrV int primary key not null
)

insert into VersiuneCurenta(CurrV) values(0);
