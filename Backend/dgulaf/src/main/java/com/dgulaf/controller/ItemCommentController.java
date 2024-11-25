package com.dgulaf.controller;

import com.dgulaf.model.ItemComment;
import com.dgulaf.service.ItemCommentService;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/comments")
public class ItemCommentController {
    private final ItemCommentService itemCommentService;

    public ItemCommentController(ItemCommentService itemCommentService) {
        this.itemCommentService = itemCommentService;
    }

    // CREATE
    @PostMapping
    public ResponseEntity<ItemComment> addComment(@RequestBody ItemComment comment) {
        return ResponseEntity.ok(itemCommentService.addComment(comment));
    }

    // READ
    @GetMapping("/item/{id}")
    public ResponseEntity<List<ItemComment>> getCommentsByItemId(@PathVariable int id, @RequestParam boolean isLost) {
        return ResponseEntity.ok(itemCommentService.getCommentsByItemId(id, isLost));
    }

    // UPDATE
    @PutMapping("/{id}")
    public ResponseEntity<ItemComment> updateComment(@PathVariable int id, @RequestBody ItemComment comment) {
        return ResponseEntity.ok(itemCommentService.updateComment(id, comment));
    }

    // DELETE
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteComment(@PathVariable int id) {
        itemCommentService.deleteComment(id);
        return ResponseEntity.noContent().build();
    }
}
