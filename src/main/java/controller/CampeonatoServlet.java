package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Jogo;
import model.Time;
import persistence.TorneioDao;

@WebServlet("/torneio")
public class CampeonatoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public CampeonatoServlet() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		TorneioDao td;

		String acao = request.getParameter("action");

		try {
			td = new TorneioDao();

			if (acao.equalsIgnoreCase("getTimes")) {
				List<Time> times = td.getTimes();
				request.setAttribute("times", times);
			}

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
		rd.forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String dataRodada = request.getParameter("dataRodada");

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Date data;
		TorneioDao td;

		try {
			
			td = new TorneioDao();
			data = formatter.parse(dataRodada);
			List<Jogo> jogos = td.getJogos(data);
			request.setAttribute("jogos", jogos);
			
		} catch (ParseException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
		rd.forward(request, response);
	}

}
