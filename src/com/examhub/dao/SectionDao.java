package com.examhub.dao;

import java.util.List;

import com.examhub.pojo.Section;

public interface SectionDao {
	boolean addSection(Section section);
	boolean updateSection(Section section);
	boolean deleteSection(int sectionId);
	List<Section> viewAllSection();
	List<Section> viewAllSection(int examId);
	Section viewSection(int sectionId);
	boolean deleteSectionByExam(int examId);
}
