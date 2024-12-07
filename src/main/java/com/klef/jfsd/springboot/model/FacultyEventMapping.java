package com.klef.jfsd.springboot.model;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "fem_table")
public class FacultyEventMapping 
{
	@Id
	@Column(name = "mapping_id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long mappingid;
	
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "faculty_id")
	private Faculty faculty;
	
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "addedby")
	private Admin admin;
	
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "event_id")
	private Event event;

	public long getMappingid() {
		return mappingid;
	}

	public void setMappingid(long mappingid) {
		this.mappingid = mappingid;
	}

	public Faculty getFaculty() {
		return faculty;
	}

	public void setFaculty(Faculty faculty) {
		this.faculty = faculty;
	}

	public Admin getAdmin() {
		return admin;
	}

	public void setAdmin(Admin admin) {
		this.admin = admin;
	}

	public Event getEvent() {
		return event;
	}

	public void setEvent(Event event) {
		this.event = event;
	}
}
