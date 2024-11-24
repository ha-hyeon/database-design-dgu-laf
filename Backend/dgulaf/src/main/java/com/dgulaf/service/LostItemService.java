package com.dgulaf.service;

import com.dgulaf.model.LostItem;
import com.dgulaf.repository.LostItemRepository;
import org.springframework.stereotype.Service;

@Service
public class LostItemService {
    private final LostItemRepository lostItemRepository;

    public LostItemService(LostItemRepository lostItemRepository) {
        this.lostItemRepository = lostItemRepository;
    }

    // createLostItem으로 이름을 변경하고, LostItem을 저장하는 메서드로 수정
    public LostItem createLostItem(LostItem lostItem) {
        return lostItemRepository.save(lostItem);  // LostItem을 저장
    }

    // ID로 LostItem을 조회하는 메서드
    public LostItem getLostItemById(int id) {
        return lostItemRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("LostItem not found with id: " + id));
    }
}
