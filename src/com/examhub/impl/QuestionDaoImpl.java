package com.examhub.impl;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.examhub.dao.QuestionDao;
import com.examhub.pojo.Question;
import static com.examhub.utility.DatabaseConnection.establishConnection;;

public class QuestionDaoImpl implements QuestionDao{
	Connection con=null;
	PreparedStatement pst=null;
	ResultSet rs=null;

	
	
	@Override
	public boolean addQuestion(Question question) {
		con=establishConnection();
		String query="insert into question (question,option1,option2,option3,option4,answer,sectionid)"
				+ " values(?,?,?,?,?,?,?)";
		try {
			pst=con.prepareStatement(query);
			pst.setString(1,question.getQuestion());
			pst.setString(2, question.getOption1());
			pst.setString(3, question.getOption2());
			pst.setString(4, question.getOption3());
			pst.setString(5, question.getOption4());
			pst.setString(6, question.getAnswer());
			pst.setInt(7, question.getSectionId());
			
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
	public boolean updateQuestion(Question question) {
		con=establishConnection();
		String query="update question set question=?,option1=?,option2=?,option3=?,option4=?,answer=?,sectionid=?"
				+ " where questionid=?";
		try {
			pst=con.prepareStatement(query);
			pst.setString(1, question.getQuestion());
			pst.setString(2, question.getOption1());
			pst.setString(3, question.getOption2());
			pst.setString(4, question.getOption3());
			pst.setString(5, question.getOption4());
			pst.setString(6, question.getAnswer());
			pst.setInt(7, question.getSectionId());
			pst.setInt(8, question.getQuestionId());
			
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
	public boolean deleteQuestion(int questioId) {
		con=establishConnection();
		String query="delete from question where questionid=?";
		
		try {
			pst=con.prepareStatement(query);
			pst.setInt(1, questioId);
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
	public boolean deleteQuestionByExam(int examId) {
		con=establishConnection();
		return false;
	}

	@Override
	public Question viewQuestion(int questionId) {
		Question que=null;
		con=establishConnection();
		String query="select * from question where questionid=?";
		try {
			System.out.println("@@@@@@@@@@@@@@@@@@@@@ in qestion view by ID "+questionId);
			pst=con.prepareStatement(query);
			pst.setInt(1, questionId);
			rs=pst.executeQuery();
			if(rs.next()){
				que=new Question();
				que.setQuestionId(questionId);
				que.setQuestion(rs.getString(2));
				que.setOption1(rs.getString(3));
				que.setOption2(rs.getString(4));
				que.setOption3(rs.getString(5));
				que.setOption4(rs.getString(6));
				que.setAnswer(rs.getString(7));
				que.setSectionId(rs.getInt(8));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return que;
	}

	@Override
	public List<Question> viewAllQuestion() {
		List<Question> listOfAllQuestions=new ArrayList<Question>();
		con=establishConnection();
		String query="select * from question";
		
		try {
			pst=con.prepareStatement(query);
			rs=pst.executeQuery();
			while(rs.next()){
				Question question=new Question();
				question.setQuestionId(rs.getInt(1));
				question.setQuestion(rs.getString(2));
				question.setOption1(rs.getString(3));
				question.setOption2(rs.getString(4));
				question.setOption3(rs.getString(5));
				question.setOption4(rs.getString(6));
				question.setAnswer(rs.getString(7));
				question.setSectionId(rs.getInt(8));
				listOfAllQuestions.add(question);
			}
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		return listOfAllQuestions;
	}

	@Override
	public List<Question> viewAllQuestion(int examId) {
		List<Question> listOfAllQuestions=new ArrayList<Question>();
		con=establishConnection();
		String query="select * from question que INNER JOIN section sec on que.sectionid=sec.sectionid and sec.examid=?";
		
		try {
			pst=con.prepareStatement(query);
			pst.setInt(1, examId);
			rs=pst.executeQuery();
				while(rs.next()){
				Question question=new Question();
				question.setQuestionId(rs.getInt(1));
				question.setQuestion(rs.getString(2));
				question.setOption1(rs.getString(3));
				question.setOption2(rs.getString(4));
				question.setOption3(rs.getString(5));
				question.setOption4(rs.getString(6));
				question.setAnswer(rs.getString(7));
				question.setSectionId(rs.getInt(8));
				listOfAllQuestions.add(question);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return listOfAllQuestions;
	}

	@Override
	public List<Question> viewAllQuestion(int examId, int sectionId) {
		List<Question> listOfAllQuestions=new ArrayList<>();
		con=establishConnection();
		String query="select * from question que INNER JOIN section sec "
					+ "on que.sectionid=sec.sectionid and que.sectionid=? and sec.examid=?";
		
		try {
			pst=con.prepareStatement(query);
			pst.setInt(1, sectionId);
			pst.setInt(2, examId);
			rs=pst.executeQuery();
			while(rs.next()){
				Question question=new Question();
				question.setQuestionId(rs.getInt(1));
				question.setQuestion(rs.getString(2));
				question.setOption1(rs.getString(3));
				question.setOption2(rs.getString(4));
				question.setOption3(rs.getString(5));
				question.setOption4(rs.getString(6));
				question.setAnswer(rs.getString(7));
				question.setSectionId(rs.getInt(8));
				listOfAllQuestions.add(question);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}	
		return listOfAllQuestions;
	}
}
