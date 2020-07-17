package com.examhub.dao;

import java.util.List;

import com.examhub.pojo.StudyMaterial;

public interface StudyMaterrialDao {
	boolean addStudyMaterial(StudyMaterial studyMaterial);
	boolean editStudyMaterial(StudyMaterial studyMaterial);
	List<StudyMaterial> viewAllStudyMaterial();
	StudyMaterial viewStudyMaterial(int documentId);
	boolean deleteStudyMaterial(int documentId);
	
}
