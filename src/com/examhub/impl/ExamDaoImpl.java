package com.examhub.impl;

import java.sql.*;
import java.util.*;
import com.examhub.dao.ExamDao;
import com.examhub.pojo.Exam;
import static com.examhub.utility.DatabaseConnection.establishConnection;
public class ExamDaoImpl implements ExamDao {
	Connection con=null;
	PreparedStatement pst=null;
	ResultSet rs=null;
	@Override
	public boolean addExam(Exam exam) {
		con=establishConnection();
		String query="insert into exam(examname,categoryid) values(?,?)";
		
		try {
			pst=con.prepareStatement(query);
			pst.setString(1, exam.getExamName());
			pst.setInt(2, exam.getCategoryId());
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
	public boolean updateExam(Exam exam) {
		con=establishConnection();
		String query="update exam set examname=?,categoryid=? where examid=?";
		try {
			pst=con.prepareStatement(query);
			pst.setString(1, exam.getExamName());
			pst.setInt(2, exam.getCategoryId());
			pst.setInt(3, exam.getExamId());
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
	public Exam viewExam(int examId) {
		Exam exam=null;
		con=establishConnection();
		String query="select * from exam where examid=?";
		try {
			pst=con.prepareStatement(query);
			pst.setInt(1, examId);
			rs=pst.executeQuery();
			if(rs.next()){
				exam=new Exam();
				exam.setExamId(rs.getInt(1));
				exam.setExamName(rs.getString(2));
				exam.setCategoryId(rs.getInt(3));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return exam;
	}

	@Override
	public List<Exam> viewAllExam(int categoryId) {
		List<Exam> listOfAllExams=new ArrayList<>();
		Exam exam=null;
		con=establishConnection();
		String query="select * from exam where categoryid=?";
		try {
			pst=con.prepareStatement(query);
			pst.setInt(1, categoryId);
			rs=pst.executeQuery();
			while(rs.next()){
				exam=new Exam();
				exam.setExamId(rs.getInt(1));
				exam.setExamName(rs.getString(2));
				exam.setCategoryId(rs.getInt(3));
				listOfAllExams.add(exam);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return listOfAllExams;
	}
	
	@Override
	public List<Exam> viewAllExam() {
		List<Exam> listOfAllExams=new ArrayList<>();
		Exam exam=null;
		con=establishConnection();
		String query="select * from exam ";
		try {
			pst=con.prepareStatement(query);
			
			rs=pst.executeQuery();
			while(rs.next()){
				exam=new Exam();
				exam.setExamId(rs.getInt(1));
				exam.setExamName(rs.getString(2));
				exam.setCategoryId(rs.getInt(3));
				listOfAllExams.add(exam);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return listOfAllExams;
	}

	@Override
	public boolean deleteExam(int examId) {
		con=establishConnection();
		String query="delete from exam where examid=?";
		try {
			pst=con.prepareStatement(query);
			pst.setInt(1,examId);
			int rowsAffected=pst.executeUpdate();
			if(rowsAffected>0){
				return true;
			}	
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean deleteExamByCategory(int categoryId) {
		con=establishConnection();
		String query="delete from exam where categoryid=?";
		try {
			pst=con.prepareStatement(query);
			pst.setInt(1,categoryId);
			int rowsAffected=pst.executeUpdate();
			if(rowsAffected>0){
				return true;
			}	
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
		}
}
