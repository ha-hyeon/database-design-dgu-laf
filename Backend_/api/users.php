<?php
include 'db.php'; // 데이터베이스 연결

// CORS 헤더 설정
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

// 로그인 처리
// 로그인 처리
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_GET['action']) && $_GET['action'] === 'login') {
    $username = $_POST['username'];
    $password = $_POST['password'];

    $sql = "SELECT * FROM Users WHERE username = ? AND password = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ss", $username, $password);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        // 로그인 성공 시, 사용자 정보를 가져와서 반환
        $user = $result->fetch_assoc();
        echo json_encode([
            "status" => "success",
            "user_id" => $user['user_id'], // 'user_id' 필드 사용
            "message" => "Login successful"
        ]);
    } else {
        echo json_encode([
            "status" => "error",
            "message" => "Invalid credentials"
        ]);
    }
    $stmt->close();
}

// 회원가입 처리
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_GET['action']) && $_GET['action'] === 'register') {
    $username = $_POST['username'];
    $password = $_POST['password'];
    $phone_number = $_POST['phone_number'];

    // SQL 쿼리 준비
    $sql = "INSERT INTO Users (username, password, phone_number) VALUES (?, ?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("sss", $username, $password, $phone_number);

    // 쿼리 실행 및 결과 처리
    if ($stmt->execute()) {
        echo json_encode([
            "status" => "success",
            "message" => "User registered successfully"
        ]);
    } else {
        echo json_encode([
            "status" => "error",
            "message" => "Registration failed"
        ]);
    }
    $stmt->close();
}
?>
