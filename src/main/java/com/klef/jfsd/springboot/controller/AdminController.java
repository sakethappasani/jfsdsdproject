package com.klef.jfsd.springboot.controller;

import java.util.List;
import javax.sql.rowset.serial.SerialBlob;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Blob;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.klef.jfsd.springboot.model.Admin;
import com.klef.jfsd.springboot.model.Event;
import com.klef.jfsd.springboot.model.EventRegistration;
import com.klef.jfsd.springboot.model.Faculty;
import com.klef.jfsd.springboot.model.FacultyEventMapping;
import com.klef.jfsd.springboot.model.Student;
import com.klef.jfsd.springboot.service.AdminService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class AdminController 
{
	@Autowired
	private AdminService adminService;
	
	@GetMapping("adminhome")
	public ModelAndView adminhome()
	{
		ModelAndView mv = new ModelAndView();
		mv.setViewName("adminhome");
		mv.addObject("studentCount", adminService.getStudentCount());
		mv.addObject("facultyCount", adminService.getFacultyCount());
		mv.addObject("eventCount", adminService.getEventCount());
		return mv;
	}
	
	@GetMapping("addstudent")
	public ModelAndView addstudent()
	{
		ModelAndView mv = new ModelAndView();
		mv.setViewName("addstudent");
		return mv;
	}
	
	@PostMapping("insertstudent")
	public ModelAndView insertStudent(HttpServletRequest request, HttpServletResponse response)
	{
		long id =  Long.parseLong(request.getParameter("sid"));
		String name =  request.getParameter("sname");
		String gender = request.getParameter("sgender");
		String email = request.getParameter("semail");
		String contact = request.getParameter("scontact");
		String dob = request.getParameter("sdob");
		String pwd = request.getParameter("spwd");
		boolean status = true;
		
		Student s = new Student();
		
		s.setId(id);
		s.setName(name);
		s.setGender(gender);
		s.setEmail(email);
		s.setContact(contact);
		s.setDob(dob);
		s.setPwd(pwd);
		s.setStatus(status);
		
		String msg = adminService.addStudent(s);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("addstudent");
		mv.addObject("message", msg);
		return mv;
	}

	@GetMapping("viewallstudents")
	public ModelAndView viewallstudents()
	{
		ModelAndView mv = new ModelAndView();
		mv.setViewName("viewallstudents");
		
		List<Student> studentList = adminService.viewAllStudents();
		mv.addObject("studentList", studentList);
		return mv;
	}
	
	@GetMapping("managestudent")
	public ModelAndView managestudent()
	{
		ModelAndView mv = new ModelAndView();
		mv.setViewName("managestudent");
		List<Student> studentList = adminService.viewAllStudents();
		mv.addObject("studentList", studentList);
		return mv;
	}
	
	@GetMapping("adminupdatestudent")
	public ModelAndView adminupdatestudent( @RequestParam long sid )
	{
		ModelAndView mv = new ModelAndView();
		Student student = adminService.viewStudentById(sid);
		mv.setViewName("adminupdatestudent");
		mv.addObject("student", student);
		return mv;
	}
	
	@PostMapping("editstudent")
	public ModelAndView editstudent(HttpServletRequest request, HttpServletResponse response) 
	{
	    long sid = Long.parseLong(request.getParameter("sid"));
	    String sname = request.getParameter("sname");
	    String sgender = request.getParameter("sgender");
	    String semail = request.getParameter("semail");
	    String scontact = request.getParameter("scontact");
	    String sdob = request.getParameter("sdob");

	    ModelAndView mv = new ModelAndView();
	    boolean isContactAvailable = adminService.isStudentContactAvailable(scontact);
	    boolean isEmailAvailable = adminService.isStudentEmailAvailable(semail);
	    Student s = adminService.viewStudentById(sid);

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

	    String updateMessage = adminService.updateStudent(s);
	    return redirectWithMessage(mv, sid, updateMessage);
	}

	private ModelAndView redirectWithMessage(ModelAndView mv, long sid, String message) {
	    try {
	        String encodedMessage = URLEncoder.encode(message, StandardCharsets.UTF_8.toString());
	        mv.setViewName("redirect:/adminupdatestudent?sid=" + sid + "&message=" + encodedMessage);
	    } catch (Exception e) {
	        mv.setViewName("exception");
	        mv.addObject("message", e.getMessage());
	    }
	    return mv;
	}

	@GetMapping("addevent")
	public ModelAndView addevent()
	{
		ModelAndView mv = new ModelAndView();
		
		return mv;
	}
	
	@PostMapping("insertevent")
	public ModelAndView insertevent(HttpServletRequest request, @RequestParam("eimage") MultipartFile file) throws Exception
	{
		ModelAndView mv = new ModelAndView();
		String msg = "";
		try
		{
		String name = request.getParameter("ename");
		String desc = request.getParameter("edescription");
		String category = request.getParameter("ecategory");
		String addedby = request.getParameter("eaddedby");
		String venue = request.getParameter("evenue");
		int totalslots = Integer.parseInt(request.getParameter("totalslots"));
		String time = request.getParameter("etime");
		String date = request.getParameter("edate");
		int availableslots = totalslots;
		
		byte[] bytes = file.getBytes();
		Blob blob = new SerialBlob(bytes);
		
		Event e = new Event();
		e.setName(name);
		e.setDescription(desc);
		e.setCategory(category);
		e.setAddedby(addedby);
		e.setVenue(venue);
		e.setAvailableSlots(availableslots);
		e.setTotalslots(totalslots);
		e.setImage(blob);
		e.setDate(date);
		e.setTime(time);
		
		msg =  adminService.addEvent(e);
		mv.setViewName("addevent");
		mv.addObject("message", msg);
		}
		catch (Exception e) 
		{
			msg = e.getMessage();
			mv.setViewName("addevent");
			mv.addObject("message", msg);
		}
		return mv;
	}
	
	@GetMapping("viewallevents")
	public ModelAndView viewallevents()
	{
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("viewallevents");
		List<Event> eventsList = adminService.viewAllEvents();
		mv.addObject("eventList", eventsList);
		return mv;
	}
	
	@GetMapping("eventimage")
	public ResponseEntity<byte[]> vieweventimage(@RequestParam("eid") long id) throws SQLException
	{
		Event event = adminService.viewEventByID(id);
		byte[] imageBytes = null;
		imageBytes = event.getImage().getBytes(1, (int)event.getImage().length());
		
		return ResponseEntity.ok().contentType(MediaType.IMAGE_JPEG).body(imageBytes);
	}
	
	@PostMapping("deleteevent")
	public String deleteevent(@RequestParam("eid") long id)
	{
		adminService.deleteEvent(id);
		return "redirect:/myevents";
	}
	
	@GetMapping("myevents")
	public ModelAndView myevents(HttpSession session)
	{
		ModelAndView mv = new ModelAndView();
		Admin admin = (Admin) session.getAttribute("admin");
		if(admin == null)
		{
			mv.setViewName("sessionexpired");
			return mv;
		}
		mv.setViewName("adminmyevents");
		List<Event> eventsList = adminService.myEvents(admin.getUsername());
		mv.addObject("eventList", eventsList);
		return mv;
	}
	
	@GetMapping("editevent")
	public ModelAndView editEvent(@RequestParam("eid") int eventId) 
	{
		ModelAndView mv = new ModelAndView();
		Event event = adminService.viewEventByID(eventId);
		mv.setViewName("updateevent");
		mv.addObject("event", event);
		return mv;
	}
	
	@PostMapping("saveeditevent")
	public ModelAndView updateEvent(HttpServletRequest request, @RequestParam("eimage") MultipartFile file) throws Exception {
	    ModelAndView mv = new ModelAndView();
	    String msg = "";
	    try {
	        int eventId = Integer.parseInt(request.getParameter("eventId"));
	        String name = request.getParameter("ename");
	        String desc = request.getParameter("edescription");
	        String category = request.getParameter("ecategory");
	        String addedby = request.getParameter("eaddedby");
	        String venue = request.getParameter("evenue");
	        String date = request.getParameter("edate");
	        String time = request.getParameter("etime");

	        Event event = adminService.viewEventByID(eventId);
	        if (event != null) {
	            event.setName(name);
	            event.setDescription(desc);
	            event.setCategory(category);
	            event.setAddedby(addedby);
	            event.setVenue(venue);
	            event.setDate(date);
	            event.setTime(time);

	            if (!file.isEmpty()) {
	                byte[] bytes = file.getBytes();
	                Blob blob = new SerialBlob(bytes);
	                event.setImage(blob);
	            }

	            msg = adminService.updateEvent(event);
	            mv.setViewName("updateevent");
	            mv.addObject("message", "Event updated successfully");
	        } else {
	            msg = "Event not found";
	            mv.setViewName("errorpage");
	            mv.addObject("message", msg);
	        }
	    } catch (Exception e) {
	        msg = e.getMessage();
	        mv.setViewName("updateevent");
	        mv.addObject("message", msg);
	    }
	    return mv;
	}
	
	@GetMapping("blockstudent/{sid}")
	public String blockstudent(@PathVariable("sid") long sid)
	{
		adminService.updateStudentStatus(sid, false);
		return "redirect:/managestudent";
	}
	
	@GetMapping("unblockstudent/{id}")
	public String unblockstudent(@PathVariable long id)
	{
		adminService.updateStudentStatus(id, true);
		return "redirect:/managestudent";
	}

	@PostMapping("viewregstudents")
	public ModelAndView viewRegisteredStudents(HttpServletRequest request) 
	{
		long eid = Long.parseLong(request.getParameter("eid"));
	    HttpSession session = request.getSession();
	    ModelAndView mv = new ModelAndView();
	    Admin admin = (Admin) session.getAttribute("admin");
	    if (admin == null) 
	    {
	        mv.setViewName("sessionexpired");
	        return mv;
	    }
	    List<EventRegistration> regList = adminService.viewRegisteredStudents(admin.getUsername(), eid);

	    mv.setViewName("viewregstudents");
	    mv.addObject("regList", regList);
	    return mv;
	}

	@GetMapping("addfaculty")
	public ModelAndView addfaculty()
	{
		ModelAndView mv = new ModelAndView();
		mv.setViewName("addfaculty");
		return mv;
	}
	
	@PostMapping("insertfaculty")
	public ModelAndView insertfaculty(HttpServletRequest request, HttpServletResponse response)
	{
		
		long fid =  Long.parseLong(request.getParameter("fid"));
		String fname = request.getParameter("fname");
		String fdept = request.getParameter("fdept");
		String fgender = request.getParameter("fgender");
		String femail = request.getParameter("femail");
		String fcontact = request.getParameter("fcontact");
		String fpwd = request.getParameter("fpwd");
		boolean fstatus = true;
		
		Faculty faculty = new Faculty();
		
		faculty.setId(fid);
		faculty.setName(fname);
		faculty.setDepartment(fdept);
		faculty.setEmail(femail);
		faculty.setContact(fcontact);
		faculty.setGender(fgender);
		faculty.setPassword(fpwd);
		faculty.setStatus(fstatus);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("addfaculty");
		String msg = adminService.addFaculty(faculty);
		mv.addObject("message", msg);
		return mv;
	}
	
	@GetMapping("viewallfaculty")
	public ModelAndView viewAllFaculty() 
	{
		List<Faculty> facultyList = adminService.viewAllFaculty();
		ModelAndView mv = new ModelAndView();
		mv.setViewName("viewallfaculty");
		mv.addObject("facultyList", facultyList);
		return mv;
	}
	
	@GetMapping("managefaculty")
	public ModelAndView managefaculty()
	{
		ModelAndView mv = new ModelAndView();
		mv.setViewName("managefaculty");
		List<Faculty> facultyList = adminService.viewAllFaculty();
		mv.addObject("facultyList", facultyList);
		return mv;
	}
	
	@GetMapping("blockfaculty/{fid}")
	public String blockfaculty(@PathVariable long fid)
	{
		adminService.updateFacultyStatus(fid, false);
		return "redirect:/managefaculty";
	}
	
	@GetMapping("unblockfaculty/{fid}")
	public String unblockfaculty(@PathVariable long fid)
	{
		adminService.updateFacultyStatus(fid, true);
		return "redirect:/managefaculty";
	}
	
	@GetMapping("updatefaculty")
	public ModelAndView updatefaculty(@RequestParam long fid) {
	    ModelAndView mv = new ModelAndView();
	    mv.setViewName("adminupdatefaculty");
	    Faculty faculty = adminService.viewFacultyByID(fid);
	    mv.addObject("faculty", faculty);
	    return mv;
	}

	@PostMapping("editfaculty")
	public ModelAndView editFaculty(HttpServletRequest request, HttpServletResponse response) {
	    long fid = Long.parseLong(request.getParameter("fid"));
	    String fname = request.getParameter("fname");
	    String fdept = request.getParameter("fdept");
	    String femail = request.getParameter("femail");
	    String fcontact = request.getParameter("fcontact");
	    String fgender = request.getParameter("fgender");

	    ModelAndView mv = new ModelAndView();
	    boolean isContactAvailable = adminService.isFacultyContactAvailable(fcontact);
	    boolean isEmailAvailable = adminService.isFacultyEmailAvailable(femail);
	    Faculty faculty = adminService.viewFacultyByID(fid);

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

	    String updateMessage = adminService.updateFaculty(faculty);
	    return facultyRedirectWithMessage(mv, fid, updateMessage);
	}

	private ModelAndView facultyRedirectWithMessage(ModelAndView mv, long fid, String message) {
	    try {
	        String encodedMessage = URLEncoder.encode(message, StandardCharsets.UTF_8.toString());
	        mv.setViewName("redirect:/updatefaculty?fid=" + fid + "&message=" + encodedMessage); // Fixed redirect path
	    } catch (Exception e) {
	        mv.setViewName("exception");
	        mv.addObject("message", e.getMessage());
	    }
	    return mv;
	}
	
	@GetMapping("facultyeventmapping")
	public ModelAndView femapping(HttpServletRequest request)
	{
		
		ModelAndView mv = new ModelAndView();
		HttpSession session = request.getSession();
		Admin admin = (Admin) session.getAttribute("admin");
		if(admin == null)
		{
			mv.setViewName("sessionexpired");
			return mv;
		}
		List<Faculty> facultyList = adminService.viewAllFaculty();
		List<Event> eventList = adminService.myEvents(admin.getUsername());
		mv.setViewName("facultyeventmapping");
		mv.addObject("facultyList", facultyList);
		mv.addObject("eventList", eventList);
		return mv;
	}
	
	@PostMapping("mapfacultyevent")
	public String mapfacultyevent(HttpServletRequest request, HttpServletResponse response)
	{
		long eventid = Long.parseLong(request.getParameter("event"));
		long facultyid = Long.parseLong(request.getParameter("faculty"));
		String addedby = request.getParameter("admin");
		
		FacultyEventMapping fem = new FacultyEventMapping();
		fem.setAdmin(adminService.viewAdminByID(addedby));
		fem.setFaculty(adminService.viewFacultyByID(facultyid));
		fem.setEvent(adminService.viewEventByID(eventid));
		adminService.MapFacultyAndEvent(fem);
		return "redirect:/myevents";
	}
	
}