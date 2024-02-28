use OrganizatorEvenimente;
go

-- declaratie view-uri

-- select aplicat pe un tabel
-- informatii despre angajati
create view view_Angajati as
	select * from Angajati;
go

select * from view_Angajati;
go

-- select aplicat pe cel putin 2 tabele
-- contabil & eveniment asociat
create view view_Contabil as 
	select C.Nume as Nume_Contabil, C.Prenume as Prenume_Contabil, C.SumaPlata as Suma, E.Nume as Nume_Eveniment, E.DataEv, E.NrParticipanti
	from Contabil C
	inner join Evenimente E on C.Eid = E.Eid;
go

select * from view_Contabil;
go

-- select cu group by
-- numarul de participari ale unei persoane in cadrul evenimentelor
create view view_EvidentaParticipanti as
	select P.Nume as Nume_Participant, P.Prenume as Prenume_Participant, count(*) as Numar_Participari
	from Participanti P
	inner join EvidentaParticipanti Ep on P.Pid = Ep.Pid
	inner join Evenimente E on Ep.Eid = E.Eid
	group by P.Nume, P.Prenume
go

select * from view_EvidentaParticipanti;
go

-- create proceduri stocate pentru test

-- proceduri de inserare

-- procedura de inserare pentru angajati
create procedure insert_Angajati (@noRows int) as
begin
	-- field-uri pe care le vor avea fiecare angajat
	-- singurele field-uri 'unice' vor fi numele si prenumele angajatului
	declare @cnp char = '1112223334445';
	declare @numeGeneral nvarchar(50) = N'Nume_Angajat_Test_';
	declare @prenumeGeneral nvarchar(50) = N'Prenume_Angajat_Test_'
	declare @salariu bigint = 12345;
	declare @dataAngajare date = '2023-11-23'

	-- identificator unic pentru fiecare angajat (pe langa id-ul de tip identity)
	declare @lastIdentifier int = 1;

	-- inseram valori
	declare @n int = 1;

	while @n <= @noRows
	begin
		declare @nume nvarchar(50);
		declare @prenume nvarchar(50);

		-- setare nume&prenume angajati
		set @nume = @numeGeneral + convert(nvarchar(10), @lastIdentifier);
		set @prenume = @prenumeGeneral + convert(nvarchar(10), @lastIdentifier);

		-- inserare valori
		insert into Angajati(CNP, Nume, Prenume, Salariu, DataAngajare)
		values(@cnp, @nume, @prenume, @salariu, @dataAngajare);

		set @lastIdentifier = @lastIdentifier + 1;
		set @n = @n + 1;
	end;

	print N'S-au inserat ' + convert(nvarchar(10), @noRows) + N' valori in Angajati';
end;
go

-- procedura de inserare pentru contabil
create procedure insert_Contabil(@noRows int) as
begin
	-- field-uri pe care le va avea fiecare contabil
	-- singurele field-uri unice vor fi numele & prenumele
	declare @numeGeneral nvarchar(50) =  N'Nume_Contabil_Test_';
	declare @prenumeGeneral nvarchar(50) = N'Prenume_Contabil_Test_';
	declare @sumaPlata int = 1000;

	-- inseram si un dummy eveniment pentru testarea contabililor
	declare @numeDummyEveniment nvarchar(50) = N'Eveniment_Test_Contabil';
	declare @dataDummyEveniment date = '2023-10-20';
	declare @numarParticipantiDummyEveniment int = 1000;
	
	insert into Evenimente(Nume, DataEv, NrParticipanti)
	values(@numeDummyEveniment, @dataDummyEveniment, @numarParticipantiDummyEveniment);

	-- declarare identificator pentru contabili si id pentru dummy event
	declare @lastIdentifier int = 1;
	declare @idDummyEvent int = (select max(Evenimente.Eid) from Evenimente);
	
	-- inserare valori
	declare @n int = 1;
	
	while @n <= @noRows
	begin
		declare @nume nvarchar(50);
		declare @prenume nvarchar(50);

		set @nume = @numeGeneral + convert(nvarchar(10), @lastIdentifier);
		set @prenume = @prenumeGeneral + convert(nvarchar(10), @lastIdentifier);

		insert into Contabil(Eid, Nume, Prenume, SumaPlata)
		values(@idDummyEvent, @nume, @prenume, @sumaPlata);

		set @lastIdentifier = @lastIdentifier + 1;
		set @n = @n + 1;
	end;

	print N'S-au inserat ' + convert(nvarchar(10), @noRows) + N' valori in Contabil';
