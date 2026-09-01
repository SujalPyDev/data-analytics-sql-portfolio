#!/usr/bin/env bash
# Usage: ./scripts/load_sample_data.sh
# This script creates the 'data_jobs' database (if it does not exist), creates the tables, and loads sample CSV files.

DBNAME=data_jobs
psql -c "CREATE DATABASE ${DBNAME};" 2>/dev/null || true
psql -d ${DBNAME} -f scripts/create_tables.sql
psql -d ${DBNAME} -c "\copy company_dim FROM 'data/sample_companies.csv' CSV HEADER;"
psql -d ${DBNAME} -c "\copy job_postings_fact FROM 'data/sample_job_postings.csv' CSV HEADER;"
psql -d ${DBNAME} -c "\copy skills_dim FROM 'data/sample_skills.csv' CSV HEADER;"
psql -d ${DBNAME} -c "\copy skills_job_dim FROM 'data/sample_skills_job.csv' CSV HEADER;"

echo "Sample data loaded into database ${DBNAME}."
