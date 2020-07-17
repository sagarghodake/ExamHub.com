package com.examhub.pojo;

public class Section {
	private int sectionId;
	private String sectionName;
	private int examId;
	
	public Section(){
		
	}

	public Section(int sectionId, String sectionName, int maxQuestion, int duration, int examId) {
		super();
		this.sectionId = sectionId;
		this.sectionName = sectionName;
		this.examId = examId;
	}

	public int getSectionId() {
		return sectionId;
	}

	public void setSectionId(int sectionId) {
		this.sectionId = sectionId;
	}

	public String getSectionName() {
		return sectionName;
	}

	public void setSectionName(String sectionName) {
		this.sectionName = sectionName;
	}

	public int getExamId() {
		return examId;
	}

	public void setExamId(int examId) {
		this.examId = examId;
	}
	
	@Override
	public String toString() {
		return (sectionId+" "+sectionName+"  "+examId);
	}
}
