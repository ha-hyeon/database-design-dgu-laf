<?php
include 'db.php';

// 아이템 등록
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action']) && $_POST['action'] === 'create') {
    $user_id = $_POST['user_id'];
    $item_type = $_POST['item_type'];
    $title = $_POST['title'];
    $item_date = $_POST['item_date'];
    $description = $_POST['description'];
    $classroom_id = $_POST['classroom_id'];
    $detail_location = $_POST['detail_location'];
    $tag_id = $_POST['tag_id']; // 태그 아이디 추가

    $sql = "INSERT INTO Items (user_id, item_type, title, item_date, description, classroom_id, detail_location, tag_id) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("issssisi", $user_id, $item_type, $title, $item_date, $description, $classroom_id, $detail_location, $tag_id);

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



//필터링, 클래스룸, 태그
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $action = isset($_GET['action']) ? $_GET['action'] : '';

    //상세정보
    if ($action === 'get_item' && isset($_GET['item_id'])) {
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
        exit;
    }

    // 최근 아이템 목록 조회
    if ($action === 'recent') {
        $sql = "SELECT * FROM Items ORDER BY created_at DESC LIMIT 20";
        $result = $conn->query($sql);

        $items = [];
        while ($row = $result->fetch_assoc()) {
            $items[] = $row;
        }

        echo json_encode($items);
        exit;
    }

    // 내 아이템 목록 조회
    if ($action === 'my_items' && isset($_GET['user_id'])) {
        $user_id = intval($_GET['user_id']); // user_id를 정수로 변환하여 안전하게 처리

        $sql = "SELECT * FROM Items WHERE user_id = ? ORDER BY created_at DESC";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("i", $user_id);

        if ($stmt->execute()) {
            $result = $stmt->get_result();
            $items = [];

            while ($row = $result->fetch_assoc()) {
                $items[] = $row;
            }

            echo json_encode(["status" => "success", "items" => $items]);
        } else {
            echo json_encode(["status" => "error", "message" => "Failed to fetch items"]);
        }

        $stmt->close();
        exit;
    }

    // 클래스룸 정보 조회
    if ($action === 'get_classroom' && isset($_GET['classroom_id'])) {
        $classroom_id = $_GET['classroom_id'];

        $sql = "SELECT building_name FROM Classrooms WHERE classroom_id = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("i", $classroom_id);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($row = $result->fetch_assoc()) {
            echo json_encode(["status" => "success", "building_name" => $row['building_name']]);
        } else {
            echo json_encode(["status" => "error", "message" => "Classroom not found"]);
        }

        $stmt->close();
        exit; // 이 요청의 처리가 끝났으므로 종료
    }

    // 태그 정보 조회
    if ($action === 'get_tag' && isset($_GET['tag_id'])) {
        $tag_id = $_GET['tag_id'];

        $sql = "SELECT tag_name FROM Tags WHERE tag_id = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("i", $tag_id);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($row = $result->fetch_assoc()) {
            echo json_encode(["status" => "success", "tag_name" => $row['tag_name']]);
        } else {
            echo json_encode(["status" => "error", "message" => "Tag not found"]);
        }

        $stmt->close();
        exit; // 이 요청의 처리가 끝났으므로 종료
    }

    // 필터링된 아이템 목록 조회
    if ($action === 'filter') {
        $title = isset($_GET['title']) ? $_GET['title'] : '';
        $classroom_id = isset($_GET['classroom_id']) ? $_GET['classroom_id'] : 1;
        $item_type = isset($_GET['item_type']) ? $_GET['item_type'] : '';
        $tag_id = isset($_GET['tag_id']) ? $_GET['tag_id'] : 1;

        $items = [];

        if ($tag_id == 1) {
            if ($classroom_id == 1) {
                $sql = "SELECT * FROM Items WHERE title LIKE ? AND item_type = ?";
                $stmt = $conn->prepare($sql);
                $title = "%$title%";
                $stmt->bind_param("ss", $title, $item_type);
            } else {
                $sql = "SELECT * FROM Items WHERE title LIKE ? AND classroom_id = ? AND item_type = ?";
                $stmt = $conn->prepare($sql);
                $title = "%$title%";
                $stmt->bind_param("sis", $title, $classroom_id, $item_type);
            }
        } else {
            if ($classroom_id == 1) {
                $sql = "SELECT * FROM Items WHERE title LIKE ? AND item_type = ? AND tag_id = ?";
                $stmt = $conn->prepare($sql);
                $title = "%$title%";
                $stmt->bind_param("ssi", $title, $item_type, $tag_id);
            } else {
                $sql = "SELECT * FROM Items WHERE title LIKE ? AND classroom_id = ? AND item_type = ? AND tag_id = ?";
                $stmt = $conn->prepare($sql);
                $title = "%$title%";
                $stmt->bind_param("sisi", $title, $classroom_id, $item_type, $tag_id);
            }
        }

        $stmt->execute();
        $result = $stmt->get_result();

        while ($row = $result->fetch_assoc()) {
            $items[] = $row;
        }

        $stmt->close();

        // items만 리턴
        echo json_encode($items);
        exit; // 이 요청의 처리가 끝났으므로 종료
    }

    // 기본 응답
    echo json_encode(["status" => "error", "message" => "Invalid request"]);
    exit;
}
?>
