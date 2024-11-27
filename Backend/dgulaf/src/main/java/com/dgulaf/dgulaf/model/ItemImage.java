package com.dgulaf.dgulaf.model;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "itemimages")
public class ItemImage {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer imageId;

    @Column(nullable = false)
    private Integer itemId;

    @Column(nullable = false)
    private Boolean isLost;

    @Column(nullable = false, length = 255)
    private String imageUrl;
}
