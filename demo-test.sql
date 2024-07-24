-- Drop the usersLine table if it exists
DROP TABLE IF EXISTS usersLine;

-- Create the usersLine table
CREATE TABLE usersLine(
    userLineID VARCHAR(100) PRIMARY KEY, 
    accessToken VARCHAR(100), -- as a bearer token
    displayName VARCHAR(100),
    imgURL VARCHAR(100)
);

-- Drop the users table if it exists
DROP TABLE IF EXISTS users;

-- Create the users table
CREATE TABLE users(
    userID VARCHAR(100) PRIMARY KEY,
    name VARCHAR(100),
    age INT
);

-- Insert a record into the usersLine table
INSERT INTO usersLine (userLineID, accessToken, displayName, imgURL) VALUES
    ('mockID', 
    'mockToken',
    'mockName', 
    'https://profile.line-scdn.net/mock');

-- Select all records from the usersLine table
SELECT * FROM usersLine;
