package com.dgulaf.controller;

import com.dgulaf.model.FoundItem;
import com.dgulaf.service.FoundItemService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/found-items")
public class FoundItemController {
    private final FoundItemService foundItemService;

    public FoundItemController(FoundItemService foundItemService) {
        this.foundItemService = foundItemService;
    }

    @PostMapping
    public ResponseEntity<FoundItem> createFoundItem(@RequestBody FoundItem foundItem) {
        return ResponseEntity.ok(foundItemService.createFoundItem(foundItem));
    }

    @GetMapping("/{id}")
    public ResponseEntity<FoundItem> getFoundItemById(@PathVariable int id) {
        return ResponseEntity.ok(foundItemService.getFoundItemById(id));
    }
}
