package com.dgulaf.controller;

import com.dgulaf.model.ItemComment;
import com.dgulaf.service.ItemCommentService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/comments")
public class ItemCommentController {
    private final ItemCommentService itemCommentService;

    public ItemCommentController(ItemCommentService itemCommentService) {
        this.itemCommentService = itemCommentService;
    }

    // 댓글 추가 API
    @PostMapping
    public ResponseEntity<ItemComment> addComment(@RequestBody ItemComment comment) {
        return ResponseEntity.ok(itemCommentService.addComment(comment));  // 댓글을 DB에 저장 후 응답
    }

    // 특정 아이템 ID로 댓글 조회 (isLost 파라미터로 구분)
    @GetMapping("/item/{id}")
    public ResponseEntity<List<ItemComment>> getCommentsByItemId(@PathVariable int id, @RequestParam boolean isLost) {
        return ResponseEntity.ok(itemCommentService.getCommentsByItemId(id, isLost));  // 아이템 ID와 isLost로 댓글 조회
    }

    // 모든 댓글 조회 API (선택적)
    @GetMapping
    public ResponseEntity<List<ItemComment>> getAllComments() {
        return ResponseEntity.ok(itemCommentService.getAllComments());  // 모든 댓글을 조회
    }
}
