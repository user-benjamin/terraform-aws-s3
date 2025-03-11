# Terraform AWS S3 Bucket Module

[![Terraform Version](https://img.shields.io/badge/terraform-%3E%3D1.0.0-blue.svg)](https://www.terraform.io/downloads.html)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)

## Description

This Terraform module creates and manages an AWS S3 bucket with configurable features including lifecycle policies, versioning, server-side encryption, and logging. The module follows AWS best practices and provides a flexible, reusable way to create S3 buckets with standardized configurations.

## Key Features

* **Versioning**: Enable or disable bucket versioning
* **Lifecycle Management**: Automatically transition objects to cost-effective storage classes and manage object versions
* **Server-Side Encryption**: AES-256 encryption enabled by default
* **Access Control**: Optional public access configuration
* **Multipart Upload Management**: Automatic cleanup of incomplete multipart uploads
* **Logging**: Optional bucket access logging

## Usage

### Basic Example

```terraform
module "s3_bucket" {
  source      = "github.com/user-benjamin/terraform-aws-s3"
  version     = "1.0.0"
  bucket_name = "my-example-bucket"
  
  tags = {
    Environment = "Production"
    Project     = "Data Storage"
  }
}
```

### Advanced Example with Custom Configuration

```terraform
module "s3_bucket" {
  source      = "github.com/user-benjamin/terraform-aws-s3"
  version     = "1.0.0"
  bucket_name = "my-advanced-bucket"
  
  # Enable versioning
  enable_versioning = true
  
  # Configure lifecycle rules
  enable_lifecycle = true
  intelligent_days = 45  # Move to Intelligent-Tiering after 45 days
  glacier_days     = 120 # Move to Glacier after 120 days
  
  # Configure versioning cleanup
  noncurrent_version_count = 5
  noncurrent_version_days  = 30
  
  # Enable logging
  enable_logging = true
  logging_target_bucket = "my-logging-bucket"
  logging_target_prefix = "my-bucket-logs/"
  
  # Allow public access (use with caution)
  block_public_access = false
  
  tags = {
    Environment = "Development"
    Project     = "Data Analytics"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| aws | >= 4.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bucket_name | Name of the S3 bucket | `string` | n/a | yes |
| tags | Tags to apply to resources | `map(string)` | `{}` | no |
| block_public_access | Whether to block public access to the bucket | `bool` | `true` | yes |
| enable_versioning | Whether to enable versioning on the bucket | `bool` | `true` | no |
| enable_lifecycle | Whether to enable lifecycle on the bucket | `bool` | `true` | no |
| noncurrent_version_count | Number of versions after which old versions will be deleted | `number` | `3` | no |
| noncurrent_version_days | Number of days after which old versions will be deleted | `number` | `15` | no |
| intelligent_days | Number of days after which old versions will be moved to Intelligent-Tiering | `number` | `30` | no |
| glacier_days | Number of days after which old versions will be moved to Glacier | `number` | `90` | no |
| enable_logging | Whether to enable logging on the bucket | `bool` | `false` | no |
| logging_target_bucket | Name of the bucket where access logs will be stored (required if enable_logging is true) | `string` | `null` | no |
| logging_target_prefix | Prefix for the access logs (e.g., 's3-logs/') | `string` | `"s3-logs/"` | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket_id | The name of the bucket |
| bucket_arn | The ARN of the bucket |
| bucket_domain_name | The bucket domain name |
| bucket_regional_domain_name | The bucket region-specific domain name |

## Versioning and Changelog

This module uses [Semantic Versioning](https://semver.org/) and [Semantic Release](https://github.com/semantic-release/semantic-release) for automated versioning and changelog generation. The changelog is automatically generated and maintained in the [CHANGELOG.md](CHANGELOG.md) file.

### Commit Message Format

This repository follows the [Conventional Commits](https://www.conventionalcommits.org/) specification for commit messages:

* `feat(component): Add new feature` - for new features (minor version bump)
* `fix(component): Fix bug` - for bug fixes (patch version bump)
* `docs(component): Update documentation` - for documentation updates
* `chore(component): Update build process` - for maintenance changes
* `BREAKING CHANGE: Description` - for breaking changes (major version bump)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes using conventional commits (`git commit -m 'feat: Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Using Pre-Commit Hooks

This repository uses pre-commit hooks to ensure Terraform code is correctly formatted, validated, and linted before committing.

### Installing Pre-Commit

Ensure pre-commit is installed:

```bash
pip install pre-commit
```

### Setting Up Pre-Commit Hooks
Run the following command in the repository root:

```bash
pre-commit install
```

This ensures the hooks run automatically before each commit.

### Running Pre-Commit Manually
To run the pre-commit checks against all files manually:

```bash
pre-commit run --all-files
