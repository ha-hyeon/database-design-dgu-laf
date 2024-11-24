package com.dgulaf.repository;

import com.dgulaf.model.Classroom;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ClassroomRepository extends JpaRepository<Classroom, Integer> {
    // 건물 이름과 강의실 번호로 검색
    Classroom findByBuildingNameAndRoomNumber(String buildingName, String roomNumber);
}
