package com.dgulaf.service;

import com.dgulaf.model.FoundItem;
import com.dgulaf.repository.FoundItemRepository;
import org.springframework.stereotype.Service;

@Service
public class FoundItemService {
    private final FoundItemRepository foundItemRepository;

    public FoundItemService(FoundItemRepository foundItemRepository) {
        this.foundItemRepository = foundItemRepository;
    }

    // createFoundItem으로 이름을 변경하고, FoundItem을 저장하는 메서드로 수정
    public FoundItem createFoundItem(FoundItem foundItem) {
        return foundItemRepository.save(foundItem);  // FoundItem을 저장
    }

    // ID로 FoundItem을 조회하는 메서드
    public FoundItem getFoundItemById(int id) {
        return foundItemRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("FoundItem not found with id: " + id));
    }
}
