package com.dgulaf.repository;

import com.dgulaf.model.ItemComment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ItemCommentRepository extends JpaRepository<ItemComment, Integer> {
    // 특정 아이템의 댓글 검색
    List<ItemComment> findCommentsByItemIdAndIsLost(int itemId, boolean isLost);
}
