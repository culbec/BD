use OrganizatorEvenimente;
go

-- ignorare randuri afectate
set nocount on;
go

-- voi folosi tabelele: Angajati - EvidentaAngajati - Evenimente

-- functii de validare pentru parametrii din tabelele utilizate

create or alter function validareCNP(@cnp char(13))
returns varchar(100) as
begin
	-- verificare ca cnp-ul sa fie un array de chars
	if not (SQL_VARIANT_PROPERTY(@cnp, 'BaseType') = 'char')
	begin
		return 'CNP-ul primit nu este valid!';
	end

	-- verificare daca parametrul primit este chiar un char(13)
	if DATALENGTH(@cnp) <> 13
	begin
		return 'CNP-ul primit nu are lungimea corespunzatoare!';
	end

	-- verificare corectitudine CNP
	declare @i int = 1;

	-- cnp-ul sa contina doar cifre
	while @i <= 13
	begin
		if SUBSTRING(@cnp, @i, 1) not in('0', '1', '2', '3', '4', '5', '6', '7', '8', '9')
		begin
			return 'CNP-ul primit nu contine numai cifre!';
		end

		set @i = @i + 1;
	end

	declare @gen char = SUBSTRING(@cnp, 1, 1)
	declare @luna char(2) = SUBSTRING(@cnp, 4, 2)
	declare @zi char(2) = SUBSTRING(@cnp, 6, 2)

	-- verificare ca prima cifra din cnp sa fie 1, 2, 5 sau 6
	if @gen not in('1', '2', '5', '6')
	begin
		return 'CNP-ul primit nu are identificatorul de gen valid!';
	end

	-- verificare luna si zi de nastere
	if @luna not in('01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12')
	begin
		return 'CNP-ul primit nu are luna valida!';
	end

	if @zi < '01' or @zi > '31'
	begin
		return 'CNP-ul primit nu are ziua valida!';
	end

	return null;
end
go

create or alter function validareNumePrenume(@nume varchar(50))
returns varchar(100) as
begin
	-- verificare ca numele sa fie un varchar
	if not (SQL_VARIANT_PROPERTY(@nume, 'BaseType') = 'varchar')
	begin
		return 'Parametrul primit nu este un text!';
	end

	-- verificare lungime nume/prenume
	if DATALENGTH(@nume) < 3 or DATALENGTH(@nume) > 50
	begin
		return 'Lungimea parametrului este invalida!';
	end

	-- verificare ca numele/prenumele sa inceapa cu litera mare
	if SUBSTRING(@nume, 1, 1) < 'A' or SUBSTRING(@nume, 1, 1) > 'Z'
	begin
		return 'Parametrul text nu incepe cu litera mare!';
	end
	
	return null;
end
go

create or alter function validareSalariu(@salariu bigint)
returns varchar(100) as
begin
	-- verificare ca salariul sa numar
	if ISNUMERIC(@salariu) = 0
	begin
		return 'Parametrul primit nu este numeric!';
	end

	-- verificare ca salariul sa fie >= 100
	if @salariu < 100
	begin
		return 'Salariu neconform!';
	end

	return null;
end
go

create or alter function validareNumeEveniment(@numeEv varchar(100))
returns varchar(100) as
begin
	-- verificare ca numele evenimentului sa fie un varchar
	if not (SQL_VARIANT_PROPERTY(@numeEv, 'BaseType') = 'varchar')
	begin
		return 'Numele evenimentului nu este un text!';
	end

	-- verificare ca lungimea numelui sa fie intre 4 si 100
	if DATALENGTH(@numeEv) < 4 OR DATALENGTH(@numeEv) > 100
	begin
		return 'Lungimea numelui evenimentului este invalida!';
	end

	return null;
end
go

create or alter function validareNrParticipanti(@nrPart int)
returns varchar(100) as
begin
	-- verificare daca parametrul primit este numeric
	if ISNUMERIC(@nrPart) = 0
	begin
		return 'Parametrul primit nu este numeric!';
	end

	-- verificare ca nr. de participanti sa fie mai mare de 5
	if @nrPart < 5
	begin
		return 'Numar de participanti prea mic!';
	end

	return null;
end
go

-- functie pentru verificarea faptului ca FK-urile primite pentru inserarea in evidenta chiar exista
create or alter function validareFK(@fkEveniment int, @fkAngajat int)
returns varchar(100) as
begin
	-- verificare ca cele 2 fk-uri sa fie numerice
	if ISNUMERIC(@fkAngajat) = 0 or ISNUMERIC(@fkAngajat) = 0
	begin
		return 'Parametrii primiti nu sunt numerici!';
	end

	-- verificare ca cele 2 fk-uri sa existe in tabelele lor
	if not exists (select Angajati.Aid from Angajati where Angajati.Aid = @fkAngajat)
	begin
		return 'FK-ul pentru Angajat nu exista!';
	end

	if not exists (select Evenimente.Eid from Evenimente where Evenimente.Eid = @fkEveniment)
	begin
		return 'FK-ul pentru Eveniment nu exista!';
	end
	
	return null;
end
go

