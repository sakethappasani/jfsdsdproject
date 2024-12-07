package com.klef.jfsd.springboot.model;

public class EventRegistrationHelper 
{
	private long regid;
	private Student student;
	private Event event;	
	private Admin admin;
	private boolean canUnregister;
	
	public long getRegid() {
		return regid;
	}
	public void setRegid(long regid) {
		this.regid = regid;
	}
	public Student getStudent() {
		return student;
	}
	public void setStudent(Student student) {
		this.student = student;
	}
	public Event getEvent() {
		return event;
	}
	public void setEvent(Event event) {
		this.event = event;
	}
	public Admin getAdmin() {
		return admin;
	}
	public void setAdmin(Admin admin) {
		this.admin = admin;
	}
	public boolean isCanUnregister() {
		return canUnregister;
	}
	public void setCanUnregister(boolean canUnregister) {
		this.canUnregister = canUnregister;
	}
}