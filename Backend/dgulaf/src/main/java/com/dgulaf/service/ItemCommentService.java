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

    public ItemComment addComment(ItemComment comment) {
        return itemCommentRepository.save(comment);
    }

    public List<ItemComment> getCommentsByItemId(int itemId, boolean isLost) {
        return itemCommentRepository.findCommentsByItemIdAndIsLost(itemId, isLost);
    }

    public List<ItemComment> getAllComments() {
        return itemCommentRepository.findAll();
    }

    // 댓글 수정 메서드 (ID 제외)
    public ItemComment updateComment(int id, ItemComment comment) {
        if (!itemCommentRepository.existsById(id)) {
            throw new IllegalArgumentException("Comment not found with id: " + id);
        }
        ItemComment existingComment = itemCommentRepository.findById(id).get();
        // 기존 데이터를 덮어쓰지 않고 수정할 부분만 업데이트
        existingComment.setContent(comment.getContent());
        existingComment.setUser(comment.getUser());
        // 필요한 필드들만 업데이트
        return itemCommentRepository.save(existingComment);
    }

    // 댓글 삭제 메서드
    public void deleteComment(int id) {
        if (!itemCommentRepository.existsById(id)) {
            throw new IllegalArgumentException("Comment not found with id: " + id);
        }
        itemCommentRepository.deleteById(id);
    }
}
