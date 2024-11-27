package com.dgulaf.dgulaf.repository;

import com.dgulaf.dgulaf.model.ItemComment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;

@Repository
public interface ItemCommentRepository extends JpaRepository<ItemComment, Integer> {
    // 특정 아이템의 댓글 검색
    @Query("SELECT ic FROM ItemComment ic WHERE ic.itemId = :itemId AND ic.isLost = :isLost")
    List<ItemComment> findCommentsByItemIdAndIsLost(int itemId, boolean isLost);
}
