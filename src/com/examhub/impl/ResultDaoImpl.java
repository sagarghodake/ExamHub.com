package com.examhub.impl;

import static com.examhub.utility.DatabaseConnection.establishConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.examhub.dao.ResultDao;
import com.examhub.pojo.Category;
import com.examhub.pojo.Result;

public class ResultDaoImpl implements ResultDao {

	Connection con=null;
	PreparedStatement pst=null;
	ResultSet rs=null;
	
	@Override
	public boolean isTestAttempted(int testId, String studentUsername) {
		con=establishConnection();
		String query="select *from result where testid=? and  studentusername=?";
		try {
			pst=con.prepareStatement(query);
			pst.setString(2, studentUsername);
			pst.setInt(1, testId);
			rs=pst.executeQuery();
			while(rs.next()){
				return true;
				}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;

	}

	@Override
	public Result viewResult(int testId, String studentUsername) {
		con=establishConnection();
		String query="select *from result where testid=? and  studentusername=?";
		try {
			pst=con.prepareStatement(query);
			pst.setString(2, studentUsername);
			pst.setInt(1, testId);
			rs=pst.executeQuery();
			if(rs.next()){
				Result res=new Result();
				res.setResultId(rs.getInt(1));
				res.setTestId(rs.getInt(2));
				res.setMaxQuestions(rs.getInt(4));
				res.setMaxMarks(rs.getInt(5));
				res.setAttempted(rs.getInt(6));
				res.setCorrect(rs.getInt(7));
				res.setView(rs.getInt(9));
				res.setObtained(rs.getInt(8));
				res.setStudUsername(rs.getString(3));
				
				return res;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;

	}

	
	@Override
	public boolean updateResult(String studentUsername,int testId,int certificateId) {
		con=establishConnection();
		String query="update  result set view =? where testid=? and studentusername=?";
		try{
			pst=con.prepareStatement(query);
			pst.setString(3,studentUsername);
			pst.setInt(2, testId);
			pst.setInt(1,certificateId);
			int rowsAffected=pst.executeUpdate();
			if(rowsAffected>0){
				return true;
			}
		}
		catch(SQLException e){
			e.printStackTrace();
		}
		return false;
}

	
	@Override
	public boolean addResult(Result result) {
		con=establishConnection();
		String query="insert into result (testid,studentusername,maxquestion,maxmarks,attempted,correct,view,obtained) values(?,?,?,?,?,?,?,?)";
		try{
			pst=con.prepareStatement(query);
			pst.setString(2,result.getStudUsername());
			pst.setInt(1, result.getTestId());
			pst.setInt(3, result.getMaxQuestions());
			pst.setInt(4, result.getMaxMarks());
			pst.setInt(5, result.getAttempted());
			pst.setInt(6, result.getCorrect());
			pst.setInt(7, result.getView());
			pst.setInt(8, result.getObtained());
			int rowsAffected=pst.executeUpdate();
			if(rowsAffected>0){
				return true;
			}
		}
		catch(SQLException e){
			e.printStackTrace();
		}
		return false;
}

	@Override
	public Result viewResult(int resultId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Result> viewAllResults() {
		List<Result> listOfAllResult=new ArrayList<>();
		con=establishConnection();
		String query="select resultid,testid,studentusername,maxquestion,maxmarks,attempted,correct,view,obtained from result ";
		try {
			pst=con.prepareStatement(query);
			rs=pst.executeQuery();
			while(rs.next()){
				Result res=new Result();
				res.setResultId(rs.getInt(1));
				res.setTestId(rs.getInt(2));
				res.setMaxQuestions(rs.getInt(4));
				res.setMaxMarks(rs.getInt(5));
				res.setAttempted(rs.getInt(6));
				res.setCorrect(rs.getInt(7));
				res.setView(rs.getInt(8));
				res.setObtained(rs.getInt(9));
				res.setStudUsername(rs.getString(3));
				
				
				listOfAllResult.add(res);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return listOfAllResult;

	}

	@Override
	public List<Result> viewAllResults(int testId) {
	List<Result> listOfResults=new ArrayList<Result>();
	con=establishConnection();
	String query="select *from result where testid=? order by obtained desc";
	try {
		pst=con.prepareStatement(query);
		pst.setInt(1, testId);
		rs=pst.executeQuery();
		while(rs.next()){
			Result res=new Result();
			res.setResultId(rs.getInt(1));
			res.setTestId(rs.getInt(2));
			res.setMaxQuestions(rs.getInt(4));
			res.setMaxMarks(rs.getInt(5));
			res.setAttempted(rs.getInt(6));
			res.setCorrect(rs.getInt(7));
			res.setView(rs.getInt(9));
			res.setObtained(rs.getInt(8));
			res.setStudUsername(rs.getString(3));
			
			listOfResults.add(res);
			}
	} catch (SQLException e) {
		e.printStackTrace();
	}
	return listOfResults;

	
	}
	
}
