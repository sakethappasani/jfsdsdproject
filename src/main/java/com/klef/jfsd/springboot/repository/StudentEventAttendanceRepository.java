package com.klef.jfsd.springboot.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.klef.jfsd.springboot.model.StudentEventAttendance;

public interface StudentEventAttendanceRepository extends JpaRepository<StudentEventAttendance, Long> {
	@Query("from StudentEventAttendance sa where sa.event.eventid = ?1")
	public List<StudentEventAttendance> getEventAttendance(long id);

	@Query("SELECT se.student.id, se.student.name, COUNT(se.id) AS attendanceCount " + "FROM StudentEventAttendance se "
			+ "WHERE se.status = true " + "GROUP BY se.student.id, se.student.name " + "ORDER BY attendanceCount DESC")
	public List<Object[]> getLeaderboard();
	
	
	@Query("from StudentEventAttendance sae where sae.student.id = ?1")
	public List<StudentEventAttendance> studentMyAttendance(long studentId);
	
	
}
