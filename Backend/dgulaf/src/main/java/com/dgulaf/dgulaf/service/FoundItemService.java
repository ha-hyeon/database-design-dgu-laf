package com.dgulaf.dgulaf.service;

import com.dgulaf.dgulaf.model.FoundItem;
import com.dgulaf.dgulaf.repository.FoundItemRepository;
import org.springframework.stereotype.Service;

@Service
public class FoundItemService {
    private final FoundItemRepository foundItemRepository;

    public FoundItemService(FoundItemRepository foundItemRepository) {
        this.foundItemRepository = foundItemRepository;
    }

    public FoundItem createFoundItem(FoundItem foundItem) {
        return foundItemRepository.save(foundItem);
    }

    public FoundItem getFoundItemById(int id) {
        return foundItemRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("FoundItem not found with id: " + id));
    }

    // FoundItem 수정 메서드 (ID 제외)
    public FoundItem updateFoundItem(int id, FoundItem foundItem) {
        if (!foundItemRepository.existsById(id)) {
            throw new IllegalArgumentException("FoundItem not found with id: " + id);
        }
        FoundItem existingFoundItem = foundItemRepository.findById(id).get();
        // 기존 데이터를 덮어쓰지 않고 수정할 부분만 업데이트
        existingFoundItem.setTitle(foundItem.getTitle());
        existingFoundItem.setDescription(foundItem.getDescription());
        // 필요한 필드들만 업데이트
        return foundItemRepository.save(existingFoundItem);
    }

    // FoundItem 삭제 메서드
    public void deleteFoundItem(int id) {
        if (!foundItemRepository.existsById(id)) {
            throw new IllegalArgumentException("FoundItem not found with id: " + id);
        }
        foundItemRepository.deleteById(id);
    }
}
