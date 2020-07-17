package com.examhub.dao;

import java.util.*;

import com.examhub.pojo.Category;

public interface CategoryDao {
	boolean addCategory(Category category);
	boolean updateCategory(Category category);
	Category viewCategory(int categoryId);
	List<Category> viewAllCategories();
	boolean deleteCatetegory(int categoryId);
}
