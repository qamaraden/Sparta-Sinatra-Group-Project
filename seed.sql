-- SPECIALISATION TABLE

DROP TABLE IF EXISTS spec CASCADE;

CREATE TABLE spec (
  spec_id SERIAL PRIMARY KEY,
  spec_name VARCHAR(255) NOT NULL
);

INSERT INTO spec (spec_name) VALUES ('DevOps');
INSERT INTO spec (spec_name) VALUES ('Agile');
INSERT INTO spec (spec_name) VALUES ('Java');


-- ROLES TABLE

DROP TABLE IF EXISTS roles CASCADE;

CREATE TABLE roles (
  role_id SERIAL PRIMARY KEY,
  role_name VARCHAR(255) NOT NULL
);

INSERT INTO roles (role_name) VALUES ('Admin');
INSERT INTO roles (role_name) VALUES ('Trainer');
INSERT INTO roles (role_name) VALUES ('Trainee');


-- COHORTS TABLE

DROP TABLE IF EXISTS cohorts CASCADE;

CREATE TABLE cohorts (
  cohort_id SERIAL PRIMARY KEY,
  cohort_name VARCHAR(255) NOT NULL,
  spec_id INT,
  FOREIGN KEY (spec_id) REFERENCES spec(spec_id)
);

INSERT INTO cohorts (cohort_name, spec_id) VALUES ('Eng-29', 1);
INSERT INTO cohorts (cohort_name, spec_id) VALUES ('Biz-01', 2);
INSERT INTO cohorts (cohort_name, spec_id) VALUES ('Dat-14', 3);


-- USERS TABLE

DROP TABLE IF EXISTS users CASCADE;

CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR (255) NOT NULL,
  email VARCHAR (255) NOT NULL,
  password_salt VARCHAR (255) NOT NULL,
  password_hash VARCHAR (255) NOT NULL,
  cohort_id INT,
  FOREIGN KEY (cohort_id) REFERENCES cohorts (cohort_id),
  role_id INT,
  FOREIGN KEY (role_id) REFERENCES roles (role_id)
);


INSERT INTO users (first_name, last_name, email, password_hash, password_salt, cohort_id, role_id) VALUES ('test1', 'lasttest1', 'test1@spartaglobal.com', 'jgnw83@483', 'jadncjsd', 1, 1);
INSERT INTO users (first_name, last_name, email, password_hash, password_salt, cohort_id, role_id) VALUES ('test2', 'lasttest2', 'test2@spartaglobal.com', 'jgnw83@483', 'jdsakdjsd', 1, 2);
INSERT INTO users (first_name, last_name, email, password_hash, password_salt, cohort_id, role_id) VALUES ('test3', 'lasttest3', 'test3@spartaglobal.com', 'jgnw83@483', 'fdsjfsjdbfd', 2, 2);
INSERT INTO users (first_name, last_name, email, password_hash, password_salt, cohort_id, role_id) VALUES ('test4', 'lasttest4', 'test4@spartaglobal.com', 'jgnw83@483', 'djnjfbsd', 2, 3);
INSERT INTO users (first_name, last_name, email, password_hash, password_salt, cohort_id, role_id) VALUES ('test5', 'lasttest5', 'test5@spartaglobal.com', 'jgnw83@483', 'djsdjdsbf' 3, 3);


--  VIEW WITH ALL DISPALY INFORMATION

DROP TABLE IF EXISTS sparta_view;

CREATE VIEW sparta_view AS SELECT users.user_id, users.first_name, users.last_name, users.email, users.password_salt, users.password_hash, cohorts.cohort_id, cohorts.cohort_name, roles.role_id, roles.role_name, spec.spec_id, spec.spec_name
FROM roles INNER JOIN users ON roles.role_id=users.role_id INNER JOIN cohorts ON cohorts.cohort_id=users.cohort_id INNER JOIN spec ON cohorts.spec_id = spec.spec_id ORDER BY users.first_name;
