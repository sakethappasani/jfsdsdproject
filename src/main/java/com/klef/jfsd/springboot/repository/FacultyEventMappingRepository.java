package com.klef.jfsd.springboot.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.klef.jfsd.springboot.model.FacultyEventMapping;

public interface FacultyEventMappingRepository extends JpaRepository<FacultyEventMapping, Long>
{
	@Query("from FacultyEventMapping fem where fem.faculty.id = ?1")
	public List<FacultyEventMapping> viewMyEvents(long fid);
}