end;
go

-- procedura pentru inserare EvidentaParticipanti

create procedure insert_EvidentaParticipanti(@noRows int) as
begin
	-- vom crea doar participanti si un singur dummy event de care se vor folosi toti participantii

	-- field-uri pe care le va avea fiecare contabil
	-- singurele field-uri unice vor fi numele & prenumele
	declare @numeGeneral nvarchar(50) =  N'Nume_Participant_Test';
	declare @prenumeGeneral nvarchar(50) = N'Prenume_Participant_Test_';
	declare @numarTelefon char(10) = '0761002003';
	declare @email nvarchar(50) = 'participant.test@mail.com';

	-- inseram si un dummy eveniment pentru testarea evidentei participantilor
	declare @numeDummyEveniment nvarchar(50) = N'Eveniment_Test_Participanti';
	declare @dataDummyEveniment date = '2023-10-20';
	declare @numarParticipantiDummyEveniment int = 1000;
	
	insert into Evenimente(Nume, DataEv, NrParticipanti)
	values(@numeDummyEveniment, @dataDummyEveniment, @numarParticipantiDummyEveniment);

	-- declarare identificator pentru participanti si id pentru dummy event
	declare @lastIdentifier int = 1;
	declare @idDummyEvent int = (select max(Evenimente.Eid) from Evenimente);
	
	-- inserare valori
	declare @n int = 1;

	while @n <= @noRows
	begin
		declare @nume nvarchar(50);
		declare @prenume nvarchar(50);

		set @nume = @numeGeneral + convert(nvarchar(10), @lastIdentifier);
		set @prenume = @prenumeGeneral + convert(nvarchar(10), @lastIdentifier);

		insert into Participanti(Nume, Prenume, NrTelefon, Email) values(@nume, @prenume, @numarTelefon, @email);
		
		-- luam pid-ul utilizatorului nou
		-- folosim SCOPED_IDENTITY() pentru a lua identity-ul ultimului tabel in care s-a inserat in aceasta procedura stocata
		declare @pid int = SCOPE_IDENTITY();
		
		-- inseram valoarea noua
		insert into EvidentaParticipanti(Eid, Pid) values(@idDummyEvent, @pid);


		set @lastIdentifier = @lastIdentifier + 1;
		set @n = @n + 1;
	end;

	print N'S-au inserat ' + convert(nvarchar(10), @noRows) + N' valori in EvidentaParticipanti';

end;
go

-- proceduri de stergere

-- procedura de stergere angajati
create procedure delete_Angajati as
begin
	-- pentru numararea randurilor afectate
	set NOCOUNT on;

	-- stergem intrarile
	delete from Angajati
	where Angajati.Nume like 'Nume_Angajat_Test_%';

	print 'S-au sters ' + convert(nvarchar(10), @deletedRows) + ' valori din Angajati.';
end;
go

-- procedura de stergere contabili
create procedure delete_Contabil as
begin
	-- pentru nenumararea randurilor afectate
	set NOCOUNT on;

	-- stergem intrarile
	delete from Contabil
	where Contabil.Nume like 'Nume_Contabil_Test_%';

	declare @deletedRows int = @@ROWCOUNT;

	-- stergem dummy event-ul
	delete from Evenimente
	where Evenimente.Nume like 'Eveniment_Test_Contabil';

	print 'S-au sters ' + convert(nvarchar(10), @deletedRows) + ' valori din Contabil.';
end;
go

-- procedura de stergere evidenta participanti
create procedure delete_EvidentaParticipanti as
begin
	-- pentru nenumararea randurilor afectate
	set NOCOUNT on;

	-- stergem intrarile
	delete from Participanti
	where Participanti.Nume like 'Nume_Participant_Test_%';

	declare @deletedRows int = @@ROWCOUNT;

	-- stergem dummy event-ul
	delete from Evenimente
	where Evenimente.Nume like 'Eveniment_Test_Participanti';

	print 'S-au sters ' + convert(nvarchar(10), @deletedRows) + ' valori din EvidentaParticipanti.';
