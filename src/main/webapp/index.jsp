<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="./css/styles.css">
<title>Paulistão 2021</title>
</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<br />
	<div align="center" class="container">
		<form action="sorteio" method="post">
			<p class="title">
				<b>Paulistão 2021</b>
			</p>
			<table>
				<tr>
					<td><input type="submit" id="botao" name="botao"
						value="Sortear"></td>
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
		<c:if test="${not empty grupos }">
			<table class="table_round">
				<caption><b>GRUPO A</b></caption>
				<thead>
					<tr>
						<th>CódigoTime</th>
						<th>Nome</th>
						<th>Cidade</th>
						<th>Estádio</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="t" items="${grupos }" begin = "0" end ="3">
						<tr>
							<td><c:out value="${t.codigoTime }" /></td>
							<td><c:out value="${t.nomeTime }" /></td>
							<td><c:out value="${t.cidade }" /></td>
							<td><c:out value="${t.estadio }" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<br />
			<table class="table_round">
				<caption><b>GRUPO B</b></caption>
				<thead>
					<tr>
						<th>CódigoTime</th>
						<th>Nome</th>
						<th>Cidade</th>
						<th>Estádio</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="t" items="${grupos }" begin = "4" end ="7">
						<tr>
							<td><c:out value="${t.codigoTime }" /></td>
							<td><c:out value="${t.nomeTime }" /></td>
							<td><c:out value="${t.cidade }" /></td>
							<td><c:out value="${t.estadio }" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<br />
			<table class="table_round">
				<caption><b>GRUPO C</b></caption>
				<thead>
					<tr>
						<th>CódigoTime</th>
						<th>Nome</th>
						<th>Cidade</th>
						<th>Estádio</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="t" items="${grupos }" begin = "8" end ="11">
						<tr>
							<td><c:out value="${t.codigoTime }" /></td>
							<td><c:out value="${t.nomeTime }" /></td>
							<td><c:out value="${t.cidade }" /></td>
							<td><c:out value="${t.estadio }" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<br />
			<table class="table_round">
				<caption><b>GRUPO D</b></caption>
				<thead>
					<tr>
						<th>CódigoTime</th>
						<th>Nome</th>
						<th>Cidade</th>
						<th>Estádio</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="t" items="${grupos }" begin = "12" end ="15">
						<tr>
							<td><c:out value="${t.codigoTime }" /></td>
							<td><c:out value="${t.nomeTime }" /></td>
							<td><c:out value="${t.cidade }" /></td>
							<td><c:out value="${t.estadio }" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>
</body>
</html>