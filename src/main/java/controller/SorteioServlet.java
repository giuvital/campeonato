package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Times;
import persistence.GenericDao;
import persistence.SorteioDao;

@WebServlet("/sorteio")
public class SorteioServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public SorteioServlet() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Times t = new Times();

		String codigoTime = request.getParameter("codigoTime");
		String nomeTime = request.getParameter("nomeTime");
		String cidade = request.getParameter("cidade");
		String estadio = request.getParameter("estadio");
		String botao = request.getParameter("botao");

		GenericDao gDao = new GenericDao();
		SorteioDao sDao = new SorteioDao(gDao);
		List<Times> grupos = new ArrayList<Times>();
		String saida = "";
		String erro = "";

		try {
			if (botao.equals("Sortear")) {
				grupos = sDao.findTimes();
			}
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
			request.setAttribute("grupos", grupos);
			request.setAttribute("codigoTime", codigoTime);
			request.setAttribute("nomeTime", nomeTime);
			request.setAttribute("cidade", cidade);
			request.setAttribute("estadio", estadio);
			request.setAttribute("erro", erro);
			request.setAttribute("saida", saida);
			rd.forward(request, response);
		}

	}
}
