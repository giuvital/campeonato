package model;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Time {

	private String nome;
	private String grupo;

	public Time() {

	}

	public Time(String nome, String grupo) {
		super();
		this.nome = nome;
		this.grupo = grupo;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getGrupo() {
		return grupo;
	}

	public void setGrupo(String grupo) {
		this.grupo = grupo;
	}
	
	
	@Override
	public String toString() {
		return "Time [nome=" + nome + ", grupo=" + grupo + "]";
	}

	public static Time instantiateTimeFromResultSet(ResultSet rs) throws SQLException {
		Time time = new Time();

		time.setNome(rs.getString("nome"));
		time.setGrupo(rs.getString("sigla"));

		return time;
	}
}
