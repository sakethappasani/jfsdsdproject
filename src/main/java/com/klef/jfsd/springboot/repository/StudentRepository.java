package com.klef.jfsd.springboot.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.klef.jfsd.springboot.model.Student;

import jakarta.transaction.Transactional;

@Repository
public interface StudentRepository extends JpaRepository<Student, Long>
{
	@Query("select s from Student s where s.id = ?1 and s.pwd = ?2")
	public Student checkStudentLogin(long id, String password);
	
	@Query("select s from Student s where s.contact=?1")
	public Student findByContact(String contact);
	
	@Query("select s from Student s where s.email = ?1")
	public Student findByEmail(String email);
	
	@Transactional
	@Modifying
	@Query("update Student s set s.status = ?1 where s.id=?2")
	public void updateStudentStatus(boolean status, long id);
}
