package com.examhub.impl;

import java.sql.*;
import java.util.*;
import com.examhub.dao.SectionDao;
import com.examhub.pojo.Section;
import static com.examhub.utility.DatabaseConnection.establishConnection;

public class SectionDaoImpl implements SectionDao{
	Connection con=null;
	PreparedStatement pst=null;
	ResultSet rs=null;
	@Override
	public boolean addSection(Section section) {
		con=establishConnection();
		String query="insert into section(sectionname,examid) values(?,?)";
		
		try {
			pst=con.prepareStatement(query);
			pst.setString(1, section.getSectionName());
			pst.setInt(2, section.getExamId());
			
			
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
	public boolean updateSection(Section section) {
		con=establishConnection();
		String query="update section set sectionname=?,examid=? where sectionid=?";
		
		try {
			pst=con.prepareStatement(query);
			pst.setString(1, section.getSectionName());
			pst.setInt(2, section.getExamId());
			pst.setInt(3, section.getSectionId());
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
	public boolean deleteSection(int sectionId) {
		con=establishConnection();
		String query="delete from section where sectionid=?";
		
		try {
			pst=con.prepareStatement(query);
			pst.setInt(1, sectionId);
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
	public List<Section> viewAllSection() {
		List<Section> listOfAllSections=new ArrayList<Section>();
		con=establishConnection();
		String query="select * from section";
		try {
			pst=con.prepareStatement(query);
			rs=pst.executeQuery();
			while(rs.next()){
				Section section=new Section();
				section.setSectionId(rs.getInt(1));
				section.setSectionName(rs.getString(2));
				section.setExamId(rs.getInt(3));
				listOfAllSections.add(section);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return listOfAllSections;
	}

	@Override
	public List<Section> viewAllSection(int examId) {
		List<Section> listOfAllSections=new ArrayList<Section>();
		con=establishConnection();
		String query="select * from section where examid=?";
		try {
			pst=con.prepareStatement(query);
			pst.setInt(1, examId);
			rs=pst.executeQuery();
			while(rs.next()){
				Section section=new Section();
				section.setSectionId(rs.getInt(1));
				section.setSectionName(rs.getString(2));
				section.setExamId(rs.getInt(3));
				listOfAllSections.add(section);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return listOfAllSections;
	}

	@Override
	public Section viewSection(int sectionId) {
		Section section=null;
		con=establishConnection();
		String query="select * from section where sectionid=?";
		try {
			pst=con.prepareStatement(query);
			pst.setInt(1, sectionId);
			rs=pst.executeQuery();
			if(rs.next()){
				section=new Section();
				section.setSectionId(rs.getInt(1));
				section.setSectionName(rs.getString(2));
				section.setExamId(rs.getInt(3));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return section;
	}
	@Override
	public boolean deleteSectionByExam(int examId) {
		con=establishConnection();
		String query="delete from section where examid=?";
		
		try {
			pst=con.prepareStatement(query);
			pst.setInt(1, examId);
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
