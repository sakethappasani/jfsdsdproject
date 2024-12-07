package com.klef.jfsd.springboot.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.klef.jfsd.springboot.model.Admin;
import com.klef.jfsd.springboot.model.Event;
import com.klef.jfsd.springboot.model.EventRegistration;
import com.klef.jfsd.springboot.model.Faculty;
import com.klef.jfsd.springboot.model.FacultyEventMapping;
import com.klef.jfsd.springboot.model.Student;
import com.klef.jfsd.springboot.repository.AdminRepository;
import com.klef.jfsd.springboot.repository.EventRepository;
import com.klef.jfsd.springboot.repository.FacultyEventMappingRepository;
import com.klef.jfsd.springboot.repository.FacultyRepository;
import com.klef.jfsd.springboot.repository.RegistrationRepository;
import com.klef.jfsd.springboot.repository.StudentRepository;

@Service
public class AdminServiceImpl implements AdminService
{
	@Autowired
	private AdminRepository adminRepository;
	@Autowired
	private StudentRepository studentRepository;
	@Autowired
	private EventRepository eventRepository;
	@Autowired
	private RegistrationRepository registrationRepository;
	@Autowired
	private FacultyRepository facultyRepository;
	@Autowired
	private FacultyEventMappingRepository facultyEventMappingRepository;

	@Override
	public String addStudent(Student s) 
	{
		studentRepository.save(s);
		return "Student Added Successfully";
	}

	@Override
	public List<Student> viewAllStudents() 
	{
		return studentRepository.findAll();
	}

	@Override
	public Student viewStudentById(long id) 
	{
		return studentRepository.findById(id).get();
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
	public String addEvent(Event e) 
	{
		eventRepository.save(e);
		return "Event Added Successfully";
	}

	@Override
	public List<Event> viewAllEvents() 
	{
		return eventRepository.findAll();
	}

	@Override
	public Event viewEventByID(long id) 
	{
		return eventRepository.findById(id).get();
	}

	@Override
	public String deleteEvent(long id) 
	{
		eventRepository.deleteById(id);
		return "Event Deleted Successfully";
	}

	@Override
	public String updateEvent(Event event) 
	{
		try
		{
			eventRepository.save(event);
			return "Event Updated Successfully";
		}
		catch (Exception e) 
		{
			return "Failed to Update Event: "+e.getMessage() ;
		} 
	}

	@Override
	public void updateStudentStatus(long id, boolean status) 
	{
		studentRepository.updateStudentStatus(status, id);
	}

	@Override
	public List<EventRegistration> viewEventRegistrations() 
	{
		return registrationRepository.findAll();
	}

	@Override
	public void updateFacultyStatus(long id, boolean status) 
	{
		facultyRepository.updateFacultyStatus(status, id);
	}
	
	@Override
	public String addFaculty(Faculty faculty) 
	{
		facultyRepository.save(faculty);
		return "Faculty Added Successfully";
	}

	@Override
	public List<Faculty> viewAllFaculty() 
	{
		return facultyRepository.findAll();
	}

	@Override
	public Faculty viewFacultyByID(long fid) 
	{
		return facultyRepository.findById(fid).get();
	}

	@Override
	public boolean isFacultyContactAvailable(String contact) 
	{
		Faculty f =  facultyRepository.findByContact(contact);
		if(f == null)
		{
			return true;
		}
		else
		{
			return false;
		}
	}

	@Override
	public boolean isFacultyEmailAvailable(String email) 
	{
		Faculty f =  facultyRepository.findByEmail(email);
		if(f == null)
		{
			return true;
		}
		else
		{
			return false;
		}
	}

	@Override
	public String updateFaculty(Faculty f) 
	{
		facultyRepository.save(f);
		return "Faculty Updated Successfully";
	}

	@Override
	public Admin viewAdminByID(String username) 
	{
		return adminRepository.findById(username).get();
	}

	@Override
	public void MapFacultyAndEvent(FacultyEventMapping fem) 
	{
		facultyEventMappingRepository.save(fem);
	}

	@Override
	public List<Event> myEvents(String username) 
	{
		return viewAllEvents().stream().filter(event -> username.equals(event.getAddedby())).collect(Collectors.toList());
	}

	@Override
	public List<EventRegistration> viewRegisteredStudents(String username, long eventid) 
	{
		return viewEventRegistrations().stream()
		        .filter(reg -> reg.getAdmin().getUsername().equals(username))
		        .filter(reg -> reg.getEvent().getEventid() == eventid)
		        .collect(Collectors.toList());
	}

	@Override
	public long getStudentCount() 
	{
		return studentRepository.count();
	}

	@Override
	public long getFacultyCount()
	{
		return facultyRepository.count();
	}

	@Override
	public long getEventCount()
	{
		return eventRepository.count();
	}
}
