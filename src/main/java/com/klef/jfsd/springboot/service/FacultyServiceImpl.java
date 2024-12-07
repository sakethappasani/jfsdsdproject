package com.klef.jfsd.springboot.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.klef.jfsd.springboot.model.Event;
import com.klef.jfsd.springboot.model.EventRegistration;
import com.klef.jfsd.springboot.model.FacultyEventMapping;
import com.klef.jfsd.springboot.model.Student;
import com.klef.jfsd.springboot.model.StudentEventAttendance;
import com.klef.jfsd.springboot.repository.EventRepository;
import com.klef.jfsd.springboot.repository.FacultyEventMappingRepository;
import com.klef.jfsd.springboot.repository.RegistrationRepository;
import com.klef.jfsd.springboot.repository.StudentEventAttendanceRepository;
import com.klef.jfsd.springboot.repository.StudentRepository;

@Service
public class FacultyServiceImpl implements FacultyService
{
	@Autowired
	private StudentRepository studentRepository;
	@Autowired
	private EventRepository eventRepository;
	@Autowired
	private FacultyEventMappingRepository facultyEventMappingRepository;
	@Autowired
	private RegistrationRepository registrationRepository;
	@Autowired
	private StudentEventAttendanceRepository attendanceRepository;
	
	@Override
	public List<FacultyEventMapping> viewMyEvents(long fid) 
	{
		return facultyEventMappingRepository.viewMyEvents(fid);
	}

	@Override
	public List<EventRegistration> viewEventRegistrations(long eventid) 
	{
		List< EventRegistration> regList = registrationRepository.findAll().
				stream()
				.filter(reg -> reg.getEvent()
						.getEventid()==eventid)
				.collect(Collectors.toList());
		return regList;
	}

	@Override
	public boolean isAttendacePosted(long eventid) 
	{
		List<StudentEventAttendance> attendanceList = attendanceRepository.getEventAttendance(eventid);
		return attendanceList.size()>0;
	}

	@Override
	public String saveAttendance(List<StudentEventAttendance> attendance) 
	{
		attendanceRepository.saveAll(attendance);
		return "Attendance Posted Successfully";
	}

	@Override
	public Event getEventById(long eid) 
	{
		return eventRepository.findById(eid).get();
	}

	@Override
	public Student getStudentById(long sid) 
	{
		return studentRepository.findById(sid).get();
	}

}