package com.klef.jfsd.springboot.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "faculty_table")
public class Faculty 
{
	@Id
	@Column(name = "fid")
	private long id;
	@Column(name = "fname", nullable = false, length = 50)
	private String name;
	@Column(name = "fdept", nullable = false, length = 30)
	private String department;
	@Column(name = "femail", nullable = false, unique = true, length = 50)
	private String email;
	@Column(name = "fcontact", nullable = false, unique = true, length = 10)
	private String contact;
	@Column(name =  "fgender", nullable = false, length = 6)
	private String gender;
	@Column(name = "fpwd", nullable = false)
	private String password;
	@Column(name = "fstatus", length = 6, nullable = false)
	private boolean status;
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
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
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public boolean isStatus() {
		return status;
	}
	public void setStatus(boolean status) {
		this.status = status;
	}
}
