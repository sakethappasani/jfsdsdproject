package com.klef.jfsd.springboot.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.klef.jfsd.springboot.model.Admin;
import com.klef.jfsd.springboot.model.Faculty;
import com.klef.jfsd.springboot.model.Student;
import com.klef.jfsd.springboot.repository.AdminRepository;
import com.klef.jfsd.springboot.repository.FacultyRepository;
import com.klef.jfsd.springboot.repository.StudentRepository;

@Service
public class MainServiceImpl implements MainService
{
	
	@Autowired
	private AdminRepository adminRepository;
	@Autowired
	private FacultyRepository facultyRepository;
	@Autowired
	private StudentRepository studentRepository;
	
	@Override
	public Admin checkAdminLogin(String username, String password) 
	{
		return adminRepository.checkAdminLogin(username, password);
	}
	
	@Override
	public Student checkStudentLogin(String id, String password) 
	{
		try
		{
			long sid = Long.parseLong(id);
			return studentRepository.checkStudentLogin(sid, password);
		}
		catch(NumberFormatException e)
		{
			return null;
		}
	}
	
	@Override
	public Faculty checkfacultylogin(String id, String pwd) 
	{
		try
		{
			long fid = Long.parseLong(id);
			return facultyRepository.checkFacultyLogin(fid, pwd);
		}
		catch (NumberFormatException e) 
		{
			return null;
		}
	}
	
}
