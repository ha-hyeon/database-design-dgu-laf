<?php
include 'db.php'; // 데이터베이스 연결

if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['classroom_id'])) {
    $classroom_id = intval($_GET['classroom_id']); // classroom_id를 정수로 변환

    // classroom_id에 해당하는 building_name 조회
    $sql = "SELECT building_name FROM Classrooms WHERE classroom_id = ?";
    $stmt = $pdo->prepare($sql);
    $stmt->bindParam(1, $classroom_id, PDO::PARAM_INT);
    $stmt->execute();

    // 결과 가져오기
    if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        // 성공적으로 조회된 경우 building_name 반환
        echo json_encode([
            'status' => 'success',
            'building_name' => $row['building_name']
        ]);
    } else {
        // classroom_id에 해당하는 데이터가 없는 경우
        echo json_encode([
            'status' => 'error',
            'message' => 'No building found for the given classroom_id.'
        ]);
    }
    $stmt->close();
}
?>