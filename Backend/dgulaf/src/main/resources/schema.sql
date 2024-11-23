-- Users 테이블: 사용자 정보
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY, -- 유저 고유 ID
    username VARCHAR(50) NOT NULL,         -- 사용자 이름
    password VARCHAR(100) NOT NULL,        -- 비밀번호
    phone_number VARCHAR(15) NOT NULL,     -- 전화번호
);

-- LostItems 테이블: 분실물 등록 정보
CREATE TABLE LostItems (
    lost_item_id INT AUTO_INCREMENT PRIMARY KEY, -- 분실물 ID
    user_id INT NOT NULL,                        -- 작성자 ID
    title VARCHAR(100) NOT NULL,                -- 제목
    description TEXT,                            -- 설명
    lost_date DATE NOT NULL,                     -- 분실 날짜
    location_id INT NOT NULL,                    -- 위치 ID
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 등록 시각
    FOREIGN KEY (user_id) REFERENCES Users(user_id), 
    FOREIGN KEY (location_id) REFERENCES ItemLocation(location_id)
);

-- FoundItems 테이블: 습득물 등록 정보
CREATE TABLE FoundItems (
    found_item_id INT AUTO_INCREMENT PRIMARY KEY, -- 습득물 ID
    user_id INT NOT NULL,                         -- 작성자 ID
    title VARCHAR(100) NOT NULL,                 -- 제목
    description TEXT,                             -- 설명
    found_date DATE NOT NULL,                     -- 습득 날짜
    location_id INT NOT NULL,                     -- 위치 ID
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 등록 시각
    FOREIGN KEY (user_id) REFERENCES Users(user_id), 
    FOREIGN KEY (location_id) REFERENCES ItemLocation(location_id)
);

-- ItemLocation 테이블: 위치 정보
CREATE TABLE ItemLocation (
    location_id INT AUTO_INCREMENT PRIMARY KEY, -- 위치 ID
    classroom_id INT NOT NULL,                  -- 강의실 ID
    detail VARCHAR(255),                        -- 세부 위치 정보
    FOREIGN KEY (classroom_id) REFERENCES Classrooms(classroom_id)
);

-- Classrooms 테이블: 강의실 정보
CREATE TABLE Classrooms (
    classroom_id INT AUTO_INCREMENT PRIMARY KEY, -- 강의실 ID
    building_name VARCHAR(100) NOT NULL,        -- 건물 이름
    room_number VARCHAR(20) NOT NULL            -- 강의실 번호
);

-- ItemComments 테이블: 댓글 정보
CREATE TABLE ItemComments (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,  -- 댓글 ID
    user_id INT NOT NULL,                       -- 작성자 ID
    item_id INT NOT NULL,                       -- 아이템 ID (분실물/습득물)
    is_lost BOOLEAN NOT NULL,                   -- 분실물 여부 (1=Lost, 0=Found)
    content TEXT NOT NULL,                      -- 댓글 내용
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 댓글 작성 시각
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- ItemImages 테이블: 이미지 정보
CREATE TABLE ItemImages (
    image_id INT AUTO_INCREMENT PRIMARY KEY, -- 이미지 ID
    item_id INT NOT NULL,                    -- 아이템 ID (분실물/습득물)
    is_lost BOOLEAN NOT NULL,                -- 분실물 여부 (1=Lost, 0=Found)
    image_url VARCHAR(255) NOT NULL,         -- 이미지 URL 경로
    FOREIGN KEY (item_id) REFERENCES LostItems(lost_item_id) -- 분실물/습득물 공유 ID
        ON DELETE CASCADE
);
