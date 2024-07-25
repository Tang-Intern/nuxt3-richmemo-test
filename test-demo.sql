DROP TABLE IF EXISTS usersLine;

CREATE TABLE usersLine(
    userLineID VARCHAR(100) PRIMARY KEY, 
    accessToken VARCHAR(100), -- as a bearer token
    displayName VARCHAR(100),
    imgURL VARCHAR(100),
	date DATE
);

DROP TABLE IF EXISTS users;

CREATE TABLE users(
    userID VARCHAR(100) PRIMARY KEY,
    name VARCHAR(100),
    age INT
);

INSERT INTO usersLine (userLineID, accessToken, displayName, imgURL) VALUES
    ('mockID', 
    'mockToken',
    'mockName', 
    'https://profile.line-scdn.net/mock');

SELECT * FROM usersLine;
