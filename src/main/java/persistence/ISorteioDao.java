package persistence;

import java.sql.SQLException;
import java.util.List;

import model.Times;

public interface ISorteioDao {

	public List<Times> findTimes() throws SQLException, ClassNotFoundException;

}