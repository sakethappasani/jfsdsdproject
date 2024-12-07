package com.klef.jfsd.springboot.service;

import java.util.List;

import com.klef.jfsd.springboot.model.Event;
import com.klef.jfsd.springboot.model.EventRegistration;
import com.klef.jfsd.springboot.model.FacultyEventMapping;
import com.klef.jfsd.springboot.model.Student;
import com.klef.jfsd.springboot.model.StudentEventAttendance;

public interface FacultyService
{
	public List<FacultyEventMapping> viewMyEvents(long fid);
	public List<EventRegistration> viewEventRegistrations(long eventid);	
	public Event getEventById(long eid);
	public Student getStudentById(long sid);
	public boolean isAttendacePosted(long eventid);
	public String saveAttendance(List<StudentEventAttendance> attendance);
}
