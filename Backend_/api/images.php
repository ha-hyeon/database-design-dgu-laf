<?php
include 'db.php';

// 이미지 등록 코드 (업로드 후 URL 저장)
if ($_SERVER['REQUEST_METHOD'] === 'POST' && $_GET['action'] === 'upload') {
    $item_id = $_POST['item_id'];
    $image_url = $_POST['image_url'];

    // 디버깅을 위한 로그
    error_log("item_id: " . $item_id);
    error_log("image_url: " . $image_url);

    // 데이터베이스에 이미지 URL 저장
    $sql = "INSERT INTO ItemImages (item_id, image_url) VALUES (?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("is", $item_id, $image_url);

    if ($stmt->execute()) {
        echo json_encode(["status" => "success", "message" => "Image uploaded successfully"]);
    } else {
        echo json_encode(["status" => "error", "message" => "Failed to upload image"]);
    }
    $stmt->close();
}

// 이미지 조회
if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['item_id'])) {
    $item_id = $_GET['item_id'];

    $sql = "SELECT image_url FROM ItemImages WHERE item_id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $item_id);
    $stmt->execute();
    $result = $stmt->get_result();

    $images = [];
    while ($row = $result->fetch_assoc()) {
        $images[] = $row['image_url'];
    }
    echo json_encode($images);
    $stmt->close();
}
?>
