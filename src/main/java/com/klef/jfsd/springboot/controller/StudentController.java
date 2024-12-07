package com.klef.jfsd.springboot.controller;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.klef.jfsd.springboot.model.Event;
import com.klef.jfsd.springboot.model.EventRegistration;
import com.klef.jfsd.springboot.model.EventRegistrationHelper;
import com.klef.jfsd.springboot.model.Student;
import com.klef.jfsd.springboot.model.StudentEventAttendance;
import com.klef.jfsd.springboot.service.StudentService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class StudentController 
{
	@Autowired
	private StudentService studentService;
	
	@GetMapping("studenthome")
	public ModelAndView studenthome()
	{
		    ModelAndView mv = new ModelAndView();
		    List<Map<String, Object>> leaderboard = studentService.getLeaderboard().stream().map(row -> {
		        Map<String, Object> map = Map.of(
		            "studentId", row[0],
		            "studentName", row[1],
		            "attendanceCount", row[2]
		        );
		        return map;
		    }).collect(Collectors.toList());

		    System.out.println("Leaderboard Data: " + leaderboard); // Log the leaderboard
		    mv.setViewName("studenthome");
		    mv.addObject("leaderboard", leaderboard);
		    return mv;
		}
	
	@GetMapping("studentmyprofile")
	public ModelAndView studentprofile()
	{
		ModelAndView mv = new ModelAndView();
		mv.setViewName("studentmyprofile");
		return mv;
	}
	
	@GetMapping("displayallevents")
	public ModelAndView viewallevents(HttpServletRequest request) {
	    HttpSession session = request.getSession();
	    ModelAndView mv = new ModelAndView();
	    Student stu = (Student) session.getAttribute("student");
	    if (stu == null) {
	        mv.setViewName("sessionexpired");
	        return mv;
	    }

	    List<EventRegistration> regList = studentService.myEvents(stu.getId());
	    List<Event> eventList = studentService.viewAllEvents();

	    eventList.removeIf(event -> regList.stream()
	            .anyMatch(reg -> Long.compare(reg.getEvent().getEventid(), event.getEventid()) == 0));

	    eventList.removeIf(event -> event.getAvailableSlots() <= 0);

	    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	    DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");

	    eventList.removeIf(event -> {
	        try {
	            LocalDate eventDate = LocalDate.parse(event.getDate(), dateFormatter);
	            LocalTime eventTime = LocalTime.parse(event.getTime(), timeFormatter);
	            LocalDateTime eventDateTime = LocalDateTime.of(eventDate, eventTime);
	            return eventDateTime.isBefore(LocalDateTime.now());
	        } catch (Exception e) {
	            return true;
	        }
	    });

	    mv.setViewName("studentviewallevents");
	    mv.addObject("eventList", eventList);
	    return mv;
	}
	
	@PostMapping("registerevent")
	public String register(HttpServletRequest request)
	{
		long eventid = Long.parseLong(request.getParameter("eid"));
		String addeby = request.getParameter("addedby");
		long sid = Long.parseLong(request.getParameter("sid"));
		
		EventRegistration eventReg = new EventRegistration();
		eventReg.setAdmin(studentService.viewAdminByID(addeby));
		eventReg.setEvent(studentService.viewEventByID(eventid));
		eventReg.setStudent(studentService.viewStudentByID(sid));
		
		studentService.registerForEvent(eventReg);
		
		return "redirect:/displayallevents";
	}
	
	@GetMapping("stumyevents")
	public ModelAndView stumyevents(HttpServletRequest request) {
	    HttpSession session = request.getSession();
	    ModelAndView mv = new ModelAndView();
	    Student stu = (Student) session.getAttribute("student");
	    
	    if (stu == null) {
	        mv.setViewName("sessionexpired");
	        return mv;
	    }

	    List<EventRegistration> regList = studentService.myEvents(stu.getId());

	    List<EventRegistrationHelper> helperList = regList.stream().map(reg -> {
	        EventRegistrationHelper helper = new EventRegistrationHelper();
	        helper.setRegid(reg.getRegid());
	        helper.setStudent(reg.getStudent());
	        helper.setEvent(reg.getEvent());
	        helper.setAdmin(reg.getAdmin());

	        LocalDateTime now = LocalDateTime.now();
	        LocalDateTime eventDateTime = LocalDateTime.parse(
	            reg.getEvent().getDate() + " " + reg.getEvent().getTime(),
	            DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")
	        );

	        long minutesUntilEvent = Duration.between(now, eventDateTime).toMinutes();
	        helper.setCanUnregister(minutesUntilEvent > 30);

	        return helper;
	    }).toList();

	    mv.setViewName("studentmyevents");
	    mv.addObject("regList", helperList);
	    return mv;
	}

	
	@PostMapping("unregisterevent")
	public String unregisterevent(HttpServletRequest request)
	{
		long eid = Long.parseLong(request.getParameter("eid"));
		long sid = Long.parseLong(request.getParameter("sid"));
		studentService.unregisterEvent(sid, eid);		
		return "redirect:/stumyevents";
	}
	
	
	@GetMapping("stuupdateprofile")
	public ModelAndView stuupdateprofile()
	{
		return new ModelAndView("stuupdateprofile");
	}
	
	
	@PostMapping("stueditprofile")
	public ModelAndView editstudent(HttpServletRequest request, HttpServletResponse response) 
	{
	    long sid = Long.parseLong(request.getParameter("sid"));
	    String sname = request.getParameter("sname");
	    String sgender = request.getParameter("sgender");
	    String semail = request.getParameter("semail");
	    String scontact = request.getParameter("scontact");
	    String sdob = request.getParameter("sdob");

	    ModelAndView mv = new ModelAndView();
	    boolean isContactAvailable = studentService.isStudentContactAvailable(scontact);
	    boolean isEmailAvailable = studentService.isStudentEmailAvailable(semail);
	    HttpSession session = request.getSession();
	    Student s = (Student) session.getAttribute("student");

	    boolean isEmailChanged = !s.getEmail().equals(semail);
	    boolean isContactChanged = !s.getContact().equals(scontact);

	    if (s.getId() == sid && s.getName().equals(sname) 
	            && s.getGender().equals(sgender) && s.getDob().equals(sdob) && !isEmailChanged && !isContactChanged) {
	        return redirectWithMessage(mv, sid, "No Changes Detected");
	    }

	    if (isContactChanged && !isContactAvailable) {
	        return redirectWithMessage(mv, sid, "Contact Already Exists");
	    }
	    if (isEmailChanged && !isEmailAvailable) {
	        return redirectWithMessage(mv, sid, "Email Already Exists");
	    }

	    s.setName(sname);
	    s.setGender(sgender);
	    s.setDob(sdob);
	    if (isEmailChanged) {
	        s.setEmail(semail);
	    }
	    if (isContactChanged) {
	        s.setContact(scontact);
	    }

	    String updateMessage = studentService.updateStudent(s);
	    return redirectWithMessage(mv, sid, updateMessage);
	}

	private ModelAndView redirectWithMessage(ModelAndView mv, long sid, String message) {
	    try {
	        String encodedMessage = URLEncoder.encode(message, StandardCharsets.UTF_8.toString());
	        mv.setViewName("redirect:/studentmyprofile" + "?message=" + encodedMessage);
	    } catch (Exception e) {
	        mv.setViewName("exception");
	        mv.addObject("message", e.getMessage());
	    }
	    return mv;
	}
	
	@GetMapping("studentmyattendance")
	public ModelAndView studentmyattendance(HttpServletRequest request) {
	    HttpSession session = request.getSession();
	    Student s = (Student) session.getAttribute("student");
	    ModelAndView mv = new ModelAndView();

	    if (s != null) {
	        // Debugging: Print student ID
	        System.out.println("Fetching attendance for student ID: " + s.getId());

	        // Fetch the attendance list
	        List<StudentEventAttendance> attendanceList = studentService.myAttendance(s.getId());

	        // Debugging: Check the attendance list
	        if (attendanceList != null && !attendanceList.isEmpty()) {
	            System.out.println("Attendance list size: " + attendanceList.size());
	            mv.setViewName("studentmyattendance");
	            mv.addObject("attendanceList", attendanceList);
	        } else {
	            System.out.println("No attendance data found.");
	            mv.setViewName("noattendance");
	            mv.addObject("message", "No attendance data available.");
	        }
	    } else {
	        mv.setViewName("sessionexpired");
	    }
	    return mv;
	}

	
}
