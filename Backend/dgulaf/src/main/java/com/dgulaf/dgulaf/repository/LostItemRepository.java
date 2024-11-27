package com.dgulaf.dgulaf.repository;

import com.dgulaf.dgulaf.model.LostItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface LostItemRepository extends JpaRepository<LostItem, Integer> {
       // 제목에 키워드 포함된 분실물 검색
       @Query("SELECT li FROM LostItem li WHERE li.title LIKE %:keyword%")
       List<LostItem> findByTitleContaining(String keyword);

       @Query("SELECT li FROM LostItem li WHERE li.location.classroomId = :classroomId")
       List<LostItem> findByClassroomId(int classroomId);

       @Query("SELECT li FROM LostItem li WHERE li.title LIKE %:keyword% AND li.location.classroomId = :classroomId")
       List<LostItem> findByTitleContainingAndClassroomId(String keyword, int classroomId);
   }
   