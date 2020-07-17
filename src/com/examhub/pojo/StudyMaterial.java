package com.examhub.pojo;

public class StudyMaterial {

	private int documentId;
	private String subjectName,documentType,filePath;
	
	
	@Override
	public String toString() {
		return "StudyMaterial [documentId=" + documentId + ", subjectName=" + subjectName + ", documentType="
				+ documentType + ", filePath=" + filePath + "]";
	}
	public int getDocumentId() {
		return documentId;
	}
	public void setDocumentId(int documentId) {
		this.documentId = documentId;
	}
	public String getSubjectName() {
		return subjectName;
	}
	public void setSubjectName(String subjectName) {
		this.subjectName = subjectName;
	}
	public String getDocumentType() {
		return documentType;
	}
	public void setDocumentType(String documentType) {
		this.documentType = documentType;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	

}
