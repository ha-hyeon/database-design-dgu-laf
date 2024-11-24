// SearchService.java
package com.dgulaf.service;

import com.dgulaf.model.FoundItem;
import com.dgulaf.model.LostItem;
import com.dgulaf.repository.FoundItemRepository;
import com.dgulaf.repository.LostItemRepository;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class SearchService {
    private final LostItemRepository lostItemRepository;
    private final FoundItemRepository foundItemRepository;

    public SearchService(LostItemRepository lostItemRepository, FoundItemRepository foundItemRepository) {
        this.lostItemRepository = lostItemRepository;
        this.foundItemRepository = foundItemRepository;
    }

    public List<LostItem> searchLostItemsByTitle(String keyword) {
        return lostItemRepository.findByTitleContaining(keyword);
    }

    public List<LostItem> searchLostItemsByClassroom(Integer classroomId) {
        return lostItemRepository.findByClassroomId(classroomId);
    }

    public List<LostItem> searchLostItemsByTitleAndClassroom(String keyword, Integer classroomId) {
        return lostItemRepository.findByTitleContainingAndClassroomId(keyword, classroomId);
    }

    public List<FoundItem> searchFoundItemsByTitle(String keyword) {
        return foundItemRepository.findByTitleContaining(keyword);
    }

    public List<FoundItem> searchFoundItemsByClassroom(Integer classroomId) {
        return foundItemRepository.findByClassroomId(classroomId);
    }

    public List<FoundItem> searchFoundItemsByTitleAndClassroom(String keyword, Integer classroomId) {
        return foundItemRepository.findByTitleContainingAndClassroomId(keyword, classroomId);
    }

    // LostItem과 FoundItem을 합쳐서 검색하는 메서드
    public List<Object> searchItems(String keyword, Integer classroomId) {
        List<Object> result = new ArrayList<>();
        
        List<LostItem> lostItems = lostItemRepository.findByTitleContainingAndClassroomId(keyword, classroomId);
        List<FoundItem> foundItems = foundItemRepository.findByTitleContainingAndClassroomId(keyword, classroomId);
        
        result.addAll(lostItems); // LostItem 리스트 추가
        result.addAll(foundItems); // FoundItem 리스트 추가
        
        return result;
    }

    public List<FoundItem> getAllFoundItems() {
        return foundItemRepository.findAll();  // FoundItemRepository에서 모든 항목을 조회
    }
    public List<LostItem> getAllLostItems() {
        return lostItemRepository.findAll();  // FoundItemRepository에서 모든 항목을 조회
    }
}
