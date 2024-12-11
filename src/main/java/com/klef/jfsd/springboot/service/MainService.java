package com.klef.jfsd.springboot.service;

import com.klef.jfsd.springboot.model.Admin;
import com.klef.jfsd.springboot.model.Faculty;
import com.klef.jfsd.springboot.model.Student;

public interface MainService 
{
	public Admin checkAdminLogin(String username, String password);
	public Student checkStudentLogin(String id, String password);
	public Faculty checkfacultylogin(String id, String pwd);
	public long getStudentCount();
	public long getFacultyCount();
	public long getEventCount();
}
