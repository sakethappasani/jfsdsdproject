package com.klef.jfsd.springboot.service;

import java.util.List;

import com.klef.jfsd.springboot.model.Admin;
import com.klef.jfsd.springboot.model.Event;
import com.klef.jfsd.springboot.model.EventRegistration;
import com.klef.jfsd.springboot.model.Faculty;
import com.klef.jfsd.springboot.model.FacultyEventMapping;
import com.klef.jfsd.springboot.model.Student;

public interface AdminService 
{
	public String addStudent(Student s);
	public List<Student> viewAllStudents();
	public Student viewStudentById(long id);
	public boolean isStudentContactAvailable(String contact);
	public boolean isStudentEmailAvailable(String email);	
	public String updateStudent(Student s);
	public void updateStudentStatus(long id, boolean status);
	public String addEvent(Event e);
	public  List<Event> viewAllEvents();
	public List<Event> myEvents(String username);
	public List<EventRegistration> viewRegisteredStudents(String username, long eventid);
	public Event viewEventByID(long id);
	public String deleteEvent(long id);
	public String updateEvent(Event e);
	public List<EventRegistration> viewEventRegistrations();
	public void updateFacultyStatus(long id, boolean status);
	public String addFaculty(Faculty faculty);
	public List<Faculty> viewAllFaculty();
	public Faculty viewFacultyByID(long fid);
	public boolean isFacultyContactAvailable(String contact);
	public boolean isFacultyEmailAvailable(String email);
	public String updateFaculty(Faculty f);
	public Admin viewAdminByID(String username);
	public void MapFacultyAndEvent(FacultyEventMapping fem);
	public long getStudentCount();
	public long getFacultyCount();
	public long getEventCount();
}
