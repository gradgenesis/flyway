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
    CONSTRAINT fk_organization
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

-- 4. Users Table
CREATE TABLE IF NOT EXISTS Users (
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    branch_id INT NOT NULL,
    role_id INT,
    org_id INT NOT NULL,
    CONSTRAINT fk_branch
        FOREIGN KEY (branch_id)
        REFERENCES Branch(branch_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_role
        FOREIGN KEY (role_id)
        REFERENCES Roles(role_id)
        ON DELETE SET NULL,
    CONSTRAINT fk_organization
        FOREIGN KEY (org_id)
        REFERENCES Organization(org_id)
        ON DELETE CASCADE,
    CONSTRAINT uq_user_org_branch UNIQUE (full_name, org_id, branch_id)
);

-- 5. UserDetails Table
CREATE TABLE IF NOT EXISTS UserDetails (
    detail_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    email VARCHAR(255),
    contact_no VARCHAR(20),
    dob DATE,
    address_details TEXT,
    org_id INT NOT NULL,
    branch_id INT NOT NULL,
    CONSTRAINT fk_user
        FOREIGN KEY (user_id)
        REFERENCES Users(user_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_org
        FOREIGN KEY (org_id)
        REFERENCES Organization(org_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_branch
        FOREIGN KEY (branch_id)
        REFERENCES Branch(branch_id)
        ON DELETE CASCADE,
    CONSTRAINT uq_user_details UNIQUE (user_id, org_id, branch_id)
);
