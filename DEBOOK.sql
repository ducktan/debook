CREATE DATABASE DEBOOK;
USE DEBOOK;

-- Tạo bảng Users
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(255) UNIQUE,
    password VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(20),
    fullName VARCHAR(255),
    avatar VARCHAR(255),
    role ENUM('free', 'pro', 'premium', 'admin', 'author') DEFAULT 'free',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tạo bảng Categories
CREATE TABLE Categories (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tạo bảng Products
CREATE TABLE Products (
    productId INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    author VARCHAR(255),
    type ENUM('ebook', 'podcast') NOT NULL,
    categoryId BIGINT,
    publicationDate DATE,
    price DECIMAL(10, 2),
    fileUrl VARCHAR(255),
    imageUrl VARCHAR(255),
    duration INT,
    language VARCHAR(50),
    rating FLOAT,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_product_category FOREIGN KEY (categoryId) REFERENCES Categories(id)
);

-- Tạo bảng Subscriptions
CREATE TABLE Subscriptions (
    subscriptionId INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    duration INT,
    durationUnit ENUM('days', 'months', 'years') DEFAULT 'months',
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tạo bảng ProductSubscriptions
CREATE TABLE ProductSubscriptions (
    productSubscriptionId INT PRIMARY KEY AUTO_INCREMENT,
    productId INT,
    subscriptionId INT,
    FOREIGN KEY (productId) REFERENCES Products(productId),
    FOREIGN KEY (subscriptionId) REFERENCES Subscriptions(subscriptionId),
    UNIQUE (productId, subscriptionId)
);

-- Tạo bảng PaymentHistory
CREATE TABLE PaymentHistory (
    paymentId INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    subscriptionId INT,
    amount DECIMAL(10, 2),
    paymentDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (subscriptionId) REFERENCES Subscriptions(subscriptionId)
);

-- Tạo bảng Reviews
CREATE TABLE Reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    productId INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (productId) REFERENCES Products(productId)
);


--Users
INSERT INTO Users (username, password, email, phone, fullName, avatar, role) VALUES
('nguyenvana', 'password123', 'nguyenvana@gmail.com', '0901234567', 'Nguyễn Văn A', 'avatar1.jpg', 'free'),
('tranb', 'password456', 'tranb@gmail.com', '0912345678', 'Trần Thị B', 'avatar2.jpg', 'pro'),
('levanc', 'password789', 'levanc@gmail.com', '0923456789', 'Lê Văn C', 'avatar3.jpg', 'premium'),
('phamd', 'password101', 'phamd@gmail.com', '0934567890', 'Phạm Thị D', 'avatar4.jpg', 'free'),
('hoange', 'password202', 'hoange@gmail.com', '0945678901', 'Hoàng Văn E', 'avatar5.jpg', 'author'),
('nguyentf', 'password303', 'nguyentf@gmail.com', '0956789012', 'Nguyễn Thị F', 'avatar6.jpg', 'admin'),
('vug', 'password404', 'vug@gmail.com', '0967890123', 'Vũ Văn G', 'avatar7.jpg', 'pro'),
('dangh', 'password505', 'dangh@gmail.com', '0978901234', 'Đặng Thị H', 'avatar8.jpg', 'premium'),
('buii', 'password606', 'buii@gmail.com', '0989012345', 'Bùi Văn I', 'avatar9.jpg', 'free'),
('lyk', 'password707', 'lyk@gmail.com', '0990123456', 'Lý Thị K', 'avatar10.jpg', 'author');


--Categories
INSERT INTO Categories (name) VALUES
('Tiểu thuyết'),
('Khoa học viễn tưởng'),
('Tự truyện'),
('Kinh doanh'),
('Tâm lý học'),
('Lịch sử'),
('Podcast giáo dục'),
('Podcast giải trí'),
('Podcast kinh doanh'),
('Podcast văn học');
--Products
INSERT INTO Products (title, description, author, type, categoryId, publicationDate, price, fileUrl, imageUrl, duration, language, rating) VALUES
('Hành Trình Vũ Trụ', 'Khám phá các bí mật của vũ trụ bao la.', 'Nguyễn Văn A', 'ebook', 2, '2025-01-15', 99.99, 'hanh-trinh-vu-tru.pdf', 'hanh-trinh-vu-tru.jpg', NULL, 'Vietnamese', 4.5),
('Bí Mật Hạnh Phúc', 'Những nguyên tắc để sống hạnh phúc.', 'Trần Thị B', 'ebook', 5, '2025-02-10', 49.99, 'bi-mat-hanh-phuc.pdf', 'bi-mat-hanh-phuc.jpg', NULL, 'Vietnamese', 4.0),
('Lập Trình Cơ Bản', 'Hướng dẫn lập trình cho người mới bắt đầu.', 'Lê Văn C', 'ebook', 4, '2025-03-01', 79.99, 'lap-trinh-co-ban.pdf', 'lap-trinh-co-ban.jpg', NULL, 'Vietnamese', 4.8),
('Khám Phá Bản Thân', 'Hiểu rõ bản thân để sống ý nghĩa.', 'Phạm Thị D', 'ebook', 5, '2025-04-05', 59.99, 'kham-pha-ban-than.pdf', 'kham-pha-ban-than.jpg', NULL, 'Vietnamese', 4.2),
('Sống Tối Giản', 'Nghệ thuật sống đơn giản và hạnh phúc.', 'Hoàng Văn E', 'ebook', 5, '2025-05-10', 39.99, 'song-toi-gian.pdf', 'song-toi-gian.jpg', NULL, 'Vietnamese', 4.3),
('Podcast Lịch Sử VN', 'Những câu chuyện lịch sử Việt Nam.', 'Nguyễn Thị F', 'podcast', 6, '2025-06-01', 29.99, 'podcast-lich-su-vn.mp3', 'podcast-lich-su-vn.jpg', 1200, 'Vietnamese', 4.7),
('Podcast Kinh Doanh', 'Chia sẻ kinh nghiệm kinh doanh.', 'Vũ Văn G', 'podcast', 9, '2025-07-01', 19.99, 'podcast-kinh-doanh.mp3', 'podcast-kinh-doanh.jpg', 900, 'Vietnamese', 4.6),
('Tiểu Thuyết Tình Yêu', 'Câu chuyện tình yêu đầy cảm xúc.', 'Đặng Thị H', 'ebook', 1, '2025-08-01', 69.99, 'tieu-thuyet-tinh-yeu.pdf', 'tieu-thuyet-tinh-yeu.jpg', NULL, 'Vietnamese', 4.1),
('Podcast Giải Trí', 'Những câu chuyện vui vẻ và hài hước.', 'Bùi Văn I', 'podcast', 8, '2025-09-01', 14.99, 'podcast-giai-tri.mp3', 'podcast-giai-tri.jpg', 600, 'Vietnamese', 4.0),
('Lịch Sử Thế Giới', 'Khám phá lịch sử thế giới qua các thời kỳ.', 'Lý Thị K', 'ebook', 6, '2025-10-01', 89.99, 'lich-su-the-gioi.pdf', 'lich-su-the-gioi.jpg', NULL, 'Vietnamese', 4.9);

--Subscriptions
INSERT INTO Subscriptions (name, description, price, duration, durationUnit) VALUES
('Basic Monthly', 'Gói cơ bản 1 tháng.', 50.00, 1, 'months'),
('Basic Yearly', 'Gói cơ bản 1 năm.', 500.00, 1, 'years'),
('Pro Monthly', 'Gói Pro 1 tháng.', 100.00, 1, 'months'),
('Pro Yearly', 'Gói Pro 1 năm.', 1000.00, 1, 'years'),
('Premium Monthly', 'Gói Premium 1 tháng.', 200.00, 1, 'months'),
('Premium Yearly', 'Gói Premium 1 năm.', 2000.00, 1, 'years'),
('Trial 7 Days', 'Gói dùng thử 7 ngày.', 0.00, 7, 'days'),
('Trial 14 Days', 'Gói dùng thử 14 ngày.', 0.00, 14, 'days'),
('Author Monthly', 'Gói dành cho tác giả 1 tháng.', 150.00, 1, 'months'),
('Author Yearly', 'Gói dành cho tác giả 1 năm.', 1500.00, 1, 'years');
--ProductSubscriptions
INSERT INTO ProductSubscriptions (productId, subscriptionId) VALUES
(1, 3), -- Hành Trình Vũ Trụ cần gói Pro Monthly
(1, 4), -- Hành Trình Vũ Trụ cần gói Pro Yearly
(2, 1), -- Bí Mật Hạnh Phúc cần gói Basic Monthly
(2, 2), -- Bí Mật Hạnh Phúc cần gói Basic Yearly
(3, 5), -- Lập Trình Cơ Bản cần gói Premium Monthly
(3, 6), -- Lập Trình Cơ Bản cần gói Premium Yearly
(4, 1), -- Khám Phá Bản Thân cần gói Basic Monthly
(5, 3), -- Sống Tối Giản cần gói Pro Monthly
(6, 7), -- Podcast Lịch Sử VN cần gói Trial 7 Days
(7, 9); -- Podcast Kinh Doanh cần gói Author Monthly
--PaymentHistory
INSERT INTO PaymentHistory (user_id, subscriptionId, amount, paymentDate) VALUES
(1, 1, 50.00, '2025-01-01 10:00:00'), -- Nguyễn Văn A mua gói Basic Monthly
(2, 3, 100.00, '2025-02-01 12:00:00'), -- Trần Thị B mua gói Pro Monthly
(3, 5, 200.00, '2025-03-01 14:00:00'), -- Lê Văn C mua gói Premium Monthly
(4, 1, 50.00, '2025-04-01 16:00:00'), -- Phạm Thị D mua gói Basic Monthly
(5, 9, 150.00, '2025-05-01 18:00:00'), -- Hoàng Văn E mua gói Author Monthly
(6, 6, 2000.00, '2025-06-01 20:00:00'), -- Nguyễn Thị F mua gói Premium Yearly
(7, 3, 100.00, '2025-07-01 22:00:00'), -- Vũ Văn G mua gói Pro Monthly
(8, 5, 200.00, '2025-08-01 09:00:00'), -- Đặng Thị H mua gói Premium Monthly
(9, 7, 0.00, '2025-09-01 11:00:00'), -- Bùi Văn I dùng gói Trial 7 Days
(10, 10, 1500.00, '2025-10-01 13:00:00'); -- Lý Thị K mua gói Author Yearly
--Reviews
INSERT INTO Reviews (user_id, productId, rating, comment, created_at) VALUES
(1, 1, 5, 'Sách rất hay, đáng đọc!', '2025-01-15 08:00:00'),
(2, 2, 4, 'Nội dung bổ ích, nhưng cần thêm ví dụ.', '2025-02-15 09:00:00'),
(3, 3, 5, 'Hướng dẫn rất chi tiết, phù hợp cho người mới.', '2025-03-15 10:00:00'),
(4, 4, 3, 'Sách ổn, nhưng hơi ngắn.', '2025-04-15 11:00:00'),
(5, 5, 4, 'Phong cách sống tối giản rất thú vị.', '2025-05-15 12:00:00'),
(6, 6, 5, 'Podcast rất hấp dẫn, giọng kể cuốn hút.', '2025-06-15 13:00:00'),
(7, 7, 4, 'Nội dung kinh doanh thực tế, đáng nghe.', '2025-07-15 14:00:00'),
(8, 8, 3, 'Tiểu thuyết hơi buồn, không hợp gu mình.', '2025-08-15 15:00:00'),
(9, 9, 4, 'Podcast giải trí vui vẻ, nghe rất thư giãn.', '2025-09-15 16:00:00'),
(10, 10, 5, 'Sách lịch sử rất chi tiết, học được nhiều điều.', '2025-10-15 17:00:00');
