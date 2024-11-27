package com.dgulaf.dgulaf.controller;

import com.dgulaf.dgulaf.model.FoundItem;
import com.dgulaf.dgulaf.service.FoundItemService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/found-items")
public class FoundItemController {
    private final FoundItemService foundItemService;

    public FoundItemController(FoundItemService foundItemService) {
        this.foundItemService = foundItemService;
    }

    // CREATE
    @PostMapping
    public ResponseEntity<FoundItem> createFoundItem(@RequestBody FoundItem foundItem) {
        return ResponseEntity.ok(foundItemService.createFoundItem(foundItem));
    }

    // READ
    @GetMapping("/{id}")
    public ResponseEntity<FoundItem> getFoundItemById(@PathVariable int id) {
        return ResponseEntity.ok(foundItemService.getFoundItemById(id));
    }

    // UPDATE
    @PutMapping("/{id}")
    public ResponseEntity<FoundItem> updateFoundItem(@PathVariable int id, @RequestBody FoundItem foundItem) {
        return ResponseEntity.ok(foundItemService.updateFoundItem(id, foundItem));
    }

    // DELETE
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteFoundItem(@PathVariable int id) {
        foundItemService.deleteFoundItem(id);
        return ResponseEntity.noContent().build();
    }
}
