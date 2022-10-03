USE campeonato;

------------–––––------------–––––------------–––––------------–––––------------–––––------------–––––
-----CHAMAR ESSA PROCEDURE
 --ENVIAR UMA DATA A PARTIR DESSA DATA ELA GERA AS 4 PROXIMAS RODADAS
 --GERA 4 JOGOS DE 4 RODADAS 
 --ENVIAR A SIGLA DOS GRUPOS DE FORMA QUE ELES FAÇAM UM CROSSJOIN
 --EX 
	-- PRIMEIRAS 4 RODADAS VEM DO (A - B) (C - D)
	--							  (A - C) (B - D)
	--							  (A - D) (B - C)


CREATE PROCEDURE gerarQuatroJogosDeQuatroRodadas
(
 	@grupo1  	VARCHAR(10),
 	@grupo2  	VARCHAR(10),
 	@data  		DATE,
 	@dataSaida  DATE OUTPUT
)
AS
BEGIN
	
	WITH timesGrupos AS
	(
			SELECT  t2.nome, t2.codigoTime, g2.codigoGrupo FROM times t2 
			INNER JOIN grupos g2
			ON t2.codigoTime = g2.codigoTime	
	)
	
	SELECT ROW_NUMBER() OVER (ORDER BY tg1.codigoGrupo) as codigo, tg1.codigoTime as codigoCasa, tg1.nome as timeCasa, tg1.codigoGrupo as grupoCasa, 
			tg2.codigoTime as codigoFora, tg2.nome as timeFora, tg2.codigoGrupo as grupoFora
			INTO #temporaria 
		FROM timesGrupos tg1 
		INNER JOIN timesGrupos tg2
		ON tg1.codigoTime <> tg2.codigoTime 
		AND tg1.codigoGrupo <> tg2.codigoGrupo
		AND tg1.codigoGrupo = @grupo1 AND tg2.codigoGrupo = @grupo2 
		
			
	DECLARE @rodada1 as date;
	EXEC gerarDataValida @data, @rodada1  output;

	INSERT INTO jogos(timeCasa, grupoCasa, golsCasa, timeFora, grupoFora, golsFora, data)
	SELECT codigoCasa, grupoCasa, ABS(CHECKSUM(NEWID()) % 5) AS golsCasa, codigoFora, grupoFora, ABS(CHECKSUM(NEWID()) % 5) AS golsFora, @rodada1 AS data FROM #temporaria 
	WHERE codigo IN (1, 8, 10, 15);

	DECLARE @rodada2 as date;
	SET @rodada1 = DATEADD(day, 1, @rodada1);
	EXEC gerarDataValida @rodada1, @rodada2 output;

	INSERT INTO jogos(timeCasa, grupoCasa, golsCasa, timeFora, grupoFora, golsFora, data)
	SELECT codigoCasa, grupoCasa, ABS(CHECKSUM(NEWID()) % 5) AS golsCasa, codigoFora, grupoFora, ABS(CHECKSUM(NEWID()) % 5) AS golsFora, @rodada2 AS data FROM #temporaria 
	WHERE codigo IN (2, 7, 9, 16);

	DECLARE @rodada3 as date;
	SET @rodada2 = DATEADD(day, 1, @rodada2);
	EXEC gerarDataValida @rodada2, @rodada3 output;

	INSERT INTO jogos(timeCasa, grupoCasa, golsCasa, timeFora, grupoFora, golsFora, data)
	SELECT codigoCasa, grupoCasa, ABS(CHECKSUM(NEWID()) % 5) AS golsCasa, codigoFora, grupoFora, ABS(CHECKSUM(NEWID()) % 5) AS golsFora, @rodada3 AS data FROM #temporaria 
	WHERE codigo IN (3, 6, 12, 13);

	DECLARE @rodada4 as date;
	SET @rodada3 = DATEADD(day, 1, @rodada3);
	EXEC gerarDataValida @rodada3, @rodada4 output;

	INSERT INTO jogos(timeCasa, grupoCasa, golsCasa, timeFora, grupoFora, golsFora, data)
	SELECT codigoCasa, grupoCasa, ABS(CHECKSUM(NEWID()) % 5) AS golsCasa, codigoFora, grupoFora, ABS(CHECKSUM(NEWID()) % 5) AS golsFora, @rodada4 AS data FROM #temporaria 
	WHERE codigo IN (4, 5, 11, 14);		

	SET @dataSaida = DATEADD(day, 1, @rodada4);
	DROP TABLE #temporaria;
END

------------–––––------------–––––------------–––––------------–––––------------–––––------------–––––
------ PROCEDURE PARA GERAR TODAS AS RODADAS

DROP PROCEDURE gerarRodadas;

CREATE PROCEDURE gerarRodadas AS
BEGIN 
	
	DELETE jogos;
	DBCC CHECKIDENT (jogos, RESEED, 0)

	DECLARE @data AS DATE; 
	SET @data = GETDATE();

	DECLARE @nextData AS DATE;
	EXEC gerarQuatroJogosDeQuatroRodadas 'A', 'B', @data, @nextData OUTPUT;
	EXEC gerarQuatroJogosDeQuatroRodadas 'C', 'D', @data, @nextData OUTPUT;

	
	DECLARE @nextData1 AS DATE;
	EXEC gerarQuatroJogosDeQuatroRodadas 'A', 'C', @nextData, @nextData1 OUTPUT;
	EXEC gerarQuatroJogosDeQuatroRodadas 'B', 'D', @nextData, @nextData1 OUTPUT;


	DECLARE @nextData2 AS DATE;
	EXEC gerarQuatroJogosDeQuatroRodadas 'A', 'D', @nextData1, @nextData2 OUTPUT;
	EXEC gerarQuatroJogosDeQuatroRodadas 'B', 'C', @nextData1, @nextData2 OUTPUT;

END

EXEC gerarRodadas;


--- VERIFICANDO AS DATAS 
SELECT data FROM jogos group by data;

-- VERIFICANDO AS RODADAS
select * from jogos e WHERE data = '2022-04-03';
select * from jogos e WHERE data = '2022-04-06';
select * from jogos e WHERE data = '2022-04-10';
select * from jogos e WHERE data = '2022-04-13';

select * from jogos e WHERE data = '2022-04-17';
select * from jogos e WHERE data = '2022-04-20';
select * from jogos e WHERE data = '2022-04-24';
select * from jogos e WHERE data = '2022-04-27';

select * from jogos e WHERE data = '2022-05-01';
select * from jogos e WHERE data = '2022-05-04';
select * from jogos e WHERE data = '2022-05-08';
select * from jogos e WHERE data = '2022-05-11';


select * from jogos;
