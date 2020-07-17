package com.examhub.dao;

import java.util.List;

import com.examhub.pojo.Assignment;

public interface AssignmentDao {
	boolean addAssignment(Assignment assignment);
	boolean editAssignment(Assignment assignment);
	List<Assignment> viewAllAssignment();
	Assignment viewAssignment(int assignmentId);
	boolean deleteAssignment(int assignmentId);
	
}
