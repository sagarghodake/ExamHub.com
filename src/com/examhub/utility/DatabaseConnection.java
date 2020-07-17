package com.examhub.utility;

import java.sql.*;

public class DatabaseConnection {
	private static Connection con=null;
	
	public static Connection establishConnection(){
		if(con==null){
			try{
				Class.forName("com.mysql.jdbc.Driver");
				con=DriverManager.getConnection("jdbc:mysql://localhost:3306/exam","root","");
			}
			catch(ClassNotFoundException e){
				e.printStackTrace();
			}
			catch(SQLException e){
				e.printStackTrace();
			}
		}
		return con;
	}
	public static void main(String[] args) {
		System.out.println(establishConnection());
	}
}
