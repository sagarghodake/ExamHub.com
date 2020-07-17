package com.examhub.pojo;

import java.util.Date;

public class Test {
	private int testId;
	private String testName,testType;
	private int maxQuestion,maxMarks,duration;
	private int testFee;
	private int examId;
	private Date open,close;
	
	public Date getOpen() {
		return open;
	}

	public void setOpen(Date open) {
		this.open = open;
	}

	public Date getclose() {
		return close;
	}

	public void setclose(Date close) {
		this.close = close;
	}

	public String getTestName() {
		return testName;
	}

	public void setTestName(String testName) {
		this.testName = testName;
	}

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

	
	public Test(){
		
	}

	public Test(int testId, String testType, int testFee, int examId) {
		super();
		this.testId = testId;
		this.testType = testType;
		this.testFee = testFee;
		this.examId = examId;
	}

	public int getTestId() {
		return testId;
	}

	public void setTestId(int testId) {
		this.testId = testId;
	}

	public String getTestType() {
		return testType;
	}

	public void setTestType(String testType) {
		this.testType = testType;
	}

	public int getTestFee() {
		return testFee;
	}

	public void setTestFee(int testFee) {
		this.testFee = testFee;
	}

	public int getExamId() {
		return examId;
	}

	public void setExamId(int examId) {
		this.examId = examId;
	}
	
	@Override
	public String toString() {
		return (testId+" "+testType+" "+testFee+" "+examId);
	}
}
