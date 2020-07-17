package com.examhub.pojo;

import java.util.*;

public class OnlineTest {
	private int testId,maxQuestion,maxMarks,duration;
	public int getMaxQuestion() {
		return maxQuestion;
	}
	public void setMaxQuestion(int maxQuestion) {
		this.maxQuestion = maxQuestion;
	}
	public int getMaxMarks() {
		return maxMarks;
	}
	public void setMaxMarks(int maxMarks) {
		this.maxMarks = maxMarks;
	}
	public int getDuration() {
		return duration;
	}
	public void setDuration(int duration) {
		this.duration = duration;
	}
	private int examId;
	private String type,testName;
	public String getTestName() {
		return testName;
	}
	public void setTestName(String testName) {
		this.testName = testName;
	}
	private String studentUsername;
	private List<Question> questionSet=new ArrayList<>();
	private List<String> answerListMarkedBystudent=new ArrayList<>();
	
	public int getTestId() {
		return testId;
	}
	public void setTestId(int testId) {
		this.testId = testId;
	}
	public int getExamId() {
		return examId;
	}
	public void setExamId(int examId) {
		this.examId = examId;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getStudentUsername() {
		return studentUsername;
	}
	public void setStudentUsername(String studentUsername) {
		this.studentUsername = studentUsername;
	}
	public List<Question> getQuestionSet() {
		return questionSet;
	}
	public void setQuestionSet(List<Question> questionSet) {
		this.questionSet = questionSet;
	}
	public List<String> getAnswerListMarkedBystudent() {
		return answerListMarkedBystudent;
	}
}
