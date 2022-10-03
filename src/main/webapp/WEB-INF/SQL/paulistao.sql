CREATE DATABASE av1
GO
USE av1
GO
CREATE TABLE times (
codigoTime			INT				NOT NULL,
nomeTime			VARCHAR(60)		NOT NULL,
cidade				VARCHAR(100)	NOT NULL,
estadio				VARCHAR(100)	NOT NULL,
PRIMARY KEY (codigoTime)
)
GO
CREATE TABLE grupos (
grupo				CHAR(1)			NOT NULL,
codigoTime			INT				NOT NULL,
--FOREIGN KEY (grupo) REFERENCES grupo(sigla),
FOREIGN KEY (codigoTime) REFERENCES times (codigoTime)
)
GO
CREATE TABLE  Jogos(
codigoTimeA             INT              NULL,
codigoTimeB             INT              NULL,
golsTimeA				INT              NULL,
golsTimeB				INT              NULL,
data                    DATE             NULL
--FOREIGN KEY (codigoTimeA) REFERENCES times(codigoTime),
--FOREIGN KEY (codigoTimeB) REFERENCES times(codigoTime)
)

INSERT INTO times VALUES 
(1,  'Botafogo-SP',			'Ribeirão Preto',		'Santa Cruz'),
(2,  'Corinthians',			'São Paulo',			'Neo Química Arena'),
(3,  'Ferroviária',			'Araraquara',			'Fonte Luminosa'),
(4,  'Guarani',				'Campinas',				'Brinco de Ouro'),
(5,  'Inter de Limeira',	'Limeira',				'Limeirão'),
(6,  'Ituano',				'Itu',					'Novelli Júnior'),
(7,  'Mirassol',			'Mirassol',				'José Maria de Campos Maia'),
(8,  'Novorizontino',		'Novo Horizonte', 		'Jorge Ismael de Biasi'),
(9,	 'Palmeiras',			'São Paulo',			'Allianz Parque'),
(10, 'Ponte Preta',			'Campinas',				'Moisés Lucarelli'),
(11, 'Red Bull Bragantino',	'Bragança Paulista',	'Nabi Abi Chedid'),
(12, 'Santo André',			'Santo André',			'Bruno José Daniel'),
(13, 'Santos',				'Santos',				'Vila Belmiro'),
(14, 'São Bento',			'Sorocaba',				'Walter Ribeiro'),
(15, 'São Caetano',			'São Caetano do Sul',	'Anacletto Campanella'),	
(16, 'São Paulo',			'São Paulo',			'Morumbi')

SELECT * FROM times
SELECT * FROM grupos

SELECT gp.grupo, gp.codigoTime, t.nomeTime
FROM grupos gp, times t 
WHERE gp.codigoTime = t.codigoTime
ORDER BY grupo

-- ==================================================================================================================

