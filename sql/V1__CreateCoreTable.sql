-- 1. Organization Table
CREATE TABLE IF NOT EXISTS Organization (
    org_id SERIAL PRIMARY KEY,
    org_name VARCHAR(255) NOT NULL,
    org_type VARCHAR(100),
    email VARCHAR(255),
    phone VARCHAR(20),
    address TEXT,
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    postal_code VARCHAR(20),
    website_url VARCHAR(255)
);

-- 2. Branch Table
CREATE TABLE IF NOT EXISTS Branch (
    branch_id SERIAL PRIMARY KEY,
    branch_name VARCHAR(255) NOT NULL,
    org_id INT NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(20),
    address TEXT,
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    postal_code VARCHAR(20),
    CONSTRAINT fk_branch_org
        FOREIGN KEY (org_id)
        REFERENCES Organization(org_id)
        ON DELETE CASCADE,
    CONSTRAINT uq_branch_org UNIQUE (branch_name, org_id)
);

-- 3. Roles Table
CREATE TABLE IF NOT EXISTS Roles (
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(100) NOT NULL
);

-- 4. Users Table (created before UserDetails, without full_name)
CREATE TABLE IF NOT EXISTS Users (
    user_id SERIAL PRIMARY KEY,
    branch_id INT NOT NULL,
    role_id INT,
    CONSTRAINT fk_user_branch
        FOREIGN KEY (branch_id)
        REFERENCES Branch(branch_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_user_role
        FOREIGN KEY (role_id)
        REFERENCES Roles(role_id)
        ON DELETE SET NULL
);

-- 5. UserDetails Table (references Users)
CREATE TABLE IF NOT EXISTS UserDetails (
    user_id INT PRIMARY KEY, -- same as Users.user_id
    first_name VARCHAR(100),
    middle_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(255),
    contact_no VARCHAR(20),
    dob DATE,
    gender VARCHAR(10),
    profile_picture_url VARCHAR(255),
    emergency_contact VARCHAR(255),
    nationality VARCHAR(100),
    joining_date DATE,
    is_active BOOLEAN,
    CONSTRAINT fk_user_details
        FOREIGN KEY (user_id)
        REFERENCES Users(user_id)
        ON DELETE CASCADE
);


