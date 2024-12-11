package com.klef.jfsd.springboot.controller;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.klef.jfsd.springboot.model.Event;
import com.klef.jfsd.springboot.model.EventRegistration;
import com.klef.jfsd.springboot.model.Faculty;
import com.klef.jfsd.springboot.model.FacultyEventMapping;
import com.klef.jfsd.springboot.model.Student;
import com.klef.jfsd.springboot.model.StudentEventAttendance;
import com.klef.jfsd.springboot.service.FacultyService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class FacultyController 
{

	@Autowired
	private FacultyService facultyService;
	
	@GetMapping("facultyhome")
	public ModelAndView facultyhome()
	{
		ModelAndView mv = new ModelAndView();
		mv.setViewName("facultyhome");
		return mv;
	}
	
	@GetMapping("facultymyprofile")
	public ModelAndView myprofile()
	{
		ModelAndView mv = new ModelAndView();
		mv.setViewName("facultymyprofile");
		return mv;
	}
	
	@GetMapping("facultymyevents")
	public ModelAndView myevents(HttpServletRequest request)
	{
		ModelAndView mv = new ModelAndView();
		
		HttpSession session = request.getSession();
		Faculty faculty =  (Faculty) session.getAttribute("faculty");
		if(faculty == null)
		{
			mv.setViewName("sessionexpired");
			return mv;
		}
		List<FacultyEventMapping> femList = facultyService.viewMyEvents(faculty.getId());
		mv.setViewName("facultymyevents");
		mv.addObject("femList", femList);
		return mv;
	}
	
	@PostMapping("facultyviewstudents")
	public ModelAndView facultyviewallstudents(HttpServletRequest request)
	{
		long eventid = Long.parseLong(request.getParameter("eid"));
		ModelAndView mv = new ModelAndView();
		mv.setViewName("facultyviewstudents");
		List<EventRegistration> regList = facultyService.viewEventRegistrations(eventid);
		mv.addObject("regList", regList);
		return mv; 
	}

	@GetMapping("attendancemsg")
	public ModelAndView attendancealreadyposted() 
	{
		ModelAndView mv = new ModelAndView();
		mv.setViewName("attendancemsg");
		return mv;
	}
	
	@PostMapping("postattendance")
	public ModelAndView attendance(HttpServletRequest request)
	{
		long eventid = Long.parseLong(request.getParameter("eid"));
		ModelAndView mv = new ModelAndView();
		boolean isAttendancePosted = facultyService.isAttendacePosted(eventid);
		if(isAttendancePosted)
		{
			mv.setViewName("attendancemsg");
			mv.addObject("msg", "Attendace Already Posted");
			mv.addObject("flag", false);
			return mv;
		}
		else
		{			
			mv.setViewName("facultypostattendance");
			List<EventRegistration> regList = facultyService.viewEventRegistrations(eventid);
			mv.addObject("regList", regList);
			return mv;
		}
	}
	
	@GetMapping("attendancepostedsuccess")
	public ModelAndView attendancepostedsuccess()
	{
		ModelAndView mv = new ModelAndView();
		mv.setViewName("attendancepostedsuccess");
		return mv;
	}
	
	@PostMapping("markattedance")
	public ModelAndView markattendance(HttpServletRequest request)
	{
		long eid = Long.parseLong(request.getParameter("eid"));
		List<EventRegistration> studentList = facultyService.viewEventRegistrations(eid);
		int n = studentList.size();
		List<StudentEventAttendance> attendanceList = new ArrayList<>();
		
	//need to change the mapping !!!	
		
		for(int i = 0; i < n; i++)
		{
			String res = request.getParameter("attendance"+(i+1));
			boolean status = (res!= null && res.equals("on")) ? false: true;
			Student student = facultyService.getStudentById(studentList.get(i).getStudent().getId());
			Event event = facultyService.getEventById(eid);
			attendanceList.add(new StudentEventAttendance(student, event, status));
		}
		String msg = facultyService.saveAttendance(attendanceList);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("attendancemsg");
		mv.addObject("msg", msg);
		mv.addObject("flag", true);
		return mv;
	}
	
	@GetMapping("facultyupdatemyprofile")
	public ModelAndView facultyupdatemyprofile()
	{
		ModelAndView mv = new ModelAndView();
		mv.setViewName("facultyupdatemyprofile");
		return mv;
	}
	
	@PostMapping("facultysaveupdate")
	public ModelAndView editFaculty(HttpServletRequest request, HttpServletResponse response) {
	    long fid = Long.parseLong(request.getParameter("fid"));
	    String fname = request.getParameter("fname");
	    String fdept = request.getParameter("fdept");
	    String femail = request.getParameter("femail");
	    String fcontact = request.getParameter("fcontact");
	    String fgender = request.getParameter("fgender");

	    ModelAndView mv = new ModelAndView();
	    boolean isContactAvailable = facultyService.isFacultyContactAvailable(fcontact);
	    boolean isEmailAvailable = facultyService.isFacultyEmailAvailable(femail);
	    Faculty faculty = facultyService.viewFacultyByID(fid);

	    boolean isEmailChanged = !faculty.getEmail().equals(femail);
	    boolean isContactChanged = !faculty.getContact().equals(fcontact);

	    if (faculty.getId() == fid && faculty.getName().equals(fname)
	            && faculty.getDepartment().equals(fdept) && faculty.getGender().equals(fgender)
	            && !isEmailChanged && !isContactChanged) {
	        return facultyRedirectWithMessage(mv, fid, "No Changes Detected");
	    }

	    if (isContactChanged && !isContactAvailable) {
	        return facultyRedirectWithMessage(mv, fid, "Contact Already Exists");
	    }
	    if (isEmailChanged && !isEmailAvailable) {
	        return facultyRedirectWithMessage(mv, fid, "Email Already Exists");
	    }

	    faculty.setName(fname);
	    faculty.setDepartment(fdept);
	    faculty.setGender(fgender);
	    if (isEmailChanged) {
	        faculty.setEmail(femail);
	    }
	    if (isContactChanged) {
	        faculty.setContact(fcontact);
	    }

	    String updateMessage = facultyService.updateFaculty(faculty);
	    return facultyRedirectWithMessage(mv, fid, updateMessage);
	}

	private ModelAndView facultyRedirectWithMessage(ModelAndView mv, long fid, String message) {
	    try {
	        String encodedMessage = URLEncoder.encode(message, StandardCharsets.UTF_8.toString());
	        mv.setViewName("redirect:/facultymyprofile?message=" + encodedMessage); // Fixed redirect path
	        
	    } catch (Exception e) {
	        mv.setViewName("exception");
	        mv.addObject("message", e.getMessage());
	    }
	    return mv;
	}
	
}
