DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS question_followers;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_likes;

CREATE TABLE users (
  id INTEGER PRIMARY KEY NOT NULL,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY NOT NULL,
  title VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_followers (
  id INTEGER PRIMARY KEY NOT NULL,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY NOT NULL,
  body TEXT NOT NULL,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  parent_id INTEGER,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY NOT NULL,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users
  (fname, lname)
VALUES
  ('Eric', 'Schwarzenbach'),
  ('Scott', 'Schupbach'),
  ('Super', 'Man')
;

INSERT INTO
  questions
  (title,body,user_id)
VALUES
  ('SQL Question', 'How do I insert stuff?', 1),
  ('Dumb Question', 'No actual info', 2),
  ('No likes', 'No follows either', 2)
;

INSERT INTO
  replies
  (body, question_id, user_id, parent_id)
VALUES
  ('Use insert!', 1, 2, NULL),
  ('Thanks', 1, 1, 1)
;

INSERT INTO
  question_followers
  (user_id, question_id)
VALUES
  (2, 1),
  (1, 2),
  (2, 2),
  (3, 2)
;

INSERT INTO
  question_likes
  (user_id, question_id)
VALUES
  (1, 1),
  (2, 1),
  (3, 2),
  (2, 2),
  (1, 2)
;
