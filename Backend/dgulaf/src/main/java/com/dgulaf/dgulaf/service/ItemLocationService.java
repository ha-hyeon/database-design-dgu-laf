package com.dgulaf.dgulaf.service;

import com.dgulaf.dgulaf.model.ItemLocation;
import com.dgulaf.dgulaf.repository.ItemLocationRepository;
import org.springframework.stereotype.Service;

@Service
public class ItemLocationService {
    private final ItemLocationRepository itemLocationRepository;

    public ItemLocationService(ItemLocationRepository itemLocationRepository) {
        this.itemLocationRepository = itemLocationRepository;
    }

    // 위치 추가
    public ItemLocation addLocation(ItemLocation location) {
        return itemLocationRepository.save(location);  // 새 위치를 DB에 저장
    }

    // 특정 위치 조회
    public ItemLocation getLocationById(int id) {
        return itemLocationRepository.findById(id).orElseThrow(() -> new RuntimeException("Location not found"));  // ID로 위치 조회, 없으면 예외 발생
    }
}
