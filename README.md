# Automating AMI Creation in AWS with Packer by Hashicorp : Pre-Installing Nginx, Git and Docker:

# High-level Packer workflow diagram:
![image](https://github.com/user-attachments/assets/dd98dd77-38ae-49f9-940b-7a582453893f)


# Creating a custom Amazon Machine Image (AMI) is a common task for teams managing infrastructure in AWS.
  Custom AMIs allow you to pre-install software, configure environments, and ensure consistency across your instances.
  Automating this process using HashiCorp Packer can save time, reduce errors, and ensure repeatability. We’ll walk through the steps to automate the creation of an AMI with several essential tools pre-installed: **Nginx, Git and Docker**.
  
# Let’s break down the process.

✅Declare all the required VM configurations in an HCL (Hashicorp configuration language) or a JSON file. Let’s call it the Packer template. \
✅To build the VM image, execute Packer with the Packer template.. \
✅Packer authenticates the remote cloud provider and launches a server. If you execute Packer from a cloud environment, it leverages the cloud service account for authentication. \
✅Packer takes a remote connection to the server (SSH or Winrm). \
✅Then it configures the server based on the provisioner you specified in the Packer template (Shell script, Ansible, Chef, etc). \
✅Registers the AMI \
✅Deletes the running instance.

# Packer HCL Template Explained:
Here is the high-level packer template structure.

![image](https://github.com/user-attachments/assets/a69c22d2-adee-42c3-a590-4bf191a89514)


# Step 1: Define the Packer Template
We’ll start by creating a Packer template that defines how the AMI should be built. 
This template will specify the base AMI to use, the software to install, and the configuration to apply.

![image](https://github.com/user-attachments/assets/dbe47425-ce35-4294-946d-cd67575c79c0)

# Step 2: Prepare the Provisioning Script
In the Packer template above, the shell provisioner is used to install the required software. This script performs the following tasks:

✅Update the package list: Ensures all packages are up to date.
✅Install Nginx and Git: Two essential tools for web servers and version control.
✅Install Docker: Platform for containerization.
This script will be executed automatically by Packer during the build process.



# Step 3: Build the AMI
With the Packer template defined, we can now build the AMI. Open your terminal and navigate to the directory where your tempalte.pkr.hcl file is located. Run the following command:

# ✅ packer.exe validate --var-file=template.pkr.hcl packer-vars.json
# ✅ packer.exe inspect --var-file=template.pkr.hcl packer-vars.json
# ✅ packer build --var-file=template.pkr.hcl packer-vars.json

![packer-validation](https://github.com/user-attachments/assets/fdd4c1ea-cf91-4bc7-8a98-efa6f1ec8167)

![packer-build](https://github.com/user-attachments/assets/5336eea4-44a6-4fe0-b612-a6fbf6eb13c8)

Started creating a Temporary EC2 instance

![ami-created](https://github.com/user-attachments/assets/ed75f603-8b5f-49b4-9014-5e83cec62769)


AMI creation Done!!!

# Packer will:

✅Launch a temporary EC2 instance using the specified base AMI.
✅Execute the provisioning script to install Nginx, Git and Docker.
✅Create a new AMI with the installed software.
✅Terminate the temporary EC2 instance after the AMI is created.
✅The output will show the progress of each step, and once completed, you will have a new AMI available in your AWS account.

![ami-created_aws_cons](https://github.com/user-attachments/assets/833f7bf6-c506-4d67-898c-3414387cd3e9)

AMI is created in aws and we can see the ami in the console.

# Step 4: Verify the AMI
After Packer completes the build process, verify the new AMI in the AWS Management Console:

✅Navigate to the EC2 Dashboard in the AWS Console.
✅Select “AMIs” from the left-hand menu.
✅Search for your newly created AMI using the name specified in the template (custom-ami-with-tools).
✅To ensure everything works as expected, launch a new EC2 instance from this AMI and check that all the tools are installed:

✅SSH into the instance and verify that Nginx, Git and Docker are installed and functioning correctly.
✅Check Nginx by navigating to the public IP of your instance in a web browser.

![launching-ec2](https://github.com/user-attachments/assets/81fcf088-de5e-4e06-8f92-88f169230643)

Creating AWS instance using the AMI which we have created

![ec2-instance-created](https://github.com/user-attachments/assets/2e6684b8-a235-4185-82ba-e0bbcf994e0a)

# Instance is created

![nginx-server-installed](https://github.com/user-attachments/assets/acbcf979-d550-499c-a83b-c0187cfd4c76)

# NGINX server is visible by hitting the public ip!!!


# Conclusion
Automating AMI creation with HashiCorp Packer is a powerful way to streamline the deployment of consistent and reliable environments in AWS. \
By pre-installing essential tools like Nginx, Git and Docker you ensure that every instance launched from your AMI is ready for use with minimal setup time. \
This approach not only saves time but also reduces the risk of configuration drift and manual errors, enabling you to focus on building and deploying your applications. Start incorporating Packer into your DevOps workflow today and experience the benefits of automated, consistent, and scalable AMI creation.








