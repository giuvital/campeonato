CREATE DATABASE campeonato;
USE campeonato;

-- CRIANDO AS TABELAS
CREATE TABLE times(
	codigoTime INT PRIMARY KEY IDENTITY(1, 1),
	nome VARCHAR(100) NOT NULL,
	cidade VARCHAR(100) NOT NULL,
	estadio VARCHAR(100) NOT NULL	
)

CREATE TABLE grupo(
	sigla CHAR PRIMARY KEY
)

CREATE TABLE grupos(
	codigoGrupo CHAR NOT NULL,
	codigoTime INT NOT NULL,
	
	FOREIGN KEY (codigoGrupo) REFERENCES grupo(sigla),
	FOREIGN KEY (codigoTime) REFERENCES times(codigoTime)
)

DROP TABLE jogos;

CREATE TABLE jogos(
	id int primary key identity(1, 1),
	timeCasa INT FOREIGN KEY REFERENCES times(codigoTime),
	grupoCasa CHAR,
	golsCasa INT,
	timeFora INT FOREIGN KEY REFERENCES times(codigoTime),
	grupoFora CHAR,
	golsFora INT,
	data DATE NOT NULL
) 


-- INSERINDO OS GRUPOS
INSERT INTO grupo (sigla) VALUES ('A'), ('B'), ('C'), ('D');


--INSERINDO OS TIMES
INSERT INTO times(nome, cidade, estadio) VALUES
('Botafogo-SP'    , 'Ribeirão Preto'    , 'Santa Cruz'                ),
('Bragantino'     , 'Bragança Paulista' , 'Nabi Abi Chedid'           ),
('Corinthians'    , 'São Paulo'         , 'Arena Corinthians'         ),
('Ferroviária'    , 'Araraquara'        , 'Fonte Luminosa'            ),
('Guarani'        , 'Campinas'          , 'Brinco de Ouro da Princesa'),
('Ituano'         , 'Itu'               , 'Novelli Júnior'            ),
('Mirassol'       , 'Mirassol'          , 'José Maria de Campos Maia' ),
('Novorizontino'  , 'Novo Horizonte'    , 'Jorge Ismael de Biasi'     ),
('Oeste'          , 'Barueri'           , 'Arena Barueri'             ),
('Palmeiras'      , 'São Paulo'         , 'Allianz Parque'            ),
('Ponte Preta'    , 'Campinas'          , 'Moisés Lucarelli'          ),
('Red Bull Brasil', 'Campinas'          , 'Moisés Lucarelli'          ),
('Santos'         , 'Santos'            , 'Vila Belmiro'              ),
('São Bento'      , 'Sorocaba'          , 'Walter Ribeiro'            ),
('São Caetano'    , 'São Caetano do Sul', 'Anacletto Campanella'      ),
('São Paulo'      , 'São Paulo'         , 'Morumbi'                   )

