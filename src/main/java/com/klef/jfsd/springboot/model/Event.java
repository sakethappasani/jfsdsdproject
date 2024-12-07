package com.klef.jfsd.springboot.model;

import java.sql.Blob;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "event_table")
public class Event 
{
	@Id
	@Column(name = "eid")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long eventid;
	@Column(name = "ename", nullable = false, length = 255)
	private String name;
	@Column(name = "edesc", nullable = false, length = 255)
	private String description;
	@Column(name = "ecategory", nullable = false, length = 50)
	private String category;
	@Column(name = "eimg", nullable = false)
	private Blob image;
	@Column(name = "eaddedby", nullable = false, length = 100)
	private String addedby;
	@Column(name = "evenue", nullable = false, length = 50)
	private String venue;
	@Column(name = "edate", nullable = false, length = 10)
	private String date;
	@Column(name = "etime", nullable = false, length = 6)
	private String time;
	@Column(name = "totalslots", nullable = false)
	private int totalslots;
	@Column(name = "eslots", nullable = false)
	private int availableSlots;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Blob getImage() {
		return image;
	}
	public void setImage(Blob image) {
		this.image = image;
	}
	public String getAddedby() {
		return addedby;
	}
	public void setAddedby(String addedby) {
		this.addedby = addedby;
	}
	public String getVenue() {
		return venue;
	}
	public void setVenue(String venue) {
		this.venue = venue;
	}
	public int getAvailableSlots() {
		return availableSlots;
	}
	public void setAvailableSlots(int availableSlots) {
		this.availableSlots = availableSlots;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public long getEventid() {
		return eventid;
	}
	public void setEventid(long eventid) {
		this.eventid = eventid;
	}
	public int getTotalslots() {
		return totalslots;
	}
	public void setTotalslots(int totalslots) {
		this.totalslots = totalslots;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
}
