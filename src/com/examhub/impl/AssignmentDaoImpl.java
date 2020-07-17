package com.examhub.impl;

import static com.examhub.utility.DatabaseConnection.establishConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.examhub.dao.AssignmentDao;
import com.examhub.pojo.Assignment;

public class AssignmentDaoImpl implements AssignmentDao {
	Connection con = null;
	PreparedStatement pst = null;
	ResultSet rs = null;

	@Override
	public boolean addAssignment(Assignment assignment) {
		con = establishConnection();
		String query = "insert into  assignment values (?,?)";
		try {
			pst = con.prepareStatement(query);
			pst.setString(1, assignment.getAssignmentData());
			pst.setString(2, assignment.getSubjectName());

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
	public boolean editAssignment(Assignment assignment) {
		con = establishConnection();
		String query = "update  assignment set assignmentdata=?,subjectname=? where assignmentid=?";
		try {
			pst = con.prepareStatement(query);
			pst.setString(1, assignment.getAssignmentData());
			pst.setString(2, assignment.getSubjectName());
			pst.setInt(3, assignment.getAssignementId());

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
	public List<Assignment> viewAllAssignment() {
		List<Assignment> listOfAllAssignment = new ArrayList<>();
		con = establishConnection();
		String query = "select * from assignment";
		try {
			pst = con.prepareStatement(query);
			rs = pst.executeQuery();
			while (rs.next()) {
				Assignment ass = new Assignment();
				ass.setAssignementId(rs.getInt(1));
				ass.setAssignmentData(rs.getString(2));
				ass.setSubjectName(rs.getString(3));
				listOfAllAssignment.add(ass);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return listOfAllAssignment;
	}

	@Override
	public Assignment viewAssignment(int assignmentId) {
		con = establishConnection();
		String query = "select * from assignment where assignmentid=?";
		try {
			pst = con.prepareStatement(query);
			pst.setInt(1, assignmentId);
			rs = pst.executeQuery();
			while (rs.next()) {
				Assignment ass = new Assignment();

				ass.setAssignementId(rs.getInt(1));
				ass.setAssignmentData(rs.getString(2));
				ass.setSubjectName(rs.getString(3));
				return ass;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public boolean deleteAssignment(int assignmentId) {
		con = establishConnection();
		String query = "delete  from assignment where assignmentid=?";
		try {
			pst = con.prepareStatement(query);
			pst.setInt(1, assignmentId);

			int rowsAffected = pst.executeUpdate();
			if (rowsAffected > 0) {
				return true;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

}
