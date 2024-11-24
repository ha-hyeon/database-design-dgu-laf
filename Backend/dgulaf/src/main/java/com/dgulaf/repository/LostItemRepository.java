package com.dgulaf.repository;

import com.dgulaf.model.LostItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface LostItemRepository extends JpaRepository<LostItem, Integer> {
    // 제목에 키워드 포함된 분실물 검색
    List<LostItem> findByTitleContaining(String keyword);

    // Classrooms의 classroom_id로 분실물 검색
    @Query("SELECT li FROM LostItem li " +
           "JOIN ItemLocation il ON li.locationId = il.locationId " +
           "JOIN Classrooms c ON il.classroomId = c.classroomId " +
           "WHERE c.classroomId = :classroomId")
    List<LostItem> findByClassroomId(int classroomId);

    // 제목과 Classrooms의 classroom_id로 분실물 검색
    @Query("SELECT li FROM LostItem li " +
           "JOIN ItemLocation il ON li.locationId = il.locationId " +
           "JOIN Classrooms c ON il.classroomId = c.classroomId " +
           "WHERE c.classroomId = :classroomId AND li.title LIKE %:keyword%")
    List<LostItem> findByTitleContainingAndClassroomId(String keyword, int classroomId);
}
