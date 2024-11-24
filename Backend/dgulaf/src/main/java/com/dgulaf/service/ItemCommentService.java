package com.dgulaf.service;

import com.dgulaf.model.ItemComment;
import com.dgulaf.repository.ItemCommentRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ItemCommentService {
    private final ItemCommentRepository itemCommentRepository;

    public ItemCommentService(ItemCommentRepository itemCommentRepository) {
        this.itemCommentRepository = itemCommentRepository;
    }

    // 댓글 추가 메서드
    public ItemComment addComment(ItemComment comment) {
        return itemCommentRepository.save(comment);  // 댓글을 DB에 저장
    }

    // itemId와 isLost로 필터링된 댓글을 가져오는 메서드
    public List<ItemComment> getCommentsByItemId(int itemId, boolean isLost) {
        return itemCommentRepository.findCommentsByItemIdAndIsLost(itemId, isLost);
    }

    // 모든 댓글을 가져오는 메서드
    public List<ItemComment> getAllComments() {
        return itemCommentRepository.findAll();
    }
}
