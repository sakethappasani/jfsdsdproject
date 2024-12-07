package com.klef.jfsd.springboot.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.klef.jfsd.springboot.model.Admin;
import com.klef.jfsd.springboot.model.Event;
import com.klef.jfsd.springboot.model.EventRegistration;
import com.klef.jfsd.springboot.model.Student;
import com.klef.jfsd.springboot.model.StudentEventAttendance;
import com.klef.jfsd.springboot.repository.AdminRepository;
import com.klef.jfsd.springboot.repository.EventRepository;
import com.klef.jfsd.springboot.repository.RegistrationRepository;
import com.klef.jfsd.springboot.repository.StudentEventAttendanceRepository;
import com.klef.jfsd.springboot.repository.StudentRepository;

@Service
public class StudentServiceImpl implements StudentService
{
	@Autowired
	private StudentRepository studentRepository;
	@Autowired
	private RegistrationRepository registrationRepository;
	@Autowired
	private EventRepository eventRepository;
	@Autowired
	private AdminRepository adminRepository;
	@Autowired
	private StudentEventAttendanceRepository studentEventAttendanceRepository;

	@Override
	public List<Event> viewAllEvents() 
	{
		return eventRepository.findAll();
	}

	@Override
	public void registerForEvent(EventRegistration event) 
	{
		registrationRepository.save(event);
		decreaseSlotCount(event.getEvent().getEventid());
	}

	@Override
	public Admin viewAdminByID(String name) 
	{
		return adminRepository.findById(name).get();
	}

	@Override
	public Event viewEventByID(long id) 
	{
		return eventRepository.findById(id).get();
	}

	@Override
	public Student viewStudentByID(long id) 
	{
		return studentRepository.findById(id).get();
	}

	@Override
	public List<EventRegistration> myEvents(long id) {
		return registrationRepository.findRegistrations(id);
	}

	@Override
	public void unregisterEvent(long sid, long eid) 
	{
		registrationRepository.deleteRegistration(sid, eid);
		increaseSlotCount(eid);
	}

	@Override
	public void decreaseSlotCount(long eid) 
	{
		Event event = eventRepository.findById(eid).get();
		if(event.getAvailableSlots() > 0)
		{
			event.setAvailableSlots(event.getAvailableSlots()-1);
			eventRepository.save(event);
		}
	}

	@Override
	public void increaseSlotCount(long eid)
	{
		Event event = eventRepository.findById(eid).get();
		if(event.getAvailableSlots() < event.getTotalslots())
		{
			event.setAvailableSlots(event.getAvailableSlots()+1);
			eventRepository.save(event);
		}
	}
	
	@Override
	public boolean isStudentContactAvailable(String contact) 
	{
		Student s =  studentRepository.findByContact(contact);
		if(s == null)
		{
			return true;
		}
		else
		{
			return false;
		}
	}

	@Override
	public boolean isStudentEmailAvailable(String email) 
	{
		Student s =  studentRepository.findByEmail(email);
		if(s== null)
		{
			return true;
		}
		else
		{
			return false;
		}
	}

	@Override
	public String updateStudent(Student s) 
	{
		studentRepository.save(s);
		return "Student Update Successfully";
	}

	@Override
	public List<Object[]> getLeaderboard() 
	{
		return studentEventAttendanceRepository.getLeaderboard();
	}

	@Override
	public List<StudentEventAttendance> myAttendance(long sid) 
	{
		return studentEventAttendanceRepository.studentMyAttendance(sid);
	}
	
}
