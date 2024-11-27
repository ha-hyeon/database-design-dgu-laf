package com.dgulaf.dgulaf.controller;

import com.dgulaf.dgulaf.model.ItemLocation;
import com.dgulaf.dgulaf.service.ItemLocationService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/locations")
public class ItemLocationController {
    private final ItemLocationService itemLocationService;

    public ItemLocationController(ItemLocationService itemLocationService) {
        this.itemLocationService = itemLocationService;
    }

    @PostMapping
    public ResponseEntity<ItemLocation> addLocation(@RequestBody ItemLocation location) {
        return ResponseEntity.ok(itemLocationService.addLocation(location));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ItemLocation> getLocationById(@PathVariable int id) {
        return ResponseEntity.ok(itemLocationService.getLocationById(id));
    }
}
