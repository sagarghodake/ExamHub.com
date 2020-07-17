package com.examhub.pojo;

public class Exam {
	private int examId;
	private String examName;
	private int categoryId;
	
	public Exam(){
		
	}

	public Exam(int examId, String examName, int maxQuestion, int categoryId) {
		super();
		this.examId = examId;
		this.examName = examName;
		this.categoryId = categoryId;
	}

	public int getExamId() {
		return examId;
	}

	public void setExamId(int examId) {
		this.examId = examId;
	}

	public String getExamName() {
		return examName;
	}

	public void setExamName(String examName) {
		this.examName = examName;
	}

	
	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}
	
	@Override
	public String toString() {
		return (examId+" "+examName+"  "+categoryId);
	}
	
}
