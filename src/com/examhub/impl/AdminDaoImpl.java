package com.examhub.impl;
import com.examhub.dao.AdminDao;
import java.sql.*;
import static com.examhub.utility.DatabaseConnection.establishConnection;
public class AdminDaoImpl implements AdminDao {
	Connection con=null;
	PreparedStatement pst=null;
	ResultSet rs=null;
	@Override
	public boolean login(String username, String password) {
		con=establishConnection();
		String query="select * from admin where username=? and password=?";
		try {
			pst=con.prepareStatement(query);
			pst.setString(1, username);
			pst.setString(2, password);
			rs=pst.executeQuery();
			if(rs.next()){
					return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean changePassword(String username,String newPassword) {
		con=establishConnection();
		String query="update admin set password=? where username=?";
		try {
			pst=con.prepareStatement(query);
			pst.setString(1, newPassword);
			pst.setString(2, username);
			int rowsAffected=pst.executeUpdate();
			if(rowsAffected>0){
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}	
		return false;
	}
}