ALTER PROCEDURE sp_divGrp
AS
BEGIN
	
	DELETE FROM grupos

	DECLARE @query VARCHAR(MAX), 
			@qTimes INT, 
            @codigoTime INT,
			@vrfG INT, 
			@vrfT INT,
            @grupo CHAR(1), 
			@aleatorio INT
	SELECT @qTimes = COUNT(codigoTime) FROM grupos
	SET @query = 'INSERT INTO grupos VALUES (''A'', 2),(''B'', 9),(''C'', 13),(''D'', 16)'
	EXEC(@query)
    SET @codigoTime = 0
    WHILE @codigoTime < 16
    BEGIN
        SET @codigoTime += 1
        SELECT @vrfT = (SELECT codigoTime FROM grupos WHERE codigoTime = @codigoTime)
        IF (@vrfT IS NULL)
        BEGIN
            SET @aleatorio = RAND()*(4) + 1
            IF (@aleatorio = 1) 
				SET @grupo = 'A'
            ELSE IF (@aleatorio = 2) 
				SET @grupo = 'B'
            ELSE IF (@aleatorio = 3) 
				SET @grupo = 'C'
            ELSE IF (@aleatorio = 4) 
				SET @grupo = 'D'
            SELECT @vrfG = (SELECT COUNT(grupo) FROM Grupos WHERE grupo = @grupo)
            WHILE @vrfG > 3
            BEGIN
                SET @aleatorio = RAND()*(4) + 1
                IF (@aleatorio = 1) 
					SET @grupo = 'A'
                ELSE IF (@aleatorio = 2) 
					SET @grupo = 'B'
                ELSE IF (@aleatorio = 3)
					SET @grupo = 'C'
                ELSE IF (@aleatorio = 4) 
					SET @grupo = 'D'
                SELECT @vrfG = (SELECT COUNT(grupo) FROM Grupos WHERE grupo = @grupo)
            END
            SET @query = 'INSERT INTO grupos VALUES ('''+@grupo+''','+CAST(@codigoTime AS VARCHAR)+')'
            EXEC (@query)
        END
    END
END

EXEC sp_divGrp
SELECT gp.grupo, gp.codigoTime, t.nomeTime, t.cidade, t.estadio
FROM grupos gp, times t 
WHERE gp.codigoTime = t.codigoTime
ORDER BY grupo

SELECT gp.grupo, gp.codigoTime, t.nomeTime FROM grupos gp, times t
WHERE gp.codigoTime = t.codigoTime
AND gp.grupo = 'A'
-- ==============================================================================================================
CREATE ALTER PROCEDURE sp_criando_rodadas  --(@saida VARCHAR(MAX) OUTPUT)
AS
	DELETE FROM jogos
	--DBCC CHECKIDENT (jogos, reseed, 0)

	
	-- DECLARA VARIAVEIS 
	DECLARE @I AS INT,
			@DTJOGOTJOGO AS DATE,
			@A AS INT,
			@B AS INT,
			@F AS INT,
			@RA AS INT,
			@RB AS INT,
			@ID AS INT,
			@J AS INT,
			@FLAG AS INT,
			@DTJOGO AS DATE

	-- CRIA TABELAS TEMPORARIAS 

	CREATE TABLE #TODOS_JOGOS(
	ID INT,
	TIMEA INT,
	TIMEB INT)

	CREATE TABLE #REFERENCIAS(
	ID INT,
	R INT)

	CREATE TABLE #TODASDATAS(
	ID INT,
	DATA DATE UNIQUE)

	-- GERA TODAS AS DATAS
	SET @I = 0
	SET @DTJOGOTJOGO = '2021-02-28'

	WHILE(@I < 12)
	BEGIN

		IF (@I <> 0 AND @I % 2 <> 0)
		BEGIN 
			SET @DTJOGOTJOGO = (DATEADD(DAY, 3, @DTJOGOTJOGO))
		END
		IF (@I <> 0 AND @I % 2 = 0)
		BEGIN
			SET @DTJOGOTJOGO = (DATEADD(DAY, 4, @DTJOGOTJOGO))
		END
	
		INSERT INTO #TODASDATAS VALUES
		((@I + 1),(@DTJOGOTJOGO))

		SET @I = @I + 1
	END
	
	-- INSERE VALOR DE REFERENCIA
	INSERT INTO #REFERENCIAS VALUES
	(1,1), (2,5), (3,9), (4,13),
	(5,1), (6,9), (7,5), (8,13),
	(9,1), (10,13), (11,5), (12,9)

		-- GERA TODOS OS JOGOS
	DELETE FROM #TODOS_JOGOS
	
		
	SET @I = 1
	SET @ID = 1
	
	WHILE(@I < 12)
	BEGIN
	
		SET @RA = (SELECT R.R FROM #REFERENCIAS R WHERE R.ID = @I)
		SET @RB = (SELECT R.R FROM #REFERENCIAS R WHERE R.ID = @I + 1)
		SET @F = 1
		SET @A = @RA
		SET @B = @RB
	
		WHILE(@F < 17)
		BEGIN
	
	
			INSERT INTO #TODOS_JOGOS VALUES
			(@ID, @A, @B)
			SET @ID = @ID + 1
	
			IF(@B = (@RB + 3))
			BEGIN
				SET @B = @RB
			END
			ELSE
			BEGIN
				SET @B =  @B + 1
			END
	
	
			IF(@A = (@RA + 3))
			BEGIN
				SET @A =  @RA
				SET @B =  @B + 1
			END
			ELSE
			BEGIN
				SET @A = @A +1	
			END
	
			SET @F = @F + 1
	
		END
		
	
		SET @I = @I + 2
	END

	-- COLOCA JOGOS NA TABELA JOGOS
	SET @FLAG = 0
	SET @J = 1

	SET @DTJOGO = (SELECT TOP 1 t.DATA FROM #TODASDATAS t ORDER BY NEWID())
	DELETE FROM #TODASDATAS WHERE #TODASDATAS.DATA = @DTJOGO
	WHILE(@J < 92)
	BEGIN

		IF(@FLAG = 0)
		BEGIN
			INSERT INTO jogos VALUES
			((SELECT J.TIMEA FROM #TODOS_JOGOS J WHERE J.ID = @J) , (SELECT J.TIMEB FROM #TODOS_JOGOS J WHERE J.ID = @J), NULL, NULL, @DTJOGO),
			((SELECT J.TIMEA FROM #TODOS_JOGOS J WHERE J.ID = (@J + 16)) , (SELECT J.TIMEB FROM #TODOS_JOGOS J WHERE J.ID = (@J + 16)), NULL, NULL, @DTJOGO)
		END
		ELSE
		BEGIN
			INSERT INTO jogos VALUES
			((SELECT J.TIMEB FROM #TODOS_JOGOS J WHERE J.ID = @J) , (SELECT J.TIMEA FROM #TODOS_JOGOS J WHERE J.ID = @J), NULL, NULL, @DTJOGO),
			((SELECT J.TIMEB FROM #TODOS_JOGOS J WHERE J.ID = (@J + 16)) , (SELECT J.TIMEA FROM #TODOS_JOGOS J WHERE J.ID = (@J + 16)), NULL, NULL, @DTJOGO)
		END
		IF(@J % 16 = 0)
		BEGIN
			SET @J = @J + 16
		END


		IF(@J % 4 = 0)
		BEGIN
			SET @DTJOGO = (SELECT TOP 1 t.DATA FROM #TODASDATAS t ORDER BY NEWID())
			DELETE FROM #TODASDATAS WHERE #TODASDATAS.DATA = @DTJOGO
			IF(@FLAG = 0)
			BEGIN
				SET @FLAG = 1
			END
			ELSE
			BEGIN
				SET @FLAG = 0
			END
		END

		SET @J = @J +1
	END

DECLARE @out VARCHAR(100)
EXEC sp_criando_rodadas @out OUTPUT
SELECT codigoTimeA, codigoTimeB, golsTimeA, golsTimeB, data FROM jogos
SELECT * FROM jogos
SELECT codigoTimeA, codigoTimeB, golsTimeA, golsTimeB, data FROM jogos WHERE data = '28/03/2021'