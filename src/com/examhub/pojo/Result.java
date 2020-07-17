package com.examhub.pojo;

public class Result {
	private int resultId;
	private String studUsername;
	private int testId, maxQuestions, maxMarks, attempted, correct, obtained, view;

	public Result() {

	}

	public int getResultId() {
		return resultId;
	}

	public void setResultId(int resultId) {
		this.resultId = resultId;
	}

	public String getStudUsername() {
		return studUsername;
	}

	public void setStudUsername(String studUsername) {
		this.studUsername = studUsername;
	}

	public int getTestId() {
		return testId;
	}

	public void setTestId(int testId) {
		this.testId = testId;
	}

	public int getMaxQuestions() {
		return maxQuestions;
	}

	public void setMaxQuestions(int maxQuestions) {
		this.maxQuestions = maxQuestions;
	}

	public int getMaxMarks() {
		return maxMarks;
	}

	public void setMaxMarks(int maxMarks) {
		this.maxMarks = maxMarks;
	}

	public int getAttempted() {
		return attempted;
	}

	public void setAttempted(int attempted) {
		this.attempted = attempted;
	}

	public int getCorrect() {
		return correct;
	}

	public void setCorrect(int correct) {
		this.correct = correct;
	}

	public int getObtained() {
		return obtained;
	}

	public void setObtained(int obtained) {
		this.obtained = obtained;
	}

	public int getView() {
		return view;
	}

	public void setView(int view) {
		this.view = view;
	}

	@Override
	public boolean equals(Object obj) {
		if (obj instanceof Result) {
			Result result = (Result) obj;
			if (result.getResultId() == this.getResultId() && result.getTestId() == this.getTestId()
					&& result.getStudUsername().equalsIgnoreCase(this.getStudUsername())) {
				return true;
			}
		}
		return false;
	}
}
