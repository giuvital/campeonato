USE campeonato;

SELECT * from  resultado_grupo('A')


CREATE FUNCTION classificar_grupos()
RETURNS @tabela TABLE(
	time varchar(max),
	grupo varchar(max),
	situacao varchar(max)
)
AS
BEGIN
/* 
 TODO: CAMPEAO DE CADA GRUPO SE DA PELO NUMERO DE PONTOS
 DESEMPATE NUM DE VITORIAS, NUM DE GOLS E POR FIM SALDO DE GOLS
*/
	INSERT INTO @tabela
	SELECT TOP 1 nome_time, 'A' as grupo, 'CLASSIFICADO' as situacao FROM resultado_grupo('A') ORDER BY pontos DESC, vitorias DESC, gols_marcados DESC, saldo_gols DESC
	
	INSERT INTO @tabela
	SELECT TOP 1 nome_time, 'B' as grupo, 'CLASSIFICADO' as situacao FROM resultado_grupo('B') ORDER BY pontos DESC, vitorias DESC, gols_marcados DESC, saldo_gols DESC
	
	INSERT INTO @tabela
	SELECT TOP 1 nome_time, 'C' as grupo, 'CLASSIFICADO' as situacao FROM resultado_grupo('C') ORDER BY pontos DESC, vitorias DESC, gols_marcados DESC, saldo_gols DESC
	
	INSERT INTO @tabela
	SELECT TOP 1 nome_time, 'D' as grupo, 'CLASSIFICADO' as situacao FROM resultado_grupo('D') ORDER BY pontos DESC, vitorias DESC, gols_marcados DESC, saldo_gols DESC
	
	
	--SELECT nome_time, pontos, vitorias, gols_marcados, saldo_gols FROM resultado_grupo('A') ORDER BY pontos DESC, vitorias DESC, gols_marcados DESC, saldo_gols DESC
		

/*
 *  TODO: TIME COM MENOR PONTUAÇÃO DENTRE TODOS OS TIMES
 */
		
	RETURN 
END

SELECT * FROM classificar_grupos(); 
