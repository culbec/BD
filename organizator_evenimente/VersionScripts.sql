use OrganizatorEvenimente;
go

create procedure modifyColumn as
begin
	alter table Angajati
	drop constraint if exists CK__Salariu;

	alter table Angajati
	alter column Salariu bigint;

	alter table Angajati
	add constraint CK__Salariu check (Salariu >= 0);

	print N'Modified the type of the column "Salariu" from "Angajati" to BIGINT!';
end;
go

create procedure defaultConstraint as
begin
	alter table Evenimente
	add constraint df_nrParticipanti default 30 for NrParticipanti;
	
	print N'Added a default constraint for table "Evenimente"!';
end;
go

create procedure createTable as
begin
	create table Invitatii
	(
		InvId int primary key identity,
		Text nvarchar(100) not null
	)

	print N'Created table "Invitatii" successfully!';
end;
go

create procedure addField as
begin
	alter table Furnizori
	add Oras nvarchar(100);

	print N'Added the column "Oras" into "Furnizori"!';
end;
go

create procedure addFK as
begin
	alter table Invitatii
	add Pid int;

	alter table Invitatii
	add constraint fk_Invitatii foreign key (Pid) references Participanti(Pid)

	print N'Added a foreign key for table "Invitatii"!';
end;
go

create procedure undoModifyColumn as
begin

alter table Angajati
	drop constraint if exists CK__Salariu;

	alter table Angajati
	alter column Salariu int;

	alter table Angajati
	add constraint CK__Salariu check (Salariu >= 0);

	print N'Undid modification on "Salariu" field in table "Angajati"';
end;
go

create procedure undoDefaultConstraint as
begin
	alter table Evenimente
	drop constraint if exists df_nrParticipanti;

	print N'Undid creation of default constraint for table "Evenimente"!';
end;
go

create procedure undoCreateTable as
begin
	drop table if exists Invitatii;

	print N'Undid creation of table "Invitatii"!';
end;
go

create procedure undoAddField as
begin
	alter table Furnizori
	drop column if exists Oras;

	print N'Undid adding of the field "Oras" in table "Furnizori"!';
end;
go

create procedure undoAddFK as
begin
	alter table Invitatii
	drop constraint if exists fk_Invitatii;

	print N'Undid adding of the FK constraint for table "Invitatii"!';
end;
go

-- drop procedure updateVersion;

create procedure updateVersion(@version varchar(10)) as
begin
	declare @IsNumeric bit;
	declare @IsInteger bit;

	set @IsNumeric = ISNUMERIC(@version);
	set @IsInteger = case when @IsNumeric = 1 and charindex('.', @version) = 0 then 1 else 0 end;

	if @IsNumeric = 0 and @IsInteger = 0
	begin
		raiserror(N'Valoarea data trebuie sa fie un numar intreg',
					16, 1);
		return;
	end;

	if @IsNumeric = 1 and @IsInteger = 0
	begin
		raiserror(N'Valoarea data trebuie sa fie un numar intreg',
					16, 1);
		return;
	end;

	declare @maxV int;
	declare @minV int;

	set @maxV = (select MAX(Versiuni.Vid) from Versiuni);
	set @minV = (select MIN(Versiuni.Vid) from Versiuni);

	if @version > @maxV
	begin
		raiserror(N'Versiunea de upgrade %s nu poate fi mai mare decat versiunea maxima admisa %d!',
					12, 1, @version, @maxV);
		return;
	end;

	if @version < @minV
	begin
		raiserror(N'Versiunea de downgrade %s nu poate fi mai mica decat versiunea minima admisa %d!',
					12, 1, @version, @minV);
		return;
	end;

	declare @currentVersion int;
	set @currentVersion = (select VersiuneCurenta.CurrV from VersiuneCurenta);

	if @version = @currentVersion
	begin
		print N'Versiunea de modificat nu poate fii aceeasi cu versiunea curenta!';
		return;
	end;

	if @version > @currentVersion
	begin
		declare @cnt int;
		set @cnt = @currentVersion + 1;

		while @cnt <= @version
		begin
			declare @proc nvarchar(50);
			set @proc = (select	V.Operatie from Versiuni V where V.Vid = @cnt);
			exec sp_executesql @proc;

			set @cnt = @cnt + 1;
		end;

		print N'Upgraded!';
	end;
	
	else
	begin
		set @cnt = @currentVersion;

		declare @downgradeV int;
		set @downgradeV = @version + 1;

		while @cnt >= @downgradeV
		begin
			set @proc = (select V.UndoOperatie from Versiuni V where V.Vid = @cnt);
			exec sp_executesql @proc;

			set @cnt = @cnt - 1;
		end;
		print N'Downgraded!';
	end;

	update VersiuneCurenta
	set CurrV = @version;
end;
go

select * from VersiuneCurenta;
select * from Versiuni;

exec updateVersion 0;
exec updateVersion 1;
exec updateVersion 2;
exec updateVersion 3;
exec updateVersion 4;

exec updateVersion 5;

exec updateVersion 4;
exec updateVersion 3;
exec updateVersion 2;
exec updateVersion 1;
exec updateVersion 0;

exec updateVersion 4;
exec updateVersion 1;

exec updateVersion -1;
exec updateVersion 7;