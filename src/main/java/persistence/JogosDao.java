package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Jogos;

public class JogosDao implements IJogosDao {

	Connection c;

	private GenericDao gDao;

	public JogosDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	public List<Jogos> geraRodada() throws SQLException, ClassNotFoundException {
		List<Jogos> listaJogos;
		Connection c = gDao.getConnection();

		String sql = "{CALL sp_criando_rodadas}";
		CallableStatement cs = c.prepareCall(sql);

		cs.execute();
		listaJogos = findRodada(c);
		cs.close();
		c.close();

		return listaJogos;

	}

	public List<Jogos> findRodada(Connection c) throws SQLException, ClassNotFoundException {

		List<Jogos> listaJogos = new ArrayList<Jogos>();
		StringBuffer sql = new StringBuffer();
		sql.append(
				"SELECT t1.nomeTime AS Mandante, golstimeA, golsTimeB, t2.nomeTime AS Visitante, convert(varchar(10),data,103) as dataJogo ");
		sql.append("FROM jogos ");
		sql.append("INNER JOIN times as t1 ");
		sql.append("ON t1.codigoTime = Jogos.codigoTimeA ");
		sql.append("INNER JOIN times AS t2 ");
		sql.append("ON t2.codigoTime = Jogos.codigoTimeB ");
		sql.append("ORDER BY data");
		PreparedStatement ps = c.prepareStatement(sql.toString());
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {

			Jogos j = new Jogos();

			j.setNomeTimeA(rs.getString("Mandante"));
			j.setNomeTimeB(rs.getString("Visitante"));
			j.setGolsTimeA(rs.getInt("golsTimeA"));
			j.setGolsTimeB(rs.getInt("golsTimeB"));
			j.setData(rs.getString("dataJogo"));

			listaJogos.add(j);

		}

		rs.close();
		ps.close();
		c.close();

		return listaJogos;
	}

	@Override
	public List<Jogos> pesquisarPorData(String data) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		List<Jogos> lista = new ArrayList<Jogos>();
		StringBuffer sql = new StringBuffer();

		sql.append(
				"SELECT t1.nomeTime AS Mandante, golstimeA, golsTimeB, t2.nomeTime AS Visitante, convert(varchar(10),data,103) as dataJogo ");
		sql.append("FROM jogos ");
		sql.append("INNER JOIN times as t1 ");
		sql.append("ON t1.codigoTime = Jogos.codigoTimeA ");
		sql.append("INNER JOIN times AS t2 ");
		sql.append("ON t2.codigoTime = Jogos.codigoTimeB ");
		sql.append("WHERE Jogos.data = ? ");
		sql.append("ORDER BY data");

		PreparedStatement ps = c.prepareStatement(sql.toString());
		ps.setString(1, data);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {

			Jogos j = new Jogos();

			j.setNomeTimeA(rs.getString("Mandante"));
			j.setNomeTimeB(rs.getString("Visitante"));
			j.setGolsTimeA(rs.getInt("golsTimeA"));
			j.setGolsTimeB(rs.getInt("golsTimeB"));
			j.setData(rs.getString("dataJogo"));

			lista.add(j);

		}
		
		rs.close();
		ps.close();
		c.close();

		return lista;
	}

}