end;
go

-- procedura generala de inserare
create procedure insert_test(@idTest int) as
begin
	-- numele testului
	declare @numeTest nvarchar(50) = (select Tests.Name from Tests where Tests.TestID = @idTest);
	-- numele tabelei care va fi testata
	declare @numeTabela nvarchar(50);
	-- numarul de randuri afectate
	declare @noRows int;
	-- pozitia tabelului
	declare @position int;

	-- cursor pentru extragerea valorilor din tabelul TestTables in ordine crescatoare dupa position
	-- extragem numele tabelelor specificate in teste
	declare cursorTabela cursor forward_only for
		select Tables.Name, TestTables.NoOfRows from TestTables
		inner join Tables on TestTables.TableID = Tables.TableID
		where TestTables.TestID = @idTest
		order by TestTables.Position;
	-- deschidem cursorul
	open cursorTabela;

	-- extragem prima valoare din cursor
	fetch next from cursorTabela into @numeTabela, @noRows;
	-- rulam testele pe fiecare tabel
	while @@FETCH_STATUS = 0
	begin
		-- construim numele procedurii stocate care se ocupa de tabela cu numele = @numeTabela
		declare @procedura nvarchar(50) = (N'insert_' + @numeTabela);
		-- executam procedura cu numarul de randuri specificat
		exec @procedura @noRows;
		-- preluam urmatoarea valoare
		fetch next from cursorTabela into @numeTabela, @noRows;
	end;

	-- inchidem cursorul si il dealocam
	close cursorTabela;
	deallocate cursorTabela;
end;
go

-- procedura generala de stergere
create procedure delete_test(@idTest int) as
begin
	-- numele testului
	declare @numeTest nvarchar(50) = (select Tests.Name from Tests where Tests.TestID = @idTest);
	-- numele tabelei care va fi testata
	declare @numeTabela nvarchar(50);
	-- pozitia tabelului
	declare @position int;

	-- cursor pentru extragerea valorilor din tabelul TestTables in ordine crescatoare dupa position
	-- extragem numele tabelelor specificate in teste
	declare cursorTabela cursor forward_only for
		select Tables.Name from Tables
		inner join TestTables on Tables.TableID = TestTables.TableID
		where TestTables.TestID = @idTest
		order by TestTables.Position desc;
	-- deschidem cursorul
	open cursorTabela;

	-- extragem prima valoare din cursor
	fetch next from cursorTabela into @numeTabela;
	-- rulam testele pe fiecare tabel
	while @@FETCH_STATUS = 0
	begin
		-- construim numele procedurii stocate care se ocupa de tabela cu numele = @numeTabela
		declare @procedura nvarchar(50) = (N'delete_' + @numeTabela);
		-- executam procedura cu numarul de randuri specificat
		exec @procedura;
		-- preluam urmatoarea valoare
		fetch next from cursorTabela into @numeTabela;
	end;

	-- inchidem cursorul si il dealocam
	close cursorTabela;
	deallocate cursorTabela;
end;
go

-- procedura generala de evaluare view
create procedure view_test(@idTest int) as
begin
	-- extragem numele view-ului
	declare @viewName nvarchar(50) = (select Views.Name from Views
										inner join TestViews on Views.ViewID = TestViews.ViewID
										where TestViews.TestID = @idTest);
	-- declaram comanda de evaluare
	declare @evaluareView nvarchar(50) = (N'select * from ' + @viewName);

	-- evaluam view-ul
	exec sp_executesql @evaluareView;
end;
go

drop procedure run_test;
go

