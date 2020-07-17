package com.examhub.dao;

import java.util.List;

import com.examhub.pojo.Test;

public interface TestDao {
	boolean createTest(Test test);
	boolean updateTest(Test test);
	boolean daleteTest(int testId);
	Test viewTest(int testId);
	List<Test> viewAllTest();
	List<Test> viewAllTest(int examId);
	boolean deleteTestByExam(int examId);
	List<Test> viewAllTest(String type);
	List<Test> viewAllTest(String type, int examId);
	List<Test> viewAllUpcomingTest();
}
