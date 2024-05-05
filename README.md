# terraform-assigment

# Task 1: Infrastructure as Code (IaC) with Terraform

### Objective ###

The content in terraform folder creates AWS Virtual Private Cloud (VPC) with two public and two private subnets,2 NAT gateways, routtabe and routtable association, And also creates an EC2 instance in one private subnet, and an Application Load Balancer (ALB) in two public subnets.

### Steps ###

1) _Set Up Terraform_ Ensure Terraform is installed on your local machine. You can download it from the official [website](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli/ "website").

2) Create aws credentials profile in ```~/.aws/credentials``` and update the profile name in ```terraform.tfvars``` inside the terraform folder.

3) Run below commands to provision infrastructure in aws cloud.

_To initalize the terraform resources_\
```terraform init```

_Below command does the plan of all the resources which are goint to be provisioned_\
```terraform plan -var-file terraform.tfvars```

_Below command creates all the resources in aws cloud_\
```terraform apply -var-file terraform.tfvars```

_Below command destroys all the resources in aws cloud_\
```terraform destroy -var-file terraform.tfvars```


# Task 2 : Kubernetes Deployment

### Deploy a sample application on a Kubernetes cluster. ###

The manifest file inside kubernetes folder contains the an deployment exposed to an ```PORT 80``` to the ```loadbalancer``` and configured ```PDB (pod disruption budget)``` and ```HPA (Horizontal Pod Autoscaler)``` for High Availabilty with min 2 and max 10 replicas. Also configured Zone awarnes to schedule pods equaly in two different zones.

```
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      affinity:
        podAntiAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchExpressions:
              - key: app
                operator: In
                values:
                - nginx
            topologyKey: "failure-domain.beta.kubernetes.io/zone"
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
        resources:
          requests:
            memory: "64Mi"
            cpu: "250m"
          limits:
            memory: "128Mi"  
            cpu: "500m" 
---
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  ports:
  - port: 80
    targetPort: 80
  selector:
    app: nginx
  type: LoadBalancer

---
apiVersion: policy/v1beta1
kind: PodDisruptionBudget
metadata:
  name: nginx-pdb
spec:
  minAvailable: 1
  selector:
    matchLabels:
      app: nginx

---

apiVersion: autoscaling/v2beta2
kind: HorizontalPodAutoscaler
metadata:
  name: nginx-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: nginx-deployment
  minReplicas: 2
  maxReplicas: 5
  metrics:
  - type: Resource
    resource:
      name: cpu
      targetAverageUtilization: 80
  - type: Resource
    resource:
      name: memory
      targetAverageUtilization: 80

```

### Run Below command to deploy the application ###

``` kubectl apply -f deployment.yml```


# Task 3 : CI/CD with GitHub Actions

I have created the sample node project ```(code is inside project folder)``` and implimented CI/CD using Github Actions. I have created two pipelines one for containerized node app using ```Dockerfile``` and other simple build and deploy in server. The pipelines are automatically gets triggered whenever any thing is pushed to main branch. You can find the workflows in ```.github/workflows/``` path, Additionally i have configured upload artifact stage for one of the pipeline to store the artifact in ```S3``` similarly we can deploy the same build to the staging server.


# Task 4 : DevOps & Automation

### Automate the backup of an AWS S3 bucket ###
There are multiple ways to Automate the Backup of S3 bucket like by using lambda and eventbridge and by using cronjob. I have created simple shell script to take the backup of S3. this can be scheduled and automated by using cronjob.

### Here is the script ###

```
#!/bin/bash

# Define variables
SOURCE_BUCKET="source-bucket-name"
DEST_BUCKET="destination-bucket-name"
TIMESTAMP=$(date +"%Y%m%d%H%M%S")

# Create a backup of the S3 bucket
aws s3 sync s3://$SOURCE_BUCKET s3://$DEST_BUCKET/backup-$TIMESTAMP

# Optional: You can add additional commands to manage backups, like cleanup of old backups

echo "Backup of $SOURCE_BUCKET completed and saved to $DEST_BUCKET/backup-$TIMESTAMP"

```

The Above script takes the backup of s3 to other s3 bucket with proper backup name. We have to provide the source and destination bucket names as input to the file,  We can configure retention policy for destination bucket to maintain particular duration of backups which saves cost. 



### Automatically scale EC2 instances based on CPU utilization ###

There are multiple ways to implimet autimatic sacling of EC2 instances for example we have AWS Autoscaling group which scales the EC2 machines, and We can use AWS Cloudwatch to trigger lambda to spinup the new ec2 machine with preconfigured AMI based on CPU metrics.

### Implimentation ###

Here i have created the terraform resources to Automate the ec2 instance scaling by using autoscaling group. The script is inside the automation folder.\

### Run below commands to provision infrastructure in aws cloud.

_To initalize the terraform resources_\
```terraform init```

_Below command does the plan of all the resources which are goint to be provisioned_\
```terraform plan```

_Below command creates all the resources in aws cloud_\
```terraform apply ```

_Below command destroys all the resources in aws cloud_\
```terraform destroy ```