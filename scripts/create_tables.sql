CREATE TABLE IF NOT EXISTS company_dim (
  company_id INTEGER PRIMARY KEY,
  name TEXT
);
CREATE TABLE IF NOT EXISTS job_postings_fact (
  job_id INTEGER PRIMARY KEY,
  job_title TEXT,
  job_title_short TEXT,
  salary_year_avg INTEGER,
  job_location TEXT,
  job_work_from_home BOOLEAN,
  company_id INTEGER
);
CREATE TABLE IF NOT EXISTS skills_dim (
  skill_id INTEGER PRIMARY KEY,
  skills TEXT
);
CREATE TABLE IF NOT EXISTS skills_job_dim (
  job_id INTEGER,
  skill_id INTEGER
);
