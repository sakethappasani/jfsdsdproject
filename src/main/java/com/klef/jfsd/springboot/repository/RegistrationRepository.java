package com.klef.jfsd.springboot.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.klef.jfsd.springboot.model.EventRegistration;

import jakarta.transaction.Transactional;

public interface RegistrationRepository extends JpaRepository<EventRegistration, Long>
{
	@Query("from EventRegistration er where er.student.id=?1 ")
	public List<EventRegistration> findRegistrations(long sid);
	
	@Query("delete from EventRegistration er where er.student.id = ?1 and er.event.id=?2")
	@Transactional
	@Modifying
	public void deleteRegistration(long sid, long eid);
}