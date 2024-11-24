package com.dgulaf.service;

import com.dgulaf.model.ItemImage;
import com.dgulaf.repository.ItemImageRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ItemImageService {
    private final ItemImageRepository itemImageRepository;

    public ItemImageService(ItemImageRepository itemImageRepository) {
        this.itemImageRepository = itemImageRepository;
    }

    // 이미지 저장
    public ItemImage saveImage(ItemImage itemImage) {
        return itemImageRepository.save(itemImage);  // 이미지를 DB에 저장
    }

    // 특정 아이템의 이미지 조회 (분실물/습득물 구분)
    public List<ItemImage> getImagesByItemId(int itemId, boolean isLost) {
        return itemImageRepository.findImagesByItemIdAndIsLost(itemId, isLost);  // 아이템 ID와 isLost로 이미지 조회
    }
}