create or alter procedure CRUDAngajat(@cnp char(13), @nume varchar(50), @prenume varchar(50), @salariu bigint, @dataAngajare date)
as
begin
	-- validare parametrii angajat
	declare @mesajValidareCNP varchar(100);
	declare @mesajValidareNume varchar(100);
	declare @mesajValidarePrenume varchar(100);
	declare @mesajValidareSalariu varchar(100);

	exec @mesajValidareCNP = validareCNP @cnp;
	if not @mesajValidareCNP is NULL
	begin
		print @mesajValidareCNP
		return
	end

	exec @mesajValidareNume = validareNumePrenume @nume;
	if not @mesajValidareNume is NULL
	begin
		print @mesajValidareNume
		return
	end

	exec @mesajValidarePrenume = validareNumePrenume @prenume;
	if not @mesajValidarePrenume is NULL
	begin
		print @mesajValidarePrenume
		return
	end

	exec @mesajValidareSalariu = validareSalariu @salariu;
	if not @mesajValidareSalariu is NULL
	begin
		print @mesajValidareSalariu
		return
	end

	-- inserare angajat daca parametrii sunt valizi (CREATE)
	insert into Angajati values(@cnp, @nume, @prenume, @salariu, @dataAngajare)

	-- salvam id-ul angajatului
	declare @aid int = (select Max(Angajati.Aid) from Angajati);
	
	-- afisare angajat introdus (READ)
	select * from Angajati where Angajati.Aid = @aid;

	-- modificare angajat (UPDATE)
	update Angajati
	set Angajati.Nume = 'NumeModificat', Angajati.Prenume = 'PrenumeModificat'
	where Angajati.Aid = @aid;

	select * from Angajati where Angajati.Aid = @aid;

	-- stergere angajat (DELETE)
	delete from Angajati
	where Angajati.Aid = @aid;

	select * from Angajati where Angajati.Aid = @aid;

	-- mesaj terminal
	print('Operatii CRUD asupra tabelei Angajati finalizate cu succes!');
end
go

create or alter procedure CRUDEvenimente(@numeEv varchar(100), @dataEv date, @nrPart int)
as
begin
	-- validare parametrii eveniment
	declare @mesajValidareNumeEv varchar(100);
	declare @mesajValidareNrPart varchar(100);

	exec @mesajValidareNumeEv = validareNumeEveniment @numeEv;
	if not @mesajValidareNumeEv is NULL
	begin
		print @mesajValidareNumeEv
		return
	end

	exec @mesajValidareNrPart = validareNrParticipanti @nrPart;
	if not @mesajValidareNrPart is NULL
	begin
		print @mesajValidareNrPart
		return
	end


	-- inserare eveniment daca parametrii sunt valizi (CREATE)
	insert into Evenimente values(@numeEv, @dataEv, @nrPart)

	-- salvam id-ul evenimentului
	declare @eid int = (select Max(Evenimente.Eid) from Evenimente);
	
	-- afisare eveniment introdus (READ)
	select * from Evenimente where Evenimente.Eid = @eid;

	-- modificare eveniment (UPDATE)
	update Evenimente
	set Evenimente.Nume = 'NumeModificat'
	where Evenimente.Eid = @eid

	select * from Evenimente where Evenimente.Eid = @eid;

	-- stergere eveniment (DELETE)
	delete from Evenimente
	where Evenimente.Eid = @eid;

	select * from Evenimente where Evenimente.Eid = @eid;

	-- mesaj terminal
	print('Operatii CRUD asupra tabelei Evenimente finalizate cu succes!');
end
go

create or alter procedure CRUDEvidentaAngajati(@fkEveniment int, @fkAngajat int)
as
begin
	-- validare parametrii evidenta
	declare @mesajValidareFks varchar(100);

	exec @mesajValidareFks = validareFK @fkAngajat, @fkEveniment
	if @mesajValidareFks is not null
	begin
		print @mesajValidareFks
		return
	end;

	-- verificare daca inregistrarea deja exista
	if exists (select * from EvidentaAngajati EA where EA.Eid = @fkEveniment and EA.Aid = @fkAngajat)
	begin
		print 'Evidenta deja exista!'
		return
	end

	-- inserare evidenta daca parametrii sunt valizi (CREATE)
	insert into EvidentaAngajati values(@fkEveniment, @fkAngajat)
	
	-- afisare evidenta introdusa (READ)
	select * from EvidentaAngajati EA
	inner join Evenimente E on EA.Eid = E.Eid
	inner join Angajati A on EA.Eid = A.Aid
	where EA.Eid = @fkEveniment and EA.Aid = @fkAngajat;

	-- nu facem update, avand cele 2 fks ca fiind chei primare in tabela

	-- stergere evidenta (DELETE)
	delete from EvidentaAngajati
	where EvidentaAngajati.Eid = @fkEveniment and EvidentaAngajati.Aid = @fkAngajat;

	select * from EvidentaAngajati EA
	inner join Evenimente E on EA.Eid = E.Eid
	inner join Angajati A on EA.Eid = A.Aid
	where EA.Eid = @fkEveniment and EA.Aid = @fkAngajat;

	-- mesaj terminal
	print('Operatii CRUD asupra tabelei EvidentaAngajati finalizate cu succes!');
