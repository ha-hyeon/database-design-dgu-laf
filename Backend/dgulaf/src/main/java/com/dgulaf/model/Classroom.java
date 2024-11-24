package com.dgulaf.model;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "Classrooms")
public class Classroom {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer classroomId;

    @Column(nullable = false, length = 100)
    private String buildingName;

    @Column(nullable = false, length = 20)
    private String roomNumber;
}
