# SQL Data Analysis Project

[![SQL](https://img.shields.io/badge/Language-SQL-blue)]()
[![License](https://img.shields.io/badge/License-MIT-lightgrey)]()

Para acessar este README em português, veja [README.pt-br.md](README.pt-br.md).

Overview
--------
This project analyzes job postings to surface insights about the data analytics job market — top-paying Data Analyst roles, the most in-demand skills, and which skills correlate with higher salaries. The work recreates and expands a tutorial by [Luke Barousse](https://www.youtube.com/@LukeBarousse) and stores the SQL used in the repository.

SQL queries: /practice_project_sql/

Table of contents
- Background
- Dataset
- How to run
- Key analyses & queries
- Project structure
- What I learned
- Contributing & License
- Contact

Background
----------
The rise of data analytics has made Data Analyst roles highly sought-after. This project focuses on the intersection of demand and salary to help learners and job-seekers prioritize skills and roles.

Key questions answered:
- What are the top-paying jobs for Data Analysts?
- What skills do those roles require?
- Which skills are most in-demand across postings?
- Which skills are associated with higher salaries?
- What skills are optimal to learn given demand and compensation?

Tools used
----------
- SQL (queries in /practice_project_sql/)
- PostgreSQL (data warehouse)
- Visual Studio Code (development)
- Git & GitHub (version control)

If you want to reproduce the analysis, PostgreSQL + a SQL client is sufficient; no special packages are required.

The analysis
------------
Each query in /practice_project_sql/ is focused on one of the questions above. The analysis includes:
- Top-paying Data Analyst roles (global, remote filters)
- Skills associated with high-paying roles
- Most frequently requested skills (overall and remote-only)
- Average salaries by skill (and by remote vs. all jobs)
- A combined demand-and-salary ranking to suggest optimal skills to learn

Example query: Top-paying Data Analyst roles
------------------------------------------
To identify highest-paying roles (remote/Anywhere) with non-null average yearly salaries:

```sql
SELECT
    j.job_title,
    j.salary_year_avg,
    c.name AS company_name
FROM job_postings_fact j
LEFT JOIN company_dim c ON c.company_id = j.company_id
WHERE j.job_title_short = 'Data Analyst'
  AND j.salary_year_avg IS NOT NULL
  AND j.job_location = 'Anywhere'
ORDER BY j.salary_year_avg DESC
LIMIT 10;
```

Summary of results
- Salaries observed in the top 10 ranged widely, reflecting both senior roles and specialized positions.
- Employers include big tech and specialized analytics companies.

The repo contains charts (assets/) that visualize top skills, salary comparisons, and demand charts. See the images in /assets/ for visuals referenced by the analyses.

Key insights (high-level)
- SQL is essential across roles.
- Visualization and analytics tooling (Tableau, Power BI) remain in demand.
- Specialized big-data and ML frameworks command higher salaries in some listings.

Dataset
-------
The analysis is based on a job-postings dataset that has been normalized into:
- job_postings_fact (job_id, title, salary_year_avg, location, work_from_home flag, ...)
- skills_dim (skill_id, skills)
- skills_job_dim (job_id, skill_id)
- company_dim (company_id, name)

If you plan to run the SQL locally, ensure you have the CSV/Parquet source files (not included here) and load them into PostgreSQL following the schema in /practice_project_sql/README (or the top of each script).

How to run
----------
1. Install PostgreSQL and create a database (e.g., data_jobs).
2. Load the raw data into tables matching the names used in the SQL scripts.
3. Run the SQL scripts in /practice_project_sql/ in the order described in the scripts or their README.
4. Export query outputs to CSV and use any visualization tool (Python/matplotlib, Tableau, Excel) to recreate charts in /assets/.

Tip: each SQL file begins with a short description and any assumptions about data cleaning.

Project structure
-----------------
/practice_project_sql/   - SQL scripts used for analysis (queries are numbered and commented)
/assets/                - Charts and images generated from query outputs
README.md               - This file

Key analyses (examples)
- Most in-demand skills (counts)
- Top skills by average salary
- Demand vs salary combined ranking (recommended skills to learn)

Example: top 5 most in-demand skills (SQL snippet)
```sql
SELECT s.skills AS skill_name, COUNT(sj.job_id) AS demand_count
FROM job_postings_fact j
JOIN skills_job_dim sj ON j.job_id = sj.job_id
JOIN skills_dim s ON sj.skill_id = s.skill_id
WHERE j.job_title_short = 'Data Analyst'
GROUP BY s.skills
ORDER BY demand_count DESC
LIMIT 5;
```

What I learned
--------------
- Practical SQL for business questions and combining multiple tables (JOINs, GROUP BY, HAVING).
- Filtering and segmenting (remote vs on-site) gives different perspectives on demand and pay.
- How to present SQL outputs as charts for storytelling.

Contributing
------------
Contributions are welcome. To help:
1. Open an issue describing the change or dataset you want to add.
2. Create a branch, add scripts or cleaned datasets (avoid uploading PII or copyrighted data), and open a pull request.

Suggested follow-ups
- Add a CONTRIBUTING.md with contribution guidelines.
- Add sample data or a small synthetic dataset for others to run the queries quickly.

License
-------
This repository is intended to be MIT-licensed (add LICENSE file if you want to make it official).

Contact
-------
If you have questions or feedback:
- GitHub: https://github.com/SujalPyDev
- Email: sujaljaswal089@gmail.com

Credits
-------
Inspired by and adapted from content by Luke Barousse: https://www.youtube.com/@LukeBarousse

---
Feel free to ask me to create the PR with these changes, add a CONTRIBUTING.md and LICENSE, or also create a small synthetic dataset to allow easy reproduction of the queries.
