package com.dgulaf.dgulaf.model;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "itemlocation") // 데이터베이스 테이블 이름
public class ItemLocation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "location_id")
    private Integer locationId;

    @Column(name = "classroom_id", nullable = false) // 물리적 열 이름 매핑
    private int classroomId; // 논리적 열 이름
}
