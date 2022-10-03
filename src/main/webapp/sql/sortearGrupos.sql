USE campeonato;

------------–––––------------–––––------------–––––------------–––––------------–––––------------–––––
-- PROCEDURE PARA SORTEAR OS GRUPOS 
-- SAO PAULO, CORINTHIANS, PALMEIRAS E SANTOS NUNCA FICAM NO MESMO GRUPO;
CREATE PROCEDURE sortearGrupos
AS
BEGIN
	DELETE grupos;

	----INSERINDO OS PRIMEIROS TIMES
	INSERT INTO grupos (codigoGrupo, codigoTime)
	SELECT sigla, codigoTime  FROM
		(
			SELECT ROW_NUMBER() OVER (ORDER BY NEWID()) AS cont, codigoTime, nome FROM times
			WHERE codigoTime NOT IN (16, 10, 13, 3)
		) tbl1 
		INNER JOIN	
		(
			SELECT ROW_NUMBER() OVER (ORDER BY sigla) AS cont, sigla 
			FROM (SELECT sigla FROM grupo union all SELECT sigla FROM grupo union all SELECT sigla FROM grupo) AS aux
		) AS tbl2
	ON tbl1.cont = tbl2.cont;
	
	----INSERINDO OS TIMES COM ID 1, 2, 3, 4
	INSERT INTO grupos (codigoGrupo, codigoTime)
	SELECT sigla, codigoTime FROM
		(
			SELECT ROW_NUMBER() OVER (ORDER BY NEWID()) AS cont, codigoTime, nome FROM times
			WHERE codigoTime IN (16, 10, 13, 3)
		) tbl1 
		INNER JOIN	
		(
			SELECT ROW_NUMBER() OVER (ORDER BY sigla) AS cont, sigla FROM grupo
		) AS tbl2
	ON tbl1.cont = tbl2.cont;

	SELECT * FROM vw_time_grupo;

END

EXEC sortearGrupos;


------------–––––------------–––––------------–––––------------–––––------------–––––------------–––––
-- VIEW DOS TIMES COM O SEU GRUPO
CREATE VIEW vw_time_grupo
AS
	SELECT t.nome, g.sigla FROM times t, grupo g, grupos gp
	WHERE t.codigoTime = gp.codigoTime 
	AND g.sigla = gp.codigoGrupo 

SELECT * FROM vw_time_grupo order by sigla;


------------–––––------------–––––------------–––––------------–––––------------–––––------------–––––
-- VIEW PARA SORTEAR TODOS OS JOGOS POSSIVEIS
-- 96 JOGOS ONDE
-- 1) TIMES DO MESMO GRUPO NÃO SE ENFRENTAM
-- 2) O MESMO JOGO NÃO ACONTECE DUAS VEZES

DROP VIEW todosOsJogosPossiveis;

CREATE VIEW todosOsJogosPossiveis 
AS

WITH timesGrupos AS
(
		SELECT  t2.nome, t2.codigoTime, g2.codigoGrupo FROM times t2 
		INNER JOIN grupos g2
		ON t2.codigoTime = g2.codigoTime	
)
SELECT tg1.codigoTime as codigoCasa, tg1.nome as timeCasa, tg1.codigoGrupo as grupoCasa, 
		tg2.codigoTime as codigoFora, tg2.nome as timeFora, tg2.codigoGrupo as grupoFora
	FROM timesGrupos tg1 
	INNER JOIN timesGrupos tg2
	ON tg1.codigoTime <> tg2.codigoTime 
	AND tg1.codigoGrupo <> tg2.codigoGrupo
	AND tg1.codigoTime < tg2.codigoTime;

SELECT * FROM todosOsJogosPossiveis tojp;


------------–––––------------–––––------------–––––------------–––––------------–––––------------–––––
-- PROCEDURE PARA GERAR A DATA DA PROXIMA QUARTA FEIRA OU DOMINGO
DROP PROCEDURE gerarDataValida 

CREATE PROCEDURE gerarDataValida
	@data AS DATE,
	@saida DATE OUTPUT,
	@info AS VARCHAR(MAX) = NULL OUTPUT
AS
BEGIN
	DECLARE @diaDaSemana INT,
			@novaData DATE,
			@nomeDoDia VARCHAR(100);
		
	SET @novaData = @data;
	SET @diaDaSemana = DATEPART(weekday, @novaData);

	WHILE 1=1
		BEGIN
			IF @diaDaSemana = 1
				BEGIN 
					SET @nomeDoDia = 'DOMINGO';
					BREAK;
				END
			ELSE IF @diaDaSemana = 4
				BEGIN 
					SET @nomeDoDia = 'QUARTA FEIRA';
					BREAK;
				END
			ELSE	
				BEGIN		
					SET @novaData = DATEADD(DAY, 1, @novaData);
					SET @diaDaSemana = DATEPART(weekday, @novaData);
				END
		END
	SET @saida = @novaData;
	SET @info = @nomeDoDia; 
END
