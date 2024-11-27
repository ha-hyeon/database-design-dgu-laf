package com.dgulaf.dgulaf.repository;

import com.dgulaf.dgulaf.model.ItemImage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ItemImageRepository extends JpaRepository<ItemImage, Integer> {
    // 특정 아이템의 이미지 검색
    @Query("SELECT ii FROM ItemImage ii WHERE ii.itemId = :itemId AND ii.isLost = :isLost")
    List<ItemImage> findImagesByItemIdAndIsLost(int itemId, boolean isLost);
}