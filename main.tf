#Main
resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  tags = var.tags
}

resource "aws_s3_bucket_policy" "public_policy" {
  count = var.block_public_access ? 0 : 1
  bucket = aws_s3_bucket.this.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.this.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = var.enable_versioning == true ? "Enabled" : "Disabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    id     = "lifecycle-rule"
    status = var.enable_lifecycle == true ? "Enabled" : "Disabled"

    filter {
      prefix = ""
    }

    noncurrent_version_expiration {
      newer_noncurrent_versions = var.noncurrent_version_count
      noncurrent_days = var.noncurrent_version_days
    }

    transition {
      days          = var.intelligent_days
      storage_class = "INTELLIGENT_TIERING"
    }

    transition {
      days          = var.glacier_days
      storage_class = "GLACIER"
    }
  }
  rule {
    id     = "cleanup-multipart-uploads"
    status = "Enabled"

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_logging" "this" {
  count = var.enable_logging && var.logging_target_bucket != null ? 1 : 0
  bucket = aws_s3_bucket.this.id

  target_bucket = var.logging_target_bucket
  target_prefix = var.logging_target_prefix
}
