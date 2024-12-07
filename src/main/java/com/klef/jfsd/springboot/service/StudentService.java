package com.klef.jfsd.springboot.service;

import java.util.List;

import com.klef.jfsd.springboot.model.Admin;
import com.klef.jfsd.springboot.model.Event;
import com.klef.jfsd.springboot.model.EventRegistration;
import com.klef.jfsd.springboot.model.Student;
import com.klef.jfsd.springboot.model.StudentEventAttendance;

public interface StudentService 
{
	public List<Event> viewAllEvents();
	public Admin viewAdminByID(String name);
	public Event viewEventByID(long id);
	public Student viewStudentByID(long id);
	public void registerForEvent(EventRegistration event);
	public List<EventRegistration> myEvents(long id);
	public void unregisterEvent(long sid, long eid);
	public void increaseSlotCount(long eid);
	public void decreaseSlotCount(long eid);
	public boolean isStudentContactAvailable(String contact);
	public boolean isStudentEmailAvailable(String email);	
	public String updateStudent(Student s);
	public List<Object[]> getLeaderboard();
	public List<StudentEventAttendance> myAttendance(long sid);
}
