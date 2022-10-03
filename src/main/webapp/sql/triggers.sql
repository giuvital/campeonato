USE campeonato;

SELECT * FROM exemplo e;
SELECT * FROM grupos;
SELECT * FROM times;
SELECT * FROM jogos;


// trigger que impede insert, update, delete nas tabelas de times e jogos

CREATE TRIGGER tg_prevent_times
ON times
AFTER INSERT, UPDATE, DELETE 
AS
BEGIN
	PRINT 'CAN NOT PERFORM THIS OPERATION';
	ROLLBACK;
END

CREATE TRIGGER tg_prevent_grupos
ON grupos
AFTER INSERT, UPDATE, DELETE 
AS
BEGIN
	PRINT 'CAN NOT PERFORM THIS OPERATION';
	ROLLBACK;
END

//trigger para impedir o insert e delete na tabela jogos

CREATE TRIGGER tg_prevent_jogos
ON jogos
AFTER INSERT, DELETE 
AS
BEGIN
	PRINT 'CAN NOT PERFORM THIS OPERATION';
	ROLLBACK;
END

insert into jogos(timeCasa, grupoCasa, golsCasa, timeFora, grupoFora, golsFora, data)
values
('Novorizontino',	'A',	4,	'Ituano',	'B',	4,	'2022-04-03')


