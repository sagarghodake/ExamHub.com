package com.examhub.dao;

import java.util.List;

import com.examhub.pojo.Question;

public interface QuestionDao {
	boolean addQuestion(Question question);
	boolean updateQuestion(Question question);
	boolean deleteQuestion(int questioId);
	boolean deleteQuestionByExam(int examId);
	Question viewQuestion(int questionId);
	List<Question> viewAllQuestion();
	List<Question> viewAllQuestion(int examId);
	List<Question> viewAllQuestion(int examId,int sectionId);
}
