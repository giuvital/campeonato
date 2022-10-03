package persistence;

import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import model.Jogo;

public class Main {

	public static void main(String[] args) throws ClassNotFoundException, SQLException, ParseException {

		TorneioDao td = new TorneioDao();

		SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
		Date data = formato.parse("03/10/2022");

		List<Jogo> jogos = td.getJogos(data);

		jogos.forEach(jogo -> System.out.println(jogo));
	}

}