end
go

exec CRUDAngajat '5110219314531', 'Andrei', 'Marian', 2000, '2023-12-20';
exec CRUDEvenimente 'Jazz In The Park', '2023-10-20', 6;
exec CRUDEvidentaAngajati 1, 2;

select * from EvidentaAngajati;
select * from Angajati;
select * from Evenimente;
go

-- adaugare multe date pentru tabelele implicate

-- procedura de inserare Evenimente
create or alter procedure insert_Evenimente(@noRows int) as
begin
	declare @numeGeneral nvarchar(100) = N'Nume_Eveniment_Test_';
	declare @dataEv date = '2023-01-10';
	declare @nrPart int = 1000;

	declare @n int = 1;

	while @n <= @noRows
	begin
		declare @nume nvarchar(100) = @numeGeneral + convert(nvarchar(10), @n);
		insert into Evenimente values(@nume, @dataEv, @nrPart);

		set @n = @n + 1;
	end

	print 'Valori inserate in tabela evenimente: ' + convert(nvarchar(10), @noRows); 
end
go

-- procedura de stergere Evenimente
create or alter procedure delete_Evenimente as
begin
	delete from Evenimente where Evenimente.Nume like 'Nume_Eveniment_Test_%';

	print 'Valori sterse din Evenimente: ' + convert(nvarchar(10), @@ROWCOUNT);
end
go

create or alter procedure insertCRUDData(@noRows int) as
begin
	-- stergem valori din Angajati si Evenimente
	exec delete_Angajati;
	exec delete_Evenimente;

	-- inserare valori in cele doua tabele
	exec insert_Angajati @noRows;
	exec insert_Evenimente @noRows;

	-- inserare valori in evidenta
	declare @eid int = (select MAX(Evenimente.Eid) from Evenimente);
	declare @aid int = (select MAX(Angajati.Aid) from Angajati)
	declare @n int = 1;

	while @n <= @noRows
	begin
		insert into EvidentaAngajati values(@eid, @aid);
		
		set @n = @n + 1;
		set @eid = @eid - 1;
		set @aid = @aid - 1;
	end;

	print 'S-au inserat datele pentru testarea indecsilor!';
end
go

-- inseram multe date pentru a testa indecsii
exec insertCRUDData 1000000;
go

-- view-uri folosind indecsi

create or alter view singleView as
	select top 1000000 A.Aid, A.Nume as 'Nume_Angajat', A.Prenume as 'Prenume_Angajat' 
	from Angajati A
	order by A.Nume asc, A.Prenume desc;
go

create or alter view combinedView as
	select A.Nume, A.Prenume, A.DataAngajare,
		   E.Nume as 'Nume_Eveniment', E.NrParticipanti as 'Numar_Participanti', E.DataEv as 'Data_Eveniment'
	from Angajati A
	inner join EvidentaAngajati EA on A.Aid = EA.Aid
	inner join Evenimente E on EA.Eid = E.Eid
go

-- testare view-uri folosind o multitudine de indecsi non-clustered (pt. exercitiu)
create or alter procedure testSingleView as
begin
	-- rulare view doar prin index-ul clustered default
	select * from singleView;

	-- index pe nume Angajat
	create nonclustered index NIdx_Angajati_Nume on Angajati(Nume);
	select * from singleView;
	drop index NIdx_Angajati_Nume on Angajati;

	-- index pe id, nume Angajat ordonat dupa nume descrescator
	create nonclustered index NIdx_Angajati_Id_Nume on Angajati(Aid, Nume desc);
	select * from singleView;
	drop index NIdx_Angajati_Id_Nume on Angajati;

	-- index pe id, nume, prenume Angajat ordonat dupa nume crescator si prenume descrescator
	create nonclustered index NIdx_Angajati_Id_Nume_Prenume on Angajati(Aid, Nume asc, Prenume desc);
	select * from singleView;
	drop index NIdx_Angajati_Id_Nume_Prenume on Angajati;

	-- index pe id, nume, prenume Angajat ordonat by default (asc)
	create nonclustered index NIdx_Angajati_Id_Nume_Prenume_Default on Angajati(Aid, Nume, Prenume);
	select * from singleView;
	drop index NIdx_Angajati_Id_Nume_Prenume_Default on Angajati;
end
go

create or alter procedure testCombinedView as
begin
	drop index if exists NIdx_Angajati on Angajati;
	drop index if exists NIdx_Evenimente on Evenimente;
	drop index if exists NIdx_EvidentaAngajati on EvidentaAngajati;

	-- testare view fara indecsi
	select * from combinedView;

	create nonclustered index NIdx_Angajati on Angajati(Nume, Prenume, DataAngajare);
	create nonclustered index NIdx_Evenimente on Evenimente(Nume, NrParticipanti, DataEv);
	create nonclustered index NIdx_EvidentaAngajati on EvidentaAngajati(Eid, Aid);

	-- testare view cu indecsi
	
	select * from combinedView;
end
go

exec sp_executesql testSingleView;
exec sp_executesql testCombinedView;