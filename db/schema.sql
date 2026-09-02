-- EduPath schema (matches JPA entities; Hibernate ddl-auto=update also works)

CREATE TABLE IF NOT EXISTS users (
    user_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(80) NOT NULL,
    last_name VARCHAR(80) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    mobile VARCHAR(20),
    password_hash VARCHAR(128) NOT NULL,
    class_level VARCHAR(10),
    stream VARCHAR(80),
    state VARCHAR(80),
    percentage DECIMAL(5,2),
    role VARCHAR(20) NOT NULL DEFAULT 'student',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS aptitude_results (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    apt_score INT NOT NULL,
    pcm_score INT NOT NULL,
    comm_score INT NOT NULL,
    arts_score INT NOT NULL,
    analyst_score INT NOT NULL,
    leader_score INT NOT NULL,
    humanist_score INT NOT NULL,
    recommendation VARCHAR(20) NOT NULL,
    test_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE IF NOT EXISTS colleges (
    college_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(180) NOT NULL,
    city VARCHAR(120) NOT NULL,
    state VARCHAR(120) NOT NULL,
    college_type VARCHAR(120) NOT NULL,
    stream VARCHAR(120) NOT NULL,
    fees INT NOT NULL,
    cutoff INT NOT NULL,
    nirf_rank INT NOT NULL,
    entrance_exam VARCHAR(80),
    rating DECIMAL(3,1) DEFAULT 0
);

CREATE TABLE IF NOT EXISTS saved_colleges (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    college_id BIGINT NOT NULL,
    saved_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (college_id) REFERENCES colleges(college_id)
);
