package com.dgulaf.dgulaf.repository;
import org.springframework.data.jpa.repository.Query;
import com.dgulaf.dgulaf.model.ItemLocation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ItemLocationRepository extends JpaRepository<ItemLocation, Integer> {
    // 특정 강의실 ID로 위치 검색
    @Query("SELECT il FROM ItemLocation il WHERE il.classroomId = :classroomId")
    ItemLocation findByClassroomId(int classroomId);
}