package com.examhub.pojo;

public class Blog {

	private int blogId;
	private String blogTitle,blogData,linkRelated,lastEdited;
	
	
	
	@Override
	public String toString() {
		return "Blog [blogId=" + blogId + ", blogTitle=" + blogTitle + ", blogData=" + blogData + ", linkRelated="
				+ linkRelated + "]";
	}
	public int getBlogId() {
		return blogId;
	}
	public void setBlogId(int blogId) {
		this.blogId = blogId;
	}
	public String getBlogTitle() {
		return blogTitle;
	}
	public void setBlogTitle(String blogTitle) {
		this.blogTitle = blogTitle;
	}
	public String getLastEdited() {
		return lastEdited;
	}
	public void setLastEdited(String lastEdited) {
		this.lastEdited = lastEdited;
	}
	public String getBlogData() {
		return blogData;
	}
	public void setBlogData(String blogData) {
		this.blogData = blogData;
	}
	public String getLinkRelated() {
		return linkRelated;
	}
	public void setLinkRelated(String linkRelated) {
		this.linkRelated = linkRelated;
	}
	
	
}
