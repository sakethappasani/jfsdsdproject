package com.klef.jfsd.springboot.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.klef.jfsd.springboot.model.Faculty;

import jakarta.transaction.Transactional;

@Repository
public interface FacultyRepository extends JpaRepository<Faculty, Long>
{
	@Query("select f from Faculty f where f.id = ?1 and f.password = ?2")
	public Faculty checkFacultyLogin(long id, String pwd);
	
	@Transactional
	@Modifying
	@Query("update Faculty f set f.status = ?1 where f.id=?2")
	public void updateFacultyStatus(boolean status, long id);
	
	@Query("select f from Faculty f where f.contact = ?1")
	public Faculty findByContact(String contact);
	
	@Query("select f from Faculty f where f.email = ?1")
	public Faculty findByEmail(String email);
}