# Stand.iL.Website
## Here you can see a diagram explaining the project:
![standildiagram drawio](https://github.com/snirkap/Stand.iL.Website/assets/120733215/13b10e6e-57e8-4c43-9295-a67e51f87739)

Welcome to the repository for the stand.iL website. The website is hosted on AWS, utilizing S3 for storage, CloudFront for content delivery, and Route 53 for DNS management. The infrastructure is codified using Terraform, ensuring infrastructure as code practices. Additionally, a CI/CD pipeline is implemented using GitHub Actions to automate the deployment process.

## Architecture Overview:
* AWS S3 Bucket: Hosts static website content, including HTML files and image assets.
* AWS CloudFront: A CDN that serves the website content globally, improving load times and providing a secure HTTPS endpoint.
* AWS Route 53: Manages DNS records, allowing users to access the website via a friendly DNS name rather than a direct IP address or AWS-generated URL.
* Terraform: Used to provision and manage the AWS resources in a repeatable and predictable manner.
* GitHub Actions: Automates the deployment process, including uploading files to S3 and invalidating the CloudFront cache to reflect updates.

## Prerequisites:
Before you can deploy this project, you'll need:

* AWS Account with access to S3, CloudFront, and Route 53
* Terraform installed on your local machine
* Git installed on your local machine
* awscli installed on your local machine

## Setup and Deployment:
### Clone the Repository
First, clone this repository to your local machine to get started with the project.
```
git clone https://github.com/snirkap/Stand.iL.Website.git
cd Stand.iL.Website
```
### Terraform Initialization and Application
Navigate to the Terraform directory within the cloned repository and run the following command to initialize Terraform, allowing it to download necessary providers and modules.
and change this variables:
* s3_bucket_name
* aws_cloudfront_distribution_aliases
* aws_cloudfront_distribution_acm_certificate_arn
* aws_route53_record_zone_id
* aws_route53_record_name
```
cd tf
terraform init
terraform apply
```
### CI/CD Pipeline
The CI/CD pipeline, defined in .github/workflows/main.yml, automates updates. It triggers on changes to HTML files or the images directory, updating the S3 bucket and invalidating CloudFront's cache to ensure the latest version of the site is available.
