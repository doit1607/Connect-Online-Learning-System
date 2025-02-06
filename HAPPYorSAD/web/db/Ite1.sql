/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/SQLTemplate.sql to edit this template
 */
/**
 * Author:  Ann
 * Created: Feb 6, 2025
 */

-- B?ng Users (s?a tên t? User ?? tránh xung ??t t? khóa)
CREATE TABLE Users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(255) NOT NULL UNIQUE,
	fullname NVARCHAR(255) NOT NULL,
    avatar_path NVARCHAR(MAX),
    password NVARCHAR(255) NOT NULL,
    status NVARCHAR(10) DEFAULT 'active' CHECK (status IN ('active', 'inactive')),
    email NVARCHAR(100) UNIQUE NOT NULL,
    address TEXT,
    phone_number NVARCHAR(15) UNIQUE,
    date_of_birth DATE,
    gender NVARCHAR(10) CHECK (gender IN ('male', 'female')),
    created_at DATETIME2 DEFAULT GETDATE(),
    role NVARCHAR(25),
    is_guest BIT DEFAULT 0
);


-- B?ng Manager
CREATE TABLE Manager (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    name NVARCHAR(100) NOT NULL,
    created_at DATETIME2 DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE
);

-- B?ng Mentor
CREATE TABLE Mentor (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    name NVARCHAR(100) NOT NULL,
    email NVARCHAR(255) NOT NULL UNIQUE,
    rating FLOAT DEFAULT 0 CHECK (rating >= 0 AND rating <= 5),
	is_deleted BIT DEFAULT 0,
    reviews TEXT,
    price_per_slot DECIMAL(10,2) CHECK (price_per_slot >= 0),
    expertise NVARCHAR(MAX),
    bio NVARCHAR(MAX),
    created_at DATETIME2 DEFAULT GETDATE(),
    base_rate DECIMAL(10,2),
    multiplier DECIMAL(3,2),
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE
);

-- B?ng Mentee
CREATE TABLE Mentee (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    name NVARCHAR(100) NOT NULL,
	is_deleted BIT DEFAULT 0,
    email NVARCHAR(100) NOT NULL UNIQUE,
    goals NVARCHAR(MAX),
    created_at DATETIME2 DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE
);

-- B?ng CourseMajor

CREATE TABLE CourseMajor (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL UNIQUE,
    description NVARCHAR(MAX)
);
-- B?ng Course
CREATE TABLE Course (
    id INT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(255) NOT NULL,
    description NVARCHAR(MAX),
    manager_id INT NOT NULL,
    mentor_id INT NOT NULL,
	status NVARCHAR(10) DEFAULT 'active' CHECK (status IN ('active', 'inactive')),
    created_at DATETIME2 DEFAULT GETDATE(),
    updated_at DATETIME2 DEFAULT GETDATE(),
    course_major_id INT NOT NULL,
    FOREIGN KEY (manager_id) REFERENCES Manager(id) ON DELETE NO ACTION,
    FOREIGN KEY (mentor_id) REFERENCES Mentor(id) ON DELETE NO ACTION,
    FOREIGN KEY (course_major_id) REFERENCES CourseMajor(id) ON DELETE NO ACTION
);


CREATE TABLE mentor_reviews (
    id INT IDENTITY(1,1) PRIMARY KEY,
    mentor_id INT NOT NULL,
    mentee_id INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment NVARCHAR(MAX),
    created_at DATETIME2 DEFAULT GETDATE(),
    FOREIGN KEY (mentor_id) REFERENCES Mentor(id) ON DELETE NO ACTION,
    FOREIGN KEY (mentee_id) REFERENCES Mentee(id) ON DELETE NO ACTION
);



