#aws-ci-cd-pipeline
Automated CI/CD Pipeline to AWS (Local Emulation)
#Project Overview
This project demonstrates an automated Continuous Integration and Continuous Deployment (CI/CD) workflow. It deploys a Python web application directly to an AWS EC2 instance.

To ensure cost-effective development, rapid testing, and zero cloud-compute charges, this project utilizes Floci to natively emulate the AWS cloud infrastructure entirely on the local machine.

##Tech Stack
*Version Control: Git & Bitbucket
*Cloud Infrastructure: AWS EC2 (Emulated locally)
*Automation: Bash Scripting (Simulating Bitbucket Pipelines)
*Containerization: Docker & Docker Compose
*Application: Python 3.x (Flask)

##Prerequisites
To run this pipeline locally, ensure the following are installed on your machine:
*Docker Desktop (Must be running in the background)
*AWS CLI v2
*Python 3.x & pip

##Repository Structure
aws-ci-cd-pipeline/
├── docker-compose.yml     # Infrastructure-as-Code to spin up the Floci AWS Emulator
├── requirements.txt       # Python application dependencies
├── app.py                 # The core Python web application
├── deploy_pipeline.sh     # The CI/CD automation script
└── .gitignore             # Prevents committing emulator data to version control

##Step-by-Step Execution Guide
Step 1: Start the AWS Emulator
First, we need to spin up our local AWS cloud environment using Floci.
Open your terminal in the project directory and run:
-> docker compose up -d

Step 2: Make the Pipeline Script Executable
Grant execution permissions to the automated deployment script:
-> chmod +x deploy_pipeline.sh

Step 3: Trigger the CI/CD Pipeline
Run the automation script. This script will automatically configure dummy AWS credentials, provision an emulated EC2 server, transfer the codebase, install dependencies, and start the web server.
-> ./deploy_pipeline.sh

##Expected Output
Once the pipeline finishes executing successfully, your terminal will log the deployment steps.

To verify that the application is running live inside the emulated AWS EC2 instance, open your web browser and navigate to:
http://localhost:80

You should receive the following JSON payload:

JSON
{
  "status": "success",
  "message": "Hello World! Deployed successfully to Floci AWS EC2!",
  "environment": "Production-Emulated"
}
