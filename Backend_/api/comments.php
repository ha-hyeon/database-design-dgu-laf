<?php
include 'db.php';

// 댓글 등록
if ($_SERVER['REQUEST_METHOD'] === 'POST' && $_GET['action'] === 'create') {
    $user_id = $_POST['user_id'];
    $item_id = $_POST['item_id'];
    $content = $_POST['content'];

    $sql = "INSERT INTO ItemComments (user_id, item_id, content) VALUES (?, ?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("iis", $user_id, $item_id, $content);

    if ($stmt->execute()) {
        echo json_encode(["status" => "success", "message" => "Comment created successfully"]);
    } else {
        echo json_encode(["status" => "error", "message" => "Failed to create comment"]);
    }
    $stmt->close();
}

// 댓글 수정
if ($_SERVER['REQUEST_METHOD'] === 'PUT' && isset($_GET['comment_id'])) {
    parse_str(file_get_contents("php://input"), $_PUT);
    $comment_id = $_GET['comment_id'];
    $content = $_PUT['content'];

    $sql = "UPDATE ItemComments SET content = ? WHERE comment_id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("si", $content, $comment_id);

    if ($stmt->execute()) {
        echo json_encode(["status" => "success", "message" => "Comment updated successfully"]);
    } else {
        echo json_encode(["status" => "error", "message" => "Failed to update comment"]);
    }
    $stmt->close();
}

// 댓글 삭제
if ($_SERVER['REQUEST_METHOD'] === 'DELETE' && isset($_GET['comment_id'])) {
    $comment_id = $_GET['comment_id'];

    $sql = "DELETE FROM ItemComments WHERE comment_id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $comment_id);

    if ($stmt->execute()) {
        echo json_encode(["status" => "success", "message" => "Comment deleted successfully"]);
    } else {
        echo json_encode(["status" => "error", "message" => "Failed to delete comment"]);
    }
    $stmt->close();
}

// 댓글 목록 조회
if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['item_id'])) {
    $item_id = $_GET['item_id'];

    $sql = "SELECT * FROM ItemComments WHERE item_id = ? ORDER BY created_at ASC";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $item_id);
    $stmt->execute();
    $result = $stmt->get_result();

    $comments = [];
    while ($row = $result->fetch_assoc()) {
        $comments[] = $row;
    }
    echo json_encode($comments);
    $stmt->close();
}
?>
