-- SPECIALISATION TABLE

DROP TABLE IF EXISTS spec CASCADE;

CREATE TABLE spec (
  specId SERIAL PRIMARY KEY,
  specName VARCHAR(255) NOT NULL
);

INSERT INTO spec (specName) VALUES ('DevOps');
INSERT INTO spec (specName) VALUES ('Agile');
INSERT INTO spec (specName) VALUES ('Java');


-- ROLES TABLE

DROP TABLE IF EXISTS roles CASCADE;

CREATE TABLE roles (
  roleId SERIAL PRIMARY KEY,
  roleName VARCHAR(255) NOT NULL
);

INSERT INTO roles (roleName) VALUES ('Admin');
INSERT INTO roles (roleName) VALUES ('Trainer');
INSERT INTO roles (roleName) VALUES ('Trainee');


-- COHORTS TABLE

DROP TABLE IF EXISTS cohorts CASCADE;

CREATE TABLE cohorts (
  cohortId SERIAL PRIMARY KEY,
  cohortName VARCHAR(255) NOT NULL,
  specId INT,
  FOREIGN KEY (specId) REFERENCES spec(specId)
);

INSERT INTO cohorts (cohortName, specId) VALUES ('Eng-29', 1);
INSERT INTO cohorts (cohortName, specId) VALUES ('Biz-01', 2);
INSERT INTO cohorts (cohortName, specId) VALUES ('Dat-14', 3);


-- USERS TABLE

DROP TABLE IF EXISTS users CASCADE;

CREATE TABLE users (
  userId SERIAL PRIMARY KEY,
  firstName VARCHAR(255) NOT NULL,
  lastName VARCHAR (255) NOT NULL,
  email VARCHAR (255) NOT NULL,
  password VARCHAR (255) NOT NULL,
  cohortId INT,
  FOREIGN KEY (cohortId) REFERENCES cohorts (cohortId),
  roleId INT,
  FOREIGN KEY (roleId) REFERENCES roles (roleId)
);


INSERT INTO users (firstName, lastName, email, password, cohortId, roleId) VALUES ('test1', 'lasttest1', 'test1@spartaglobal.com', 'jgnw83@483', 1, 1);
INSERT INTO users (firstName, lastName, email, password, cohortId, roleId) VALUES ('test2', 'lasttest2', 'test2@spartaglobal.com', 'jgnw83@483', 1, 2);
INSERT INTO users (firstName, lastName, email, password, cohortId, roleId) VALUES ('test3', 'lasttest3', 'test3@spartaglobal.com', 'jgnw83@483', 2, 2);
INSERT INTO users (firstName, lastName, email, password, cohortId, roleId) VALUES ('test4', 'lasttest4', 'test4@spartaglobal.com', 'jgnw83@483', 2, 3);
INSERT INTO users (firstName, lastName, email, password, cohortId, roleId) VALUES ('test5', 'lasttest5', 'test5@spartaglobal.com', 'jgnw83@483', 3, 3);
