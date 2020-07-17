package com.examhub.impl;

import static com.examhub.utility.DatabaseConnection.establishConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.examhub.dao.BlogDao;
import com.examhub.pojo.Blog;

public class BlogDaoImpl implements BlogDao {

	Connection con = null;
	PreparedStatement pst = null;
	ResultSet rs = null;

	@Override
	public boolean addBlog(Blog blog) {
		con = establishConnection();
		String query = "insert into   blog (blogtitle,blogdata,linkrealted,lastedited) values (?,?,?,?)";
		try {
			pst = con.prepareStatement(query);
			pst.setString(1, blog.getBlogTitle());
			pst.setString(2, blog.getBlogData());
			pst.setString(3, blog.getLinkRelated());
			pst.setString(4, blog.getLastEdited());

			int rowsAffected = pst.executeUpdate();
			if (rowsAffected > 0) {
				return true;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean editBlog(Blog blog) {
		con = establishConnection();
		String query = "update  blog set blogtitle=?,blogdata=?,linkrealted=?,lastedited=? where blogid=?";
		try {
			pst = con.prepareStatement(query);
			pst.setString(1, blog.getBlogTitle());
			pst.setString(2, blog.getBlogData());
			pst.setString(3, blog.getLinkRelated());
			pst.setString(4, blog.getLastEdited());
			pst.setInt(5, blog.getBlogId());
			int rowsAffected = pst.executeUpdate();
			if (rowsAffected > 0) {
				return true;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;

	}

	@Override
	public List<Blog> viewAllBlog() {
		List<Blog> listOfAllBlog = new ArrayList<>();
		con = establishConnection();
		String query = "select * from blog";
		try {
			pst = con.prepareStatement(query);
			rs = pst.executeQuery();
			while (rs.next()) {
				Blog blg = new Blog();
				blg.setBlogId(rs.getInt(1));
				blg.setBlogTitle(rs.getString(2));
				blg.setBlogData(rs.getString(3));
				blg.setLinkRelated(rs.getString(4));
				blg.setLastEdited(rs.getString(5));
				listOfAllBlog.add(blg);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return listOfAllBlog;
	}

	@Override
	public Blog viewBlog(int blogId) {
		con = establishConnection();
		String query = "select * from blog where blogid=?";
		try {
			pst = con.prepareStatement(query);
			pst.setInt(1, blogId);
			rs = pst.executeQuery();
			while (rs.next()) {
				Blog blg = new Blog();
				blg.setBlogId(rs.getInt(1));
				blg.setBlogTitle(rs.getString(2));
				blg.setBlogData(rs.getString(3));
				blg.setLinkRelated(rs.getString(4));
				blg.setLastEdited(rs.getString(5));
				return blg;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public boolean deleteBlog(int blogId) {
		con = establishConnection();
		String query = "delete from blog where blogid=?";
		try {
			pst = con.prepareStatement(query);
			pst.setInt(1, blogId);
			int rowsAffected = pst.executeUpdate();
			if (rowsAffected > 0) {
				return true;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

}
