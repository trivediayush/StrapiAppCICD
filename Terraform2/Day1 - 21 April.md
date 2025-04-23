🚀 Task-5 Deploy Strapi on AWS ECS Fargate Using Terraform
===================================================

🛠 Prerequisites
----------------

*   AWS CLI configured
*   Docker installed and running
*   Terraform v1.3+ installed
*   AWS account with IAM permissions to create ECR, ECS, ALB, VPC, etc.

📦 Step 1: Containerize the Strapi Application
----------------------------------------------

    
      # Dockerfile
      FROM node:18
    
      WORKDIR /app
    
      COPY package*.json ./
      RUN npm install
    
      COPY . .
    
      RUN npm run build
    
      EXPOSE 1337
    
      CMD ["npm", "start"]
      

🐳 Step 2: Build and Push Docker Image to ECR
---------------------------------------------

    
      aws ecr create-repository --repository-name strapi-app
    
      # Authenticate Docker
      aws ecr get-login-password | docker login --username AWS --password-stdin <account_id>.dkr.ecr.<region>.amazonaws.com
    
      docker build -t strapi-app .
      docker tag strapi-app:latest <account_id>.dkr.ecr.<region>.amazonaws.com/strapi-app
      docker push <account_id>.dkr.ecr.<region>.amazonaws.com/strapi-app
      

🌐 Step 3: Terraform Infrastructure
-----------------------------------

The Terraform code consists of modules to:

*   Create a VPC, public subnets, route tables, and internet gateway
*   Provision an ECS cluster
*   Define a Task Definition using the pushed Docker image
*   Create a Fargate Service
*   Set up Security Groups and Application Load Balancer
*   Output the ALB DNS name for public access

### 📁 Terraform Directory Structure

    
      terraform/
      ├── main.tf
      ├── variables.tf
      ├── outputs.tf
      ├── ecs.tf
      ├── alb.tf
      └── vpc.tf
      

### ✅ Initialize and Apply

    
      cd terraform
      terraform init
      terraform apply -auto-approve
      

🌍 Accessing the Application
----------------------------

After deployment, Terraform will output the public DNS name of the ALB. Use this URL in your browser to access the Strapi dashboard.

    
      alb_dns = "http://<alb-public-dns>"
      

🧹 Cleanup
----------

To destroy all AWS resources created:

    
      terraform destroy -auto-approve
      
📝 Author: Ayush Trivedi
