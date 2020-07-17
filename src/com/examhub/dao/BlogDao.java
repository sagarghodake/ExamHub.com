package com.examhub.dao;

import java.util.List;

import com.examhub.pojo.Blog;

public interface BlogDao {
	boolean addBlog(Blog blog);
	boolean editBlog(Blog blog);
	List<Blog> viewAllBlog();
	Blog viewBlog(int blogId);
	boolean deleteBlog(int blogId);
	
}
