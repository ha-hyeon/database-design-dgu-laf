package com.dgulaf.model;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "ItemLocation")
public class ItemLocation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer locationId;

    @ManyToOne
    @JoinColumn(name = "classroom_id", nullable = false)
    private Classroom classroom;

    @Column(length = 255)
    private String detail;
}
