package com.examhub.dao;

import java.util.*;

import com.examhub.pojo.Student;

public interface StudentDao extends AdminDao {
	
	boolean registerStudent(Student student);
	boolean updateProfile(Student student);
	List<Student> viewAllStudent();
	Student viewProfile(String username);
	boolean login(String username, String password);
	boolean changePassword(String username,String newPassword);
	
}
