<?php
include 'db.php';

// 아이템 등록
if ($_SERVER['REQUEST_METHOD'] === 'POST' && $_GET['action'] === 'create') {
    $user_id = $_POST['user_id'];
    $item_type = $_POST['item_type'];
    $title = $_POST['title'];
    $item_date = $_POST['item_date'];
    $description = $_POST['description'];
    $classroom_id = $_POST['classroom_id'];
    $detail_location = $_POST['detail_location'];

    $sql = "INSERT INTO Items (user_id, item_type, title, item_date, description, classroom_id, detail_location) VALUES (?, ?, ?, ?, ?, ?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("issssis", $user_id, $item_type, $title, $item_date, $description, $classroom_id, $detail_location);

    if ($stmt->execute()) {
        echo json_encode(["status" => "success", "message" => "Item created successfully"]);
    } else {
        echo json_encode(["status" => "error", "message" => "Failed to create item"]);
    }
    $stmt->close();
}

// 아이템 수정
if ($_SERVER['REQUEST_METHOD'] === 'PUT' && isset($_GET['item_id'])) {
    parse_str(file_get_contents("php://input"), $_PUT);
    $item_id = $_GET['item_id'];
    $title = $_PUT['title'];
    $description = $_PUT['description'];

    $sql = "UPDATE Items SET title = ?, description = ? WHERE item_id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ssi", $title, $description, $item_id);

    if ($stmt->execute()) {
        echo json_encode(["status" => "success", "message" => "Item updated successfully"]);
    } else {
        echo json_encode(["status" => "error", "message" => "Failed to update item"]);
    }
    $stmt->close();
}

// 아이템 삭제
if ($_SERVER['REQUEST_METHOD'] === 'DELETE' && isset($_GET['item_id'])) {
    $item_id = $_GET['item_id'];

    $sql = "DELETE FROM Items WHERE item_id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $item_id);

    if ($stmt->execute()) {
        echo json_encode(["status" => "success", "message" => "Item deleted successfully"]);
    } else {
        echo json_encode(["status" => "error", "message" => "Failed to delete item"]);
    }
    $stmt->close();
}

// 아이템 상세 조회
if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['item_id'])) {
    $item_id = $_GET['item_id'];

    $sql = "SELECT * FROM Items WHERE item_id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $item_id);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($row = $result->fetch_assoc()) {
        echo json_encode($row);
    } else {
        echo json_encode(["status" => "error", "message" => "Item not found"]);
    }
    $stmt->close();
}

// 최근 아이템 목록 조회
if ($_SERVER['REQUEST_METHOD'] === 'GET' && $_GET['action'] === 'recent') {
    $sql = "SELECT * FROM Items ORDER BY created_at DESC LIMIT 10";
    $result = $conn->query($sql);

    $items = [];
    while ($row = $result->fetch_assoc()) {
        $items[] = $row;
    }
    echo json_encode($items);
}

// 필터링된 아이템 목록 조회
if ($_SERVER['REQUEST_METHOD'] === 'GET' && $_GET['action'] === 'filter') {
    $title = $_GET['title'];
    $classroom_id = $_GET['classroom_id'];
    $item_type = $_GET['item_type'];

    $sql = "SELECT * FROM Items WHERE title LIKE ? AND classroom_id = ? AND item_type = ?";
    $stmt = $conn->prepare($sql);
    $title = "%$title%";
    $stmt->bind_param("sis", $title, $classroom_id, $item_type);
    $stmt->execute();
    $result = $stmt->get_result();

    $items = [];
    while ($row = $result->fetch_assoc()) {
        $items[] = $row;
    }
    echo json_encode($items);
    $stmt->close();
}
?>
