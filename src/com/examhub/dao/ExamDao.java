package com.examhub.dao;

import java.util.*;

import com.examhub.pojo.Exam;

public interface ExamDao {
	boolean addExam(Exam exam);
	boolean updateExam(Exam exam);
	Exam viewExam(int examId);
	List<Exam>viewAllExam(int categoryId);
	boolean deleteExam(int examId);
	boolean deleteExamByCategory(int categoryId);
	List<Exam> viewAllExam();
}
