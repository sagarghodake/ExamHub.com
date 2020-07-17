package com.examhub.dao;

import java.util.List;

import com.examhub.pojo.Result;

public interface ResultDao {
	boolean isTestAttempted(int testId,String studentUsername);
	Result viewResult(int resultId);
	List<Result> viewAllResults();
	List<Result> viewAllResults(int testId);
	boolean addResult(Result result);
	Result viewResult(int testId, String studentUsername);
	boolean updateResult(String studentUsername, int testId, int certificateId);
}
