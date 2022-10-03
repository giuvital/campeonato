package model;

public class Times {

	private int codigoTime;
	private String nomeTime;
	private String cidade;
	private String estadio;

	public int getCodigoTime() {
		return codigoTime;
	}

	public void setCodigoTime(int codigoTime) {
		this.codigoTime = codigoTime;
	}

	public String getNomeTime() {
		return nomeTime;
	}

	public void setNomeTime(String nomeTime) {
		this.nomeTime = nomeTime;
	}

	public String getCidade() {
		return cidade;
	}

	public void setCidade(String cidade) {
		this.cidade = cidade;
	}

	public String getEstadio() {
		return estadio;
	}

	public void setEstadio(String estadio) {
		this.estadio = estadio;
	}

	@Override
	public String toString() {
		return "Times [codigoTime=" + codigoTime + ", nomeTime=" + nomeTime + ", cidade=" + cidade + ", estadio="
				+ estadio + "]";
	}

}
