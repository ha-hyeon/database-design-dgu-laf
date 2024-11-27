package com.dgulaf.dgulaf.service;

import com.dgulaf.dgulaf.model.LostItem;
import com.dgulaf.dgulaf.repository.LostItemRepository;
import org.springframework.stereotype.Service;

@Service
public class LostItemService {
    private final LostItemRepository lostItemRepository;

    public LostItemService(LostItemRepository lostItemRepository) {
        this.lostItemRepository = lostItemRepository;
    }

    public LostItem createLostItem(LostItem lostItem) {
        return lostItemRepository.save(lostItem);
    }

    public LostItem getLostItemById(int id) {
        return lostItemRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("LostItem not found with id: " + id));
    }

    // LostItem 수정 메서드 (ID 제외)
    public LostItem updateLostItem(int id, LostItem lostItem) {
        if (!lostItemRepository.existsById(id)) {
            throw new IllegalArgumentException("LostItem not found with id: " + id);
        }
        LostItem existingLostItem = lostItemRepository.findById(id).get();
        // 기존 데이터를 덮어쓰지 않고 수정할 부분만 업데이트
        existingLostItem.setTitle(lostItem.getTitle());
        existingLostItem.setDescription(lostItem.getDescription());
        // 필요한 필드들만 업데이트
        return lostItemRepository.save(existingLostItem);
    }

    // LostItem 삭제 메서드
    public void deleteLostItem(int id) {
        if (!lostItemRepository.existsById(id)) {
            throw new IllegalArgumentException("LostItem not found with id: " + id);
        }
        lostItemRepository.deleteById(id);
    }
}
