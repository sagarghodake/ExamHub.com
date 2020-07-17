package com.examhub.impl;

import static com.examhub.utility.DatabaseConnection.establishConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.examhub.dao.StudyMaterrialDao;
import com.examhub.pojo.StudyMaterial;

public class StudyMaterialDaoImpl implements StudyMaterrialDao
{
	Connection con = null;
	PreparedStatement pst = null;
	ResultSet rs = null;

	@Override
	public boolean addStudyMaterial(StudyMaterial studyMaterial) {
		
		con = establishConnection();
		String query = "insert into  studymaterial values (?,?,?)";
		try {
			pst = con.prepareStatement(query);
			pst.setString(1, studyMaterial.getDocumentType());
			pst.setString(2, studyMaterial.getSubjectName());
			pst.setString(3, studyMaterial.getFilePath());
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
	public boolean editStudyMaterial(StudyMaterial studyMaterial) {
		con = establishConnection();
		String query = "update studymaterial set documenttype=?,subjectname=?,documentdatalink=? where documentid=?";
		try {
			pst = con.prepareStatement(query);
			pst.setString(1, studyMaterial.getDocumentType());
			pst.setString(2, studyMaterial.getSubjectName());
			pst.setString(3, studyMaterial.getFilePath());
			pst.setInt(4, studyMaterial.getDocumentId());
			
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
	public List<StudyMaterial> viewAllStudyMaterial() {
		List<StudyMaterial> listOfAllDocument = new ArrayList<>();
		con = establishConnection();
		String query = "select * from studymaterial";
		try {
			pst = con.prepareStatement(query);
			rs = pst.executeQuery();
			while (rs.next()) {
				StudyMaterial ass = new StudyMaterial();
				ass.setDocumentId(rs.getInt(1));
				ass.setDocumentType(rs.getString(2));
				ass.setSubjectName(rs.getString(3));
				
				ass.setFilePath(rs.getString(4));
				listOfAllDocument.add(ass);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return listOfAllDocument;
	}

	@Override
	public StudyMaterial viewStudyMaterial(int documentId) {
		con = establishConnection();
		String query = "select * from studymaterial where documentid=?";
		try {
			pst = con.prepareStatement(query);
			pst.setInt(1, documentId);
			rs = pst.executeQuery();
			while (rs.next()) {
				StudyMaterial ass = new StudyMaterial();
				ass.setDocumentId(rs.getInt(1));
				ass.setDocumentType(rs.getString(2));
				ass.setSubjectName(rs.getString(3));
				
				ass.setFilePath(rs.getString(4));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public boolean deleteStudyMaterial(int documentId) {
		con = establishConnection();
		String query = "delete from studymaterial  where documentid=?";
		try {
			pst = con.prepareStatement(query);
			pst.setInt(4, documentId);
			
			int rowsAffected = pst.executeUpdate();
			if (rowsAffected > 0) {
				return true;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;	}

}
