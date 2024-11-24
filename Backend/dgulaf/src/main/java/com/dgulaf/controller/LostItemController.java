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

    @PostMapping
    public ResponseEntity<LostItem> createLostItem(@RequestBody LostItem lostItem) {
        return ResponseEntity.ok(lostItemService.createLostItem(lostItem));
    }

    @GetMapping("/{id}")
    public ResponseEntity<LostItem> getLostItemById(@PathVariable int id) {
        return ResponseEntity.ok(lostItemService.getLostItemById(id));
    }
}