-- procedura efectiva de test
-- ordinea operatiilor: delete, insert, view
create procedure run_test(@idTest int) as
begin
	set nocount on;

	-- timpul de start, intermediar, sfarsit
	declare @startTime datetime;
	declare @middleTime datetime;
	declare @endTime datetime;

	-- initializem timpul de start
	set @startTime = getdate();

	-- stergem si inseram valori
	exec delete_test @idTest;
	exec insert_test @idTest;

	-- timpul de sfarsit ale acestor operatii
	set @middleTime = getdate();

	-- evaluam view-ul
	exec view_test @idTest;

	-- timpul de sfarsit al acestei operatii
	set @endTime = getdate();

	-- inseram valorile in tabelele de evaluare ale testelor
	declare @testName nvarchar(2000) = (select Tests.Name from Tests where Tests.TestID = @idTest);
	insert into TestRuns(Description, StartAt, EndAt) values(@testName, @startTime, @endTime);

	-- id-ul tabelului testat
	-- vom selecta id-ul tabelului care are numele continut in numele testului
	-- exemplu: Angajati -> test_Angajati_100 -> like %Angajati%
	declare @tableId int = (select Tables.TableID from Tables
							inner join TestTables on Tables.TableID = TestTables.TableID
							inner join Tests on TestTables.TestID = Tests.TestID
							where Tests.TestID = @idTest
								and @testName like ('%' + Tables.Name + '%'));

	-- Debug print statements
	print 'Test Name: ' + @testName;
	print 'Query Result: ' + cast(@tableId as nvarchar(255));

	-- id-ul view-ului evaluat
	declare @viewId int = (select Views.ViewID from Views
						   inner join TestViews on Views.ViewID = TestViews.ViewID
						   where TestViews.TestID = @idTest);
	-- id-ul testrun-ului cel mai recent evaluat
	declare @testrunId int = (select top 1 TestRuns.TestRunID from TestRuns
								where TestRuns.Description = @testName
								order by TestRunID desc);

	-- inserare valori in tabelele de test
	insert into TestRunTables(TestRunID, TableID, StartAt, EndAt) values(@testrunId, @tableId, @startTime, @middleTime);
	insert into TestRunViews(TestRunID, ViewID, StartAt, EndAt) values(@testrunId, @viewId, @middleTime, @endTime);

	print N'Test completat cu succes in: ' + convert(varchar(10), datediff(millisecond, @startTime, @endTime)) + N' ms.';
end;

-- populare tabele testate
insert into Tables(Name) values('Angajati');
insert into Tables(Name) values('Contabil');
insert into Tables(Name) values('EvidentaParticipanti');
go

-- populare views testate
insert into Views(Name) values('view_Angajati');
insert into Views(Name) values('view_Contabil');
insert into Views(Name) values('view_EvidentaParticipanti');
go

/*
	DBCC CHECKIDENT ('[Tests]', RESEED, 0);
	GO
*/

-- populare nume proceduri stocate pentru test
insert into Tests(Name) values('test_Angajati_100');
insert into Tests(Name) values('test_Contabil_100');
insert into Tests(Name) values('test_EvidentaParticipanti_100');
insert into Tests(Name) values('test_Angajati_1000');
insert into Tests(Name) values('test_Contabil_1000');
insert into Tests(Name) values('test_EvidentaParticipanti_1000');
insert into Tests(Name) values('test_Angajati_10000');
insert into Tests(Name) values('test_Contabil_10000');
insert into Tests(Name) values('test_EvidentaParticipanti_10000');
insert into Tests(Name) values('test_Angajati_100000');
insert into Tests(Name) values('test_Contabil_100000');
insert into Tests(Name) values('test_EvidentaParticipanti_100000');
insert into Tests(Name) values('test_Angajati_1000000');
insert into Tests(Name) values('test_Contabil_1000000');
insert into Tests(Name) values('test_EvidentaParticipanti_1000000');
go

-- populare TestViews
insert into TestViews(TestID, ViewID) values(1, 1);
insert into TestViews(TestID, ViewID) values(2, 2);
insert into TestViews(TestID, ViewID) values(3, 3);
insert into TestViews(TestID, ViewID) values(4, 1);
insert into TestViews(TestID, ViewID) values(5, 2);
insert into TestViews(TestID, ViewID) values(6, 3);
insert into TestViews(TestID, ViewID) values(7, 1);
insert into TestViews(TestID, ViewID) values(8, 2);
insert into TestViews(TestID, ViewID) values(9, 3);
insert into TestViews(TestID, ViewID) values(10, 1);
insert into TestViews(TestID, ViewID) values(11, 2);
insert into TestViews(TestID, ViewID) values(12, 3);
insert into TestViews(TestID, ViewID) values(13, 1);
insert into TestViews(TestID, ViewID) values(14, 2);
insert into TestViews(TestID, ViewID) values(15, 3);
go

