package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Times;

public class SorteioDao implements ISorteioDao {

	private GenericDao gDao;

	public SorteioDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public List<Times> findTimes() throws SQLException, ClassNotFoundException {
		List<Times> grupos;
		Connection c = gDao.getConnection();

		String sql = "{CALL sp_divGrp}";
		CallableStatement cs = c.prepareCall(sql);

		cs.execute();
		grupos = getGrupos(c);
		cs.close();
		c.close();

		return grupos;
	}

	public List<Times> getGrupos(Connection c) throws SQLException, ClassNotFoundException {
		
		List<Times> grupos = new ArrayList<Times>();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT gp.grupo, gp.codigoTime, t.nomeTime, t.cidade, t.estadio FROM grupos gp, times t ");
		sql.append("WHERE gp.codigoTime = t.codigoTime ORDER BY grupo");
//		sql.append("SELECT gp.grupo, gp.codigoTime, t.nomeTime, t.cidade, t.estadio FROM grupos gp, times t ");
//		sql.append("WHERE gp.codigoTime = t.codigoTime AND gp.grupo = 'A'");
		PreparedStatement ps = c.prepareStatement(sql.toString());
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Times t = new Times();

			t.setCodigoTime(rs.getInt("codigoTime"));
			t.setNomeTime(rs.getString("nomeTime"));
			t.setCidade(rs.getString("cidade"));
			t.setEstadio(rs.getString("estadio"));

			grupos.add(t);
		}
		
		rs.close();
		ps.close();
		c.close();

		return grupos;
	}

}
