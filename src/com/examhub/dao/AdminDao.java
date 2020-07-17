package com.examhub.dao;

public interface AdminDao {
	boolean login(String username,String password);
	boolean changePassword(String username,String newPassword);
}
