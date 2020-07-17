package com.examhub.pojo;

public class Student extends User {
	private String name;
	private String address;
	private String gender;
	private String dateOfBirth;
	private String email;
	private String contact;
	private String regDate;
	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public Student() {
	
	}
	
	public Student(String name, String address, String gender, String dateOfBirth, String email, String contact) {
		super();
		this.name = name;
		this.address = address;
		this.gender = gender;
		this.dateOfBirth = dateOfBirth;
		this.email = email;
		this.contact = contact;
	}
	

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(String dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	@Override
	public String toString() {
		return (name+" "+address+" "+gender+" "+dateOfBirth+" "+email+" "+contact+" "+getPassword());
	}
}