-- populare TestTables
-- vom popula si cu valori care presupun teste combinate
-- adica: Table1 + Table2, Table1 + Table2 + Table3 etc.

-- Angajati 100
-- insert into TestTables(TestID, TableID, NoOfRows, Position) values(1, 1, 100, 1);
exec run_test 1;
go

-- Contabil 100
-- insert into TestTables(TestID, TableID, NoOfRows, Position) values(2, 2, 100, 2);
exec run_test 2;
go

-- Angajati + Contabil + EvidentaParticipanti 100
-- insert into TestTables(TestID, TableID, NoOfRows, Position) values(3, 1, 100, 1);
-- insert into TestTables(TestID, TableID, NoOfRows, Position) values(3, 2, 100, 2);
-- insert into TestTables(TestID, TableID, NoOfRows, Position) values(3, 3, 100, 3);
exec run_test 3;
go

-- Angajati + EvidentaParticipanti 1000
-- insert into TestTables(TestID, TableID, NoOfRows, Position) values(4, 1, 1000, 1);
-- insert into TestTables(TestID, TableID, NoOfRows, Position) values(4, 3, 1000, 3);
exec run_test 4;
go

-- Angajati + Contabil 1000
-- insert into TestTables(TestID, TableID, NoOfRows, Position) values(5, 1, 1000, 1);
-- insert into TestTables(TestID, TableID, NoOfRows, Position) values(5, 2, 1000, 2);
exec run_test 5;
go

-- Angajati + EvidentaParticipanti 1000
-- insert into TestTables(TestID, TableID, NoOfRows, Position) values(6, 1, 1000, 1);
-- insert into TestTables(TestID, TableID, NoOfRows, Position) values(6, 3, 1000, 3);
exec run_test 6;
go

-- Angajati + Contabil 10000
-- insert into TestTables(TestID, TableID, NoOfRows, Position) values(7, 1, 10000, 1);
-- insert into TestTables(TestID, TableID, NoOfRows, Position) values(7, 2, 10000, 2);
exec run_test 7;
go

-- Contabil 10000
-- insert into TestTables(TestID, TableID, NoOfRows, Position) values(8, 2, 10000, 2);
exec run_test 8;
go

-- Contabil + EvidentaParticipanti 10000
-- insert into TestTables(TestID, TableID, NoOfRows, Position) values(9, 2, 10000, 1);
-- insert into TestTables(TestID, TableID, NoOfRows, Position) values(9, 3, 10000, 2);
exec run_test 9;
go

-- Angajati 100000
-- insert into TestTables(TestID, TableID, NoOfRows, Position) values(10, 1, 10000, 1);
exec run_test 10;
go

-- Contabil + EvidentaParticipanti 100000
-- insert into TestTables(TestID, TableID, NoOfRows, Position) values(11, 2, 100000, 2);
-- insert into TestTables(TestID, TableID, NoOfRows, Position) values(11, 3, 100000, 3);
exec run_test 11;
go

-- EvidentaParticipanti 100000
-- insert into TestTables(TestID, TableID, NoOfRows, Position) values(12, 3, 100000, 3);
exec run_test 12;
go

-- Angajati 1000000
-- insert into TestTables(TestID, TableID, NoOfRows, Position) values(13, 1, 1000000, 1);
exec run_test 13;
go

-- Contabil + EvidentaParticipanti 1000000
-- insert into TestTables(TestID, TableID, NoOfRows, Position) values(14, 2, 1000000, 2);
-- insert into TestTables(TestID, TableID, NoOfRows, Position) values(14, 3, 1000000, 3);
exec run_test 14;
go

-- Angajati + Contabil + EvidentaParticipanti 1000000
-- insert into TestTables(TestID, TableID, NoOfRows, Position) values(15, 1, 1000000, 1);
-- insert into TestTables(TestID, TableID, NoOfRows, Position) values(15, 2, 1000000, 2);
-- insert into TestTables(TestID, TableID, NoOfRows, Position) values(15, 3, 1000000, 3);
exec run_test 15;
go

select * from TestRuns;
select * from TestRunTables;
select * from TestRunViews;
go