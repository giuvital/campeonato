package model;

public class Jogos {

	private int codigoTimeA;
	private String nomeTimeA;
	private String nomeTimeB;
	private int codigoTimeB;
	private int golsTimeA;
	private int golsTimeB;
	private String dataRodada;
	
	public String getDataRodada() {
		return dataRodada;
	}

	public void setDataRodada(String dataRodada) {
		this.dataRodada = dataRodada;
	}

	public String getNomeTimeA() {
		return nomeTimeA;
	}

	public void setNomeTimeA(String nomeTimeA) {
		this.nomeTimeA = nomeTimeA;
	}

	public String getNomeTimeB() {
		return nomeTimeB;
	}

	public void setNomeTimeB(String nomeTimeB) {
		this.nomeTimeB = nomeTimeB;
	}

	private String data;

	public int getCodigoTimeA() {
		return codigoTimeA;
	}

	public void setCodigoTimeA(int codigoTimeA) {
		this.codigoTimeA = codigoTimeA;
	}

	public int getCodigoTimeB() {
		return codigoTimeB;
	}

	public void setCodigoTimeB(int codigoTimeB) {
		this.codigoTimeB = codigoTimeB;
	}

	public int getGolsTimeA() {
		return golsTimeA;
	}

	public void setGolsTimeA(int golsTimeA) {
		this.golsTimeA = golsTimeA;
	}

	public int getGolsTimeB() {
		return golsTimeB;
	}

	public void setGolsTimeB(int golsTimeB) {
		this.golsTimeB = golsTimeB;
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}

	@Override
	public String toString() {
		return "Jogos [codigoTimeA=" + codigoTimeA + ", nomeTimeA=" + nomeTimeA + ", nomeTimeB=" + nomeTimeB
				+ ", codigoTimeB=" + codigoTimeB + ", golsTimeA=" + golsTimeA + ", golsTimeB=" + golsTimeB
				+ ", dataRodada=" + dataRodada + ", data=" + data + "]";
	}

}
