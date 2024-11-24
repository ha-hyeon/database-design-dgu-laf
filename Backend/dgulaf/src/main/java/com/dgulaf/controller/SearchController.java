package com.dgulaf.controller;

import com.dgulaf.model.FoundItem;
import com.dgulaf.model.LostItem;
import com.dgulaf.service.SearchService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/search")
public class SearchController {
    private final SearchService searchService;

    public SearchController(SearchService searchService) {
        this.searchService = searchService;
    }

    @GetMapping("/lost-items")
    public ResponseEntity<List<LostItem>> searchLostItems(
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) Integer classroomId) {
        if (keyword != null && classroomId != null) {
            return ResponseEntity.ok(searchService.searchLostItemsByTitleAndClassroom(keyword, classroomId));
        } else if (classroomId != null) {
            return ResponseEntity.ok(searchService.searchLostItemsByClassroom(classroomId));
        } else if (keyword != null) {
            return ResponseEntity.ok(searchService.searchLostItemsByTitle(keyword));
        } else {
            return ResponseEntity.ok(searchService.getAllLostItems());
        }
    }

    @GetMapping("/found-items")
    public ResponseEntity<List<FoundItem>> searchFoundItems(
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) Integer classroomId) {
        if (keyword != null && classroomId != null) {
            return ResponseEntity.ok(searchService.searchFoundItemsByTitleAndClassroom(keyword, classroomId));
        } else if (classroomId != null) {
            return ResponseEntity.ok(searchService.searchFoundItemsByClassroom(classroomId));
        } else if (keyword != null) {
            return ResponseEntity.ok(searchService.searchFoundItemsByTitle(keyword));
        } else {
            return ResponseEntity.ok(searchService.getAllFoundItems());
        }
    }

    // LostItem과 FoundItem을 합쳐서 검색하는 기능 추가
    @GetMapping("/items")
    public ResponseEntity<List<Object>> searchItems(
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) Integer classroomId) {
        if (keyword != null && classroomId != null) {
            return ResponseEntity.ok(searchService.searchItems(keyword, classroomId));
        } else {
            return ResponseEntity.badRequest().body(null); // 파라미터가 없을 경우 잘못된 요청 반환
        }
    }
}
