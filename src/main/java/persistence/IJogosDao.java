package persistence;

import java.sql.SQLException;
import java.util.List;

import model.Jogos;

public interface IJogosDao {
	
	public List<Jogos> geraRodada () throws SQLException, ClassNotFoundException;
	public List<Jogos> pesquisarPorData(String data) throws SQLException, ClassNotFoundException;
}
