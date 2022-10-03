package persistence;

import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import model.Jogo;
import model.Time;

public interface ITorneioDao {

	public List<Time> getTimes() throws SQLException;

	public List<Jogo> getJogos(Date dataRodada) throws SQLException;

}
