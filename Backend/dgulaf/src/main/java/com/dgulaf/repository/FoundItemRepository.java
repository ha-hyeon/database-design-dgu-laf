package com.dgulaf.repository;

import com.dgulaf.model.FoundItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FoundItemRepository extends JpaRepository<FoundItem, Integer> {
    // 제목에 키워드 포함된 습득물 검색
    @Query("SELECT fi FROM FoundItem fi WHERE fi.title LIKE %:keyword%")
    List<FoundItem> findByTitleContaining(String keyword);

    // Classrooms의 classroom_id로 습득물 검색
    @Query("SELECT fi FROM FoundItem fi " +
           "JOIN ItemLocation il ON fi.locationId = il.locationId " +
           "WHERE il.classroomId = :classroomId")
    List<FoundItem> findByClassroomId(int classroomId);

    // 제목과 Classrooms의 classroom_id로 습득물 검색
    @Query("SELECT fi FROM FoundItem fi " +
           "JOIN ItemLocation il ON fi.locationId = il.locationId " +
           "WHERE fi.title LIKE %:keyword% AND il.classroomId = :classroomId")
    List<FoundItem> findByTitleContainingAndClassroomId(String keyword, int classroomId);
}