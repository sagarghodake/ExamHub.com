package com.examhub.impl;

import java.sql.*;
import java.util.*;

import com.examhub.dao.StudentDao;
import com.examhub.pojo.Student;
import static com.examhub.utility.DatabaseConnection.establishConnection;
public class StudentDaoImpl implements StudentDao{
	Connection con=null;
	PreparedStatement pst=null;
	ResultSet rs=null;
	@Override
	public boolean login(String username, String password) {
		con=establishConnection();
		String query="SELECT  * FROM STUDENT where username=? and password=?";
		try {
			pst=con.prepareStatement(query);
			pst.setString(1, username);
			pst.setString(2, password);
			
			if(pst.executeQuery().next()){
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
		String query="update student set password=? where username=? ";
		try {
			pst=con.prepareStatement(query);
			pst.setString(1, newPassword);
			pst.setString(2, username);
			int rowsAffeced=pst.executeUpdate();
			if(rowsAffeced>0){
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean registerStudent(Student student) {
		con=establishConnection();
		String query="insert into student(username,password,name,address,gender,dateofbirth,email,contact,regdate) values(?,?,?,?,?,?,?,?,?)";
		try {
			pst=con.prepareStatement(query);
			pst.setString(1, student.getUsername());
			pst.setString(2, student.getPassword());
			pst.setString(3, student.getName());
			pst.setString(4, student.getAddress());
			pst.setString(5, student.getGender());
			pst.setString(6, student.getDateOfBirth());
			pst.setString(7, student.getEmail());
			pst.setString(8, student.getContact());
			pst.setString(9, student.getRegDate());

			int rowsAffected=pst.executeUpdate();
			if(rowsAffected>0){
				return true;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean updateProfile(Student student) {
		con=establishConnection();
		String query="update student set name=?,address=?,gender=?,dateofbirth=?,email=?,contact=? where username=?";
		try {
			pst=con.prepareStatement(query);
			pst.setString(1, student.getName());
			pst.setString(2, student.getAddress());
			pst.setString(3, student.getGender());
			pst.setString(4, student.getDateOfBirth());
			pst.setString(5, student.getEmail());
			pst.setString(6, student.getContact());
			pst.setString(7, student.getUsername());
			int rowsAffected=pst.executeUpdate();
			if(rowsAffected>0){
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public List<Student> viewAllStudent() {
		List<Student> listOfAllStudents=new ArrayList<Student>();
		con=establishConnection();
		String query="select * from student";
		try {
			pst=con.prepareStatement(query);
			rs=pst.executeQuery();
			while(rs.next()) {
				Student student=new Student();
				student.setUsername(rs.getString(1));
				student.setPassword(rs.getString(2));
				student.setName(rs.getString(3));
				student.setAddress(rs.getString(4));
				student.setGender(rs.getString(5));
				student.setDateOfBirth(rs.getString(6));
				student.setEmail(rs.getString(7));
				student.setContact(rs.getString(8));
				student.setRegDate(rs.getString(9));
				listOfAllStudents.add(student);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return listOfAllStudents;
	}

	@Override
	public Student viewProfile(String username) {
		Student student=null;
		con=establishConnection();
		System.out.println(" NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN "+con);
		String query="select * from student where username=?";
		try {
			pst=con.prepareStatement(query);
			pst.setString(1, username);
			rs=pst.executeQuery();
			System.out.println(" UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU "+username);
			//System.out.println(" BBBBBBBBBBBBBBBBBBBBBBBB "+rs.next());
			if(rs.next()){
				student=new Student();
				student.setUsername(rs.getString(1));
				student.setName(rs.getString(3));
				student.setAddress(rs.getString(4));
				student.setGender(rs.getString(5));
				student.setDateOfBirth(rs.getString(6));
				student.setEmail(rs.getString(7));
				student.setContact(rs.getString(8));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println(" HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH "+student);
		return student;
	}

	

}
