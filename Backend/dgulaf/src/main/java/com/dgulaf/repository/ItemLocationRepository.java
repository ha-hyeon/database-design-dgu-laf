package com.dgulaf.repository;

import com.dgulaf.model.ItemLocation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ItemLocationRepository extends JpaRepository<ItemLocation, Integer> {
    // 특정 강의실 ID로 위치 검색
    ItemLocation findByClassroomId(int classroomId);
}
