package model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

public class Jogo {

	private String timeCasa;
	private String grupoCasa;
	private int golsCasa;
	private String timeFora;
	private String grupoFora;
	private int golsFora;
	private Date data;

	public Jogo() {

	}

	public Jogo(String timeCasa, String grupoCasa, int golsCasa, String timeFora, String grupoFora, int golsFora,
			Date data) {
		super();
		this.timeCasa = timeCasa;
		this.grupoCasa = grupoCasa;
		this.golsCasa = golsCasa;
		this.timeFora = timeFora;
		this.grupoFora = grupoFora;
		this.golsFora = golsFora;
		this.data = data;
	}

	public String getTimeCasa() {
		return timeCasa;
	}

	public void setTimeCasa(String timeCasa) {
		this.timeCasa = timeCasa;
	}

	public String getGrupoCasa() {
		return grupoCasa;
	}

	public void setGrupoCasa(String grupoCasa) {
		this.grupoCasa = grupoCasa;
	}

	public int getGolsCasa() {
		return golsCasa;
	}

	public void setGolsCasa(int golsCasa) {
		this.golsCasa = golsCasa;
	}

	public String getTimeFora() {
		return timeFora;
	}

	public void setTimeFora(String timeFora) {
		this.timeFora = timeFora;
	}

	public String getGrupoFora() {
		return grupoFora;
	}

	public void setGrupoFora(String grupoFora) {
		this.grupoFora = grupoFora;
	}

	public int getGolsFora() {
		return golsFora;
	}

	public void setGolsFora(int golsFora) {
		this.golsFora = golsFora;
	}

	public Date getData() {
		return data;
	}

	public void setData(Date data) {
		this.data = data;
	}
	

	@Override
	public String toString() {
		return "Jogo [timeCasa=" + timeCasa + ", grupoCasa=" + grupoCasa + ", golsCasa=" + golsCasa + ", timeFora="
				+ timeFora + ", grupoFora=" + grupoFora + ", golsFora=" + golsFora + ", data=" + data + "]";
	}

	public static Jogo instantiateJogoFromResultSet(ResultSet rs) throws SQLException {
		Jogo jogo = new Jogo();

		jogo.setTimeCasa(rs.getString("timeCasa"));
		jogo.setGrupoCasa(rs.getString("grupoCasa"));
		jogo.setGolsCasa(rs.getInt("golsCasa"));

		jogo.setTimeFora(rs.getString("timeFora"));
		jogo.setGrupoFora(rs.getString("grupoFora"));
		jogo.setGolsFora(rs.getInt("golsFora"));

		jogo.setData(rs.getDate("data"));

		return jogo;
	}

}
