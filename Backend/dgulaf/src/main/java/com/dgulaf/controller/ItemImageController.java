package com.dgulaf.controller;

import com.dgulaf.model.ItemImage;
import com.dgulaf.service.ItemImageService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/images")
public class ItemImageController {
    private final ItemImageService itemImageService;

    public ItemImageController(ItemImageService itemImageService) {
        this.itemImageService = itemImageService;
    }

    // 이미지 추가
    @PostMapping
    public ResponseEntity<ItemImage> addImage(@RequestBody ItemImage image) {
        return ResponseEntity.ok(itemImageService.saveImage(image));  // 이미지를 DB에 저장
    }

    // 특정 아이템의 이미지 조회 (분실물/습득물 구분)
    @GetMapping("/{itemId}")
    public ResponseEntity<List<ItemImage>> getImagesByItemId(
            @PathVariable int itemId,
            @RequestParam boolean isLost) {
        return ResponseEntity.ok(itemImageService.getImagesByItemId(itemId, isLost));  // 아이템 ID와 isLost로 이미지 조회
    }
}
