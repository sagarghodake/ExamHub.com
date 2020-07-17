package com.examhub.impl;

import java.sql.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;

import com.examhub.dao.TestDao;
import com.examhub.pojo.Test;
import static com.examhub.utility.DatabaseConnection.establishConnection;

public class TestDaoImpl implements TestDao {
	Connection con = null;
	PreparedStatement pst = null;
	ResultSet rs = null;
	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

	@Override
	public boolean createTest(Test test) {
		con = establishConnection();
		String query = "insert into test(testname,testtype,maxquestion,maxmarks,duration,testfee,examid,open,closes) values(?,?,?,?,?,?,?,?,?)";

		String openDate = dateFormat.format(test.getOpen());
		String closeDate = dateFormat.format(test.getclose());

		try {
			pst = con.prepareStatement(query);
			pst.setString(1, test.getTestName());
			pst.setInt(3, test.getMaxQuestion());
			pst.setInt(4, test.getMaxMarks());
			pst.setInt(5, test.getDuration());

			pst.setString(2, test.getTestType());
			pst.setInt(6, test.getTestFee());
			pst.setInt(7, test.getExamId());
			pst.setString(8, openDate);
			pst.setString(9, closeDate);
			if (closeDate.equalsIgnoreCase("0001-01-01")) {
				closeDate = "no CLosing Date";
				pst.setString(9, closeDate);
			}

			int rowsAffected = pst.executeUpdate();
			if (rowsAffected > 0) {
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean updateTest(Test test) {
		con = establishConnection();
		String query = "update test set testname=?,testtype=?,maxquestion=?,maxmarks=?,duration=?,testfee=?,examid=?,open=?,closes=? where testid=?";
		try {
			pst = con.prepareStatement(query);
			pst.setString(1, test.getTestName());
			pst.setInt(3, test.getMaxQuestion());
			pst.setInt(4, test.getMaxMarks());
			pst.setInt(5, test.getDuration());

			pst.setString(2, test.getTestType());
			pst.setInt(6, test.getTestFee());
			pst.setInt(7, test.getExamId());
			String openDate = dateFormat.format(test.getOpen());
			String closeDate = dateFormat.format(test.getclose());
			pst.setString(8, openDate);
			pst.setString(9, closeDate);

			pst.setInt(10, test.getTestId());

			int rowsAffected = pst.executeUpdate();
			if (rowsAffected > 0) {
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean daleteTest(int testId) {
		con = establishConnection();
		String query = "delete from test where testid=?";
		try {
			pst = con.prepareStatement(query);
			pst.setInt(1, testId);
			int rowsAffected = pst.executeUpdate();
			if (rowsAffected > 0) {
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean deleteTestByExam(int examId) {
		con = establishConnection();
		String query = "delete from test where examid=?";
		try {
			pst = con.prepareStatement(query);
			pst.setInt(1, examId);
			int rowsAffected = pst.executeUpdate();
			if (rowsAffected > 0) {
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public Test viewTest(int testId) {
		Test test = null;
		con = establishConnection();
		String query = "select * from test where testid=?";
		try {
			pst = con.prepareStatement(query);
			pst.setInt(1, testId);
			rs = pst.executeQuery();
			if (rs.next()) {
				test = new Test();
				test.setTestId(rs.getInt(1));
				test.setTestName(rs.getString(2));

				test.setTestType(rs.getString(3));

				test.setMaxQuestion(rs.getInt(4));
				test.setMaxMarks(rs.getInt(5));
				test.setDuration(rs.getInt(6));

				test.setTestFee(rs.getInt(7));
				test.setExamId(rs.getInt(8));
				Date openDate;

				openDate = dateFormat.parse(rs.getString(9));
				test.setOpen(openDate);
				if (rs.getString(10).equalsIgnoreCase("no CLosing Date")) {
					test.setclose(dateFormat.parse("0001-01-01"));
				} else {
					Date closeDate = dateFormat.parse(rs.getString(10));
					test.setclose(closeDate);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return test;
	}

	@Override
	public List<Test> viewAllTest() {
		List<Test> listOfAllTest = new ArrayList<Test>();
		Test test = null;
		con = establishConnection();
		String query = "select * from test";
		try {
			pst = con.prepareStatement(query);
			rs = pst.executeQuery();
			while (rs.next()) {
				test = new Test();
				test.setTestId(rs.getInt(1));
				test.setTestName(rs.getString(2));

				test.setTestType(rs.getString(3));

				test.setMaxQuestion(rs.getInt(4));
				test.setMaxMarks(rs.getInt(5));
				test.setDuration(rs.getInt(6));

				test.setTestFee(rs.getInt(7));
				test.setExamId(rs.getInt(8));

				Date openDate;

				openDate = dateFormat.parse(rs.getString(9));
				test.setOpen(openDate);
				if (rs.getString(10).equalsIgnoreCase("no CLosing Date")) {
					test.setclose(dateFormat.parse("0001-01-01"));
				} else {
					Date closeDate = dateFormat.parse(rs.getString(10));
					test.setclose(closeDate);
				}
				listOfAllTest.add(test);
			}
		} catch (SQLException | ParseException e) {
			e.printStackTrace();
		}
		return listOfAllTest;
	}

	@Override
	public List<Test> viewAllUpcomingTest() {
		List<Test> listOfAllTest = new ArrayList<Test>();
		Test test = null;
		con = establishConnection();
		String query = "select * from test where testtype='practice'";
		try {
			pst = con.prepareStatement(query);
			rs = pst.executeQuery();
			while (rs.next()) {
				Date openDate;
				System.out.println(rs.getString(9));

				openDate = dateFormat.parse(rs.getString(9));
				System.out.println(new Date() + " compared with " + openDate);
				System.out.println(openDate.compareTo(new Date()) > 0);
				System.out.println();
				if (openDate.compareTo(new Date()) > 0) {
					test = new Test();
					test.setTestId(rs.getInt(1));
					test.setTestName(rs.getString(2));

					test.setTestType(rs.getString(3));

					test.setMaxQuestion(rs.getInt(4));
					test.setMaxMarks(rs.getInt(5));
					test.setDuration(rs.getInt(6));

					test.setTestFee(rs.getInt(7));
					test.setExamId(rs.getInt(8));

					test.setOpen(openDate);

					if (rs.getString(10).equalsIgnoreCase("no CLosing Date")) {
						test.setclose(dateFormat.parse("0001-01-01"));
					} else {
						Date closeDate = dateFormat.parse(rs.getString(10));
						test.setclose(closeDate);
					}
					listOfAllTest.add(test);

				}
				System.out.println(openDate);
			}
		} catch (SQLException | ParseException e) {
			e.printStackTrace();
		}
		return listOfAllTest;
	}

	@Override
	public List<Test> viewAllTest(String type) {
		List<Test> listOfAllTest = new ArrayList<Test>();
		Test test = null;
		con = establishConnection();
		String query = "select * from test where testtype =? ";
		try {
			pst = con.prepareStatement(query);
			pst.setString(1, type);
			rs = pst.executeQuery();
			while (rs.next()) {
				Date openDate;

				openDate = dateFormat.parse(rs.getString(9));

				if (openDate.compareTo(new Date()) < 0) {

					test = new Test();
					test.setTestId(rs.getInt(1));
					test.setTestName(rs.getString(2));

					test.setTestType(rs.getString(3));

					test.setMaxQuestion(rs.getInt(4));
					test.setMaxMarks(rs.getInt(5));
					test.setDuration(rs.getInt(6));

					test.setTestFee(rs.getInt(7));
					test.setExamId(rs.getInt(8));
									test.setOpen(openDate);
					if (rs.getString(10).equalsIgnoreCase("no CLosing Date")) {
						test.setclose(dateFormat.parse("0001-01-01"));
					} else {
						Date closeDate = dateFormat.parse(rs.getString(10));
						test.setclose(closeDate);
					}
					listOfAllTest.add(test);
				}
			}
		} catch (SQLException | ParseException e) {
			e.printStackTrace();
		}
		return listOfAllTest;
	}

	@Override
	public List<Test> viewAllTest(String type, int examId) {
		List<Test> listOfAllTest = new ArrayList<Test>();
		Test test = null;
		con = establishConnection();
		String query = "select * from test where testtype =? and examid=?";
		try {
			pst = con.prepareStatement(query);
			pst.setString(1, type);
			pst.setInt(2, examId);
			rs = pst.executeQuery();
			while (rs.next()) {
				test = new Test();
				test.setTestId(rs.getInt(1));
				test.setTestName(rs.getString(2));

				test.setTestType(rs.getString(3));

				test.setMaxQuestion(rs.getInt(4));
				test.setMaxMarks(rs.getInt(5));
				test.setDuration(rs.getInt(6));

				test.setTestFee(rs.getInt(7));
				test.setExamId(rs.getInt(8));

				Date openDate;

				openDate = dateFormat.parse(rs.getString(9));
				test.setOpen(openDate);
				if (rs.getString(10).equalsIgnoreCase("no CLosing Date")) {
					test.setclose(dateFormat.parse("0001-01-01"));
				} else {
					Date closeDate = dateFormat.parse(rs.getString(10));
					test.setclose(closeDate);
				}
				listOfAllTest.add(test);
			}
		} catch (SQLException | ParseException e) {
			e.printStackTrace();
		}
		return listOfAllTest;
	}

	@Override
	public List<Test> viewAllTest(int examId) {
		List<Test> listOfAllTest = new ArrayList<Test>();
		Test test = null;
		con = establishConnection();
		String query = "select * from test where examid=?";
		try {
			pst = con.prepareStatement(query);
			pst.setInt(1, examId);
			rs = pst.executeQuery();
			while (rs.next()) {
				test = new Test();
				test.setTestId(rs.getInt(1));
				test.setTestName(rs.getString(2));

				test.setTestType(rs.getString(3));

				test.setMaxQuestion(rs.getInt(4));
				test.setMaxMarks(rs.getInt(5));
				test.setDuration(rs.getInt(6));

				test.setTestFee(rs.getInt(7));
				test.setExamId(rs.getInt(8));
				Date openDate;

				openDate = dateFormat.parse(rs.getString(9));
				test.setOpen(openDate);
				if (rs.getString(10).equalsIgnoreCase("no CLosing Date")) {
					test.setclose(dateFormat.parse("0001-01-01"));
				} else {
					Date closeDate = dateFormat.parse(rs.getString(10));
					test.setclose(closeDate);
				}
				listOfAllTest.add(test);
			}
		} catch (SQLException | ParseException e) {
			e.printStackTrace();
		}
		return listOfAllTest;
	}
}
