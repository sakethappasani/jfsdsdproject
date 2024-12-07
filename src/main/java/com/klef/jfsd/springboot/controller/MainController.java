package com.klef.jfsd.springboot.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.klef.jfsd.springboot.model.Admin;
import com.klef.jfsd.springboot.model.Faculty;
import com.klef.jfsd.springboot.model.Student;
import com.klef.jfsd.springboot.service.MainService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class MainController 
{
	@Autowired
	private MainService mainService;
	
	@GetMapping("")
	public ModelAndView landing()
	{
		ModelAndView mv = new ModelAndView("landing");
		return mv;
	}
	
	@GetMapping("login")
	public ModelAndView login()
	{
		ModelAndView mv = new ModelAndView("login");
		return mv;
	}
	
	@GetMapping("accountblocked")
	public ModelAndView accountblocked()
	{
		ModelAndView mv = new ModelAndView("accountblocked");
		return mv;
	}
	
	@PostMapping("checklogin")
	public ModelAndView checklogin(HttpServletRequest request, HttpServletResponse response)
	{
		String username = request.getParameter("uname");
		String password = request.getParameter("pwd");

		ModelAndView mv = new ModelAndView();
		
		Admin admin = mainService.checkAdminLogin(username, password);
		Student student = mainService.checkStudentLogin(username, password);
		Faculty faculty = mainService.checkfacultylogin(username, password);
		HttpSession session = request.getSession();
		
		if(admin != null)
		{
			session.setAttribute("admin", admin);
			mv.setViewName("adminhome");
		}
		else if(student != null)
		{
			if(student.isStatus())
			{				
				session.setAttribute("student", student);
				mv.setViewName("studenthome");
				return mv;
			}
			mv.setViewName("accountblocked");
		}
		else if(faculty != null)
		{
			if(faculty.isStatus())
			{
				session.setAttribute("faculty", faculty);
				mv.setViewName("facultyhome");
				return mv;
			}
			mv.setViewName("accountblocked");
		}
		else
		{
			mv.setViewName("login");
			mv.addObject("message", "Invalid Credentials");
		}
		return mv;
	}
	
	@GetMapping("sessionexpired")
	public ModelAndView sessionexipred()
	{
		ModelAndView mv = new ModelAndView("sessionexpired");
		return mv;
	}
	
	@GetMapping("logout")
	public ModelAndView logout(HttpServletRequest request)
	{
		ModelAndView mv = new ModelAndView();
		HttpSession session = request.getSession();
		session.invalidate();
		mv.setViewName("login");
		return mv;
	}
	
}