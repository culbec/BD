create database VideoGames;
go

use VideoGames;
go

create table TipJoc(
	TJid int primary key identity,
	Denumire nvarchar(100) not null,
	Prezentare nvarchar(200)
);

create table Joc(
	JocId int primary key identity,
	Denumire nvarchar(100) not null,
	Pret float,
	TJid int foreign key references TipJoc(TJid),
);

create table Premiu(
	Pid int primary key identity,
	Numar int check (Numar > 0),
	Castig bit,
	Valoare float,
	JocId int foreign key references Joc(JocId),
);

create table Jucator(
	JucatorId int primary key identity,
	Nume nvarchar(30) not null,
	Prenume nvarchar(30) not null,
	Gen nvarchar(20),
	Varsta int check (Varsta > 7)
);

create table JucatorTester(
	JucatorId int foreign key references Jucator(JucatorId),
	JocId int foreign key references Joc(JocId),
	GradImplicare nvarchar(20),
	DataFinalizare datetime,
	constraint pk_Jucator_Joc primary key (JucatorId, JocId)
);
go

create table JucatorPremiu(
	JucatorId int foreign key references Jucator(JucatorId),
	Pid int foreign key references Premiu(Pid),
	constraint pk_Jucator_Premiu primary key (JucatorId, Pid)
);
go

create or alter procedure addTester
			@JucatorId int,
			@JocId int,
			@GradImplicare nvarchar(20),
			@DataFinalizare datetime 
as
begin
	if exists (select 1 from JucatorTester where JucatorId = @JucatorId and JocId = @JocId)
	begin
		update JucatorTester
		set GradImplicare = @GradImplicare, DataFinalizare = @DataFinalizare
		where JucatorId = @JucatorId and JocId = @JocId
	end
	
	else
	begin
		insert into JucatorTester(JucatorId, JocId, GradImplicare, DataFinalizare) 
		values (@JucatorId, @JocId, @GradImplicare, @DataFinalizare);	
	end
end;
go

create view TestedByAllPlayers as
	select Joc.Denumire
	from Joc
	inner join JucatorTester JT on JT.JocId = Joc.JocId
	group by Joc.Denumire
	having count(distinct JT.JucatorId) = (select count(*) from Jucator);
go

-- inserare valori in tabele
insert into TipJoc(Denumire, Prezentare) values 
(N'Actiune', 'Joc de actiune.'), 
(N'Strategie', 'Joc de logica si gandire.'),
(N'Puzzle', 'Joc de logica, perfect pentru copii.'),
(N'Aventura', 'Joc pentru explorare.'),
(N'Indie', 'Joc pentru relaxare.');
select * from TipJoc;
go

insert into Joc(Denumire, Pret, TJid) values 
(N'God of War', 60.0, 1),
(N'Call of Duty', 40.5, 1),
(N'Hearts of Iron IV', 8.45, 2),
(N'Monopoly', 21.3, 5),
(N'Victoria 3', 10.0, 2),
(N'Minecraft', 20.0, 4),
(N'Uncharted 4', 35.23, 4);
select * from Joc
inner join TipJoc on Joc.TJid = TipJoc.TJid;
go

insert into Premiu(Numar, Castig, Valoare, JocId) values
(1, 1, 200, 1),
(2, 1, 100, 1),
(1, 1, 300, 2),
(1, 1, 1000, 4),
(2, 1, 500, 4),
(1, 1, 100, 5),
(2, 1, 80, 5),
(3, 1, 50, 5),
(4, 1, 20, 5);
select * from Premiu
inner join Joc on Joc.JocId = Premiu.JocId;
go

insert into Jucator(Nume, Prenume, Gen, Varsta) values
(N'Popescu', N'Ion', N'Masculin', 15),
(N'Andreescu', N'Maria', N'Feminin', 10),
(N'Ionescu', N'Marius', N'Masculin', 20),
(N'Marian', N'Andreea', N'Feminin', 25),
(N'John', N'Michael', N'Masculin', 31),
(N'Adams', N'Olive', N'Feminin', 28),
(N'Chiriac', N'Florin', N'Masculin', 35),
(N'Pop', N'Tudor', N'Masculin', 40),
(N'Popovici', N'Octavian', N'Masculin', 56),
(N'Popescu', N'Alexandra', N'Feminin', 18);
select * from Jucator;
go

insert into JucatorTester(JucatorId, JocId, GradImplicare, DataFinalizare) values
(1, 1, N'moderat', '2023-12-31'),
(2, 1, N'moderat', '2023-12-31'),
(3, 1, N'moderat', '2023-12-31'),
(4, 1, N'moderat', '2023-12-31'),
(5, 1, N'moderat', '2023-12-31'),
(6, 1, N'moderat', '2023-12-31'),
(7, 1, N'moderat', '2023-12-31'),
(8, 1, N'moderat', '2023-12-31'),
(9, 1, N'moderat', '2023-12-31'),
(10, 1, N'moderat', '2023-12-31'),
(1, 2, N'activ', '2024-01-04'),
(2, 2, N'activ', '2024-01-04'),
(3, 2, N'activ', '2024-01-04'),
(4, 2, N'activ', '2024-01-04'),
(5, 2, N'activ', '2024-01-04'),
(6, 2, N'activ', '2024-01-04'),
(7, 2, N'activ', '2024-01-04'),
(8, 2, N'activ', '2024-01-04'),
(9, 2, N'activ', '2024-01-04'),
(10, 2, N'activ', '2024-01-04'),
(3, 4, N'deloc', '2023-08-12'),
(5, 6, N'foarte activ', '2023-10-28');
select * from JucatorTester
inner join Jucator on JucatorTester.JucatorId = Jucator.JucatorId
inner join Joc on JucatorTester.JocId = Joc.JocId;
go

insert into JucatorPremiu(JucatorId, Pid) values
(1, 1),
(1, 2),
(2, 1),
(2, 2),
(3, 1);
select * from JucatorPremiu
inner join Jucator on Jucator.JucatorId = JucatorPremiu.JucatorId
inner join Premiu on Premiu.Pid = JucatorPremiu.Pid;
go

exec addTester 3, 1, N'ACTIV', '2023-04-10';
exec addTester 3, 5, N'activ', '2023-05-04';
select * from JucatorTester
inner join Jucator on JucatorTester.JucatorId = Jucator.JucatorId
inner join Joc on JucatorTester.JocId = Joc.JocId;
go

select * from TestedByAllPlayers;