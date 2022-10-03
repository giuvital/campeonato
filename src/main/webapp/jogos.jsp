<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="./css/styles.css">
<title>Jogos</title>
</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<br />
	<div align="center" class="container">
		<form action="rodadas" method="post">
			<p class="title">
				<b>Paulistão 2021</b>
			</p>
			<table>
				<tr>
					<td>
					<input class="input_data" type="date" id="data"
						name="data" placeholder="Rodada"
						value='<c:out value="${jogos.dataRodada }"></c:out>'>
					</td>
					<td><input type="submit" id="botao" name="botao" value="Jogos"></td>
				</tr>
			</table>
		</form>
	</div>
	<br />
	<br />
	<div align="center">
		<c:if test="${not empty erro }">
			<H2>
				<c:out value="${erro }" />
			</H2>
		</c:if>
	</div>
	<div align="center">
		<c:if test="${not empty saida }">
			<H3>
				<c:out value="${saida }" />
			</H3>
		</c:if>
	</div>
	<br />
	<br />
	<div align="center">
		<c:if test="${not empty listaJogos }">
			<table class="table_round">
				<caption>Rodadas</caption>
				<thead>
					<tr>
						<th>Time A</th>
						<th>Time B</th>
						<th>Gols A</th>
						<th>Gols B</th>
						<th>Data</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="j" items="${listaJogos }">
						<tr>
							<td><c:out value="${j.nomeTimeA }" /></td>
							<td><c:out value="${j.nomeTimeB }" /></td>
							<td><c:out value="${j.golsTimeA }" /></td>
							<td><c:out value="${j.golsTimeB }" /></td>
							<td><c:out value="${j.data }" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>
</body>
</html>