-- Chèn dữ liệu vào bảng Users
INSERT INTO Users (username, fullname, avatar_path, password, status, email, address, phone_number, date_of_birth, gender, role, is_guest)
VALUES
('john_doe', 'John Doe', NULL, '123', 'active', 'john.doe@example.com', '123 Main St', '1234567890', '1990-05-10', 'male', 'mentor', 0),
('jane_smith', 'Jane Smith', NULL, '123', 'active', 'jane.smith@example.com', '456 Elm St', '0987654321', '1985-07-20', 'female', 'mentee', 0),
('michael_brown', 'Michael Brown', NULL, '123', 'inactive', 'michael.b@example.com', '789 Oak St', '1112223333', '1992-03-15', 'male', 'manager', 0),
('emily_white', 'Emily White', NULL, '123', 'active', 'emily.w@example.com', '321 Pine St', '2223334444', '1995-09-25', 'female', 'mentor', 0),
('david_black', 'David Black', NULL, '123', 'active', 'david.b@example.com', '654 Cedar St', '3334445555', '1988-11-30', 'male', 'mentee', 0),
('sarah_green', 'Sarah Green', NULL, '123', 'active', 'sarah.g@example.com', '987 Birch St', '4445556666', '1991-06-18', 'female', 'manager', 0),
('chris_wilson', 'Chris Wilson', NULL, '123', 'inactive', 'chris.w@example.com', '741 Spruce St', '5556667777', '1987-12-05', 'male', 'mentor', 0),
('anna_moore', 'Anna Moore', NULL, '123', 'active', 'anna.m@example.com', '852 Redwood St', '6667778888', '1994-04-22', 'female', 'mentee', 0),
('robert_jones', 'Robert Jones', NULL, '123', 'active', 'robert.j@example.com', '963 Fir St', '7778889999', '1993-08-14', 'male', 'manager', 0),
('linda_clark', 'Linda Clark', NULL, '123', 'active', 'linda.c@example.com', '159 Cypress St', '8889990000', '1986-10-10', 'female', 'mentor', 0);


-- Chèn dữ liệu vào bảng Manager
INSERT INTO Manager (user_id, name)
VALUES
(3, 'Michael Brown'),
(6, 'Sarah Green'),
(9, 'Robert Jones');

-- Chèn dữ liệu vào bảng Mentor
INSERT INTO Mentor (user_id, name, email, rating, reviews, price_per_slot, expertise, bio, base_rate, multiplier)
VALUES
(1, 'John Doe', 'john.doe@example.com', 4.5, 'Great mentor', 50.00, 'Software Engineering', 'Experienced developer', 40.00, 1.2),
(4, 'Emily White', 'emily.w@example.com', 4.8, 'Very knowledgeable', 60.00, 'Data Science', 'PhD in Data Science', 50.00, 1.3),
(7, 'Chris Wilson', 'chris.w@example.com', 4.2, 'Helpful', 45.00, 'Cybersecurity', 'Cybersecurity expert', 35.00, 1.1),
(10, 'Linda Clark', 'linda.c@example.com', 4.9, 'Highly recommended', 70.00, 'Machine Learning', '10 years in AI research', 60.00, 1.4);

-- Chèn dữ liệu vào bảng Mentee
INSERT INTO Mentee (user_id, name, email, goals)
VALUES
(2, 'Jane Smith', 'jane.smith@example.com', 'Learn programming'),
(5, 'David Black', 'david.b@example.com', 'Improve problem-solving skills'),
(8, 'Anna Moore', 'anna.m@example.com', 'Become a data scientist');

-- Chèn dữ liệu vào bảng CourseMajor
INSERT INTO CourseMajor (name, description)
VALUES
('Computer Science', 'Covers fundamental computing concepts'),
('Data Science', 'Focus on data analytics and machine learning'),
('Cybersecurity', 'Covers security best practices and hacking prevention');

-- Chèn dữ liệu vào bảng Course
INSERT INTO Course (title, description, manager_id, mentor_id, course_major_id)
VALUES
('Intro to Programming', 'Basic programming concepts', 1, 1, 1),
('Machine Learning Basics', 'Introduction to ML algorithms', 2, 2, 2),
('Cybersecurity Fundamentals', 'Learn the basics of security', 3, 3, 3);

-- Chèn dữ liệu vào bảng mentor_reviews
INSERT INTO mentor_reviews (mentor_id, mentee_id, rating, comment)
VALUES
(1, 1, 5, 'Fantastic mentor!'),
(2, 2, 4, 'Very helpful and patient'),
(3, 3, 5, 'Learned a lot!');


select * from Users
select * from Course
