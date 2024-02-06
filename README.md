# Stand.iL.Website
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
