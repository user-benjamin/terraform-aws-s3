#Variables
variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "block_public_access" {
  description = "Whether to block public access to the bucket"
  type        = bool
  default     = true
}

variable "noncurrent_version_count" {
  description = "Number of versions after which old versions will be deleted"
  type        = number
  default     = 3
}

variable "noncurrent_version_days" {
  description = "Number of days after which old versions will be deleted"
  type        = number
  default     = 15
}

variable "enable_versioning" {
 description = "Whether to enable versioning on the bucket"
 type        = bool
 default     = true
}

variable "enable_lifecycle" {
 description = "Whether to enable lifecycle on the bucket"
 type        = bool
 default     = true
}

variable "intelligent_days" {
  description = "Number of days after which old versions will be moved to Intelligent-Tiering"
  type        = number
  default     = 30
}

variable "glacier_days" {
  description = "Number of days after which old versions will be moved to Glacier"
  type        = number
  default     = 90
}

variable "enable_logging" {
  description = "Whether to enable logging on the bucket"
  type        = bool
  default     = false
}

variable "logging_target_bucket" {
  description = "Name of the bucket where access logs will be stored (required if enable_logging is true)"
  type        = string
  default     = null
}

variable "logging_target_prefix" {
  description = "Prefix for the access logs (e.g., 's3-logs/')"
  type        = string
  default     = "s3-logs/"
}
