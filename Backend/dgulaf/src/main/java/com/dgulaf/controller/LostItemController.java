package com.dgulaf.controller;

import com.dgulaf.model.LostItem;
import com.dgulaf.service.LostItemService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/lost-items")
public class LostItemController {
    private final LostItemService lostItemService;

    public LostItemController(LostItemService lostItemService) {
        this.lostItemService = lostItemService;
    }

    // CREATE
    @PostMapping
    public ResponseEntity<LostItem> createLostItem(@RequestBody LostItem lostItem) {
        return ResponseEntity.ok(lostItemService.createLostItem(lostItem));
    }

    // READ
    @GetMapping("/{id}")
    public ResponseEntity<LostItem> getLostItemById(@PathVariable int id) {
        return ResponseEntity.ok(lostItemService.getLostItemById(id));
    }

    // UPDATE
    @PutMapping("/{id}")
    public ResponseEntity<LostItem> updateLostItem(@PathVariable int id, @RequestBody LostItem lostItem) {
        return ResponseEntity.ok(lostItemService.updateLostItem(id, lostItem));
    }

    // DELETE
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteLostItem(@PathVariable int id) {
        lostItemService.deleteLostItem(id);
        return ResponseEntity.noContent().build();
    }
}
