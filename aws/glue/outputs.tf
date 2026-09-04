output "database_names" {
  value = keys(aws_glue_catalog_database.this)
}


output "job_names" {
  value = keys(aws_glue_job.this)
}


output "crawler_names" {
  value = keys(aws_glue_crawler.this)
}
