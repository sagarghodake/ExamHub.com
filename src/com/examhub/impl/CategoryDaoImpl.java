package com.examhub.impl;
import java.sql.*;
import java.util.*;
import com.examhub.dao.CategoryDao;
import com.examhub.pojo.Category;
import static com.examhub.utility.DatabaseConnection.establishConnection;
public class CategoryDaoImpl implements CategoryDao {
	Connection con=null;
	PreparedStatement pst=null;
	ResultSet rs=null;
	@Override
	public boolean addCategory(Category category) {
		con=establishConnection();
		String query="insert into category (categoryname) values(?)";
		try{
			pst=con.prepareStatement(query);
			pst.setString(1,category.getCategoryName());
			
			int rowsAffected=pst.executeUpdate();
			if(rowsAffected>0){
				return true;
			}
		}
		catch(SQLException e){
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean updateCategory(Category category) {
		con=establishConnection();
		String query="update category set categoryname=? where categoryid=?";
		try{
			pst=con.prepareStatement(query);
			pst.setString(1, category.getCategoryName());
			pst.setInt(2, category.getCategoryId());
			int rowsAffected=pst.executeUpdate();
			if(rowsAffected>0){
				return true;
			}
		}
		catch(SQLException e){
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public Category viewCategory(int categoryId) {
		Category cat=null;
		con=establishConnection();
		String query="select * from category where categoryid=?";
		try {
			pst=con.prepareStatement(query);
			pst.setInt(1, categoryId);
			rs=pst.executeQuery();
			if(rs.next()){
			cat=new Category();	
			cat.setCategoryId(rs.getInt(1));
			cat.setCategoryName(rs.getString(2));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cat;
	}

	@Override
	public List<Category> viewAllCategories() {
		List<Category> listOfAllCategory=new ArrayList<>();
		con=establishConnection();
		String query="select * from category";
		try {
			pst=con.prepareStatement(query);
			rs=pst.executeQuery();
			while(rs.next()){
				Category cat=new Category();
				cat.setCategoryId(rs.getInt(1));
				cat.setCategoryName(rs.getString(2));
				listOfAllCategory.add(cat);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return listOfAllCategory;
	}

	@Override
	public boolean deleteCatetegory(int categoryId) {
		con=establishConnection();
		String query="delete from category where categoryid=?";
		try {
			pst=con.prepareStatement(query);
			pst.setInt(1, categoryId);
			int rowsAffected=pst.executeUpdate();
			if(rowsAffected>0){
				return true;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
}

