package com.dgulaf.repository;

import com.dgulaf.model.ItemImage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ItemImageRepository extends JpaRepository<ItemImage, Integer> {
    // 특정 아이템의 이미지 검색
    List<ItemImage> findImagesByItemIdAndIsLost(int itemId, boolean isLost);
}
