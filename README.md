## WORK IN PROGRESS

#### Follow [@YongkangHe](https://twitter.com/yongkanghe) on Twitter, Subscribe [K8s Data Management](https://www.youtube.com/channel/UCm-sw1b23K-scoVSCDo30YQ?sub_confirmation=1) Youtube Channel

I just want to build an EKS Cluster to play with the various Security and Data Management capabilities e.g. Security Scans, Backup/Restore, Disaster Recovery and Application Mobility. 

It is challenging to create an EKS cluster from AWS Cloud if you are not familiar to it. After the EKS Cluster is up running, we still need to install a sample DB, create policies etc.. The whole process is not that simple.

![image](https://blog.kasten.io/hs-fs/hubfs/Blog%20Cross-Cluster%20Application%20Migration%20and%20Disaster%20Recovery%20for%20AWS%20EKS%20Using%20Kasten%20K10%20by%20Michael%20Cade%205.png?width=406&name=Blog%20Cross-Cluster%20Application%20Migration%20and%20Disaster%20Recovery%20for%20AWS%20EKS%20Using%20Kasten%20K10%20by%20Michael%20Cade%2051.png)

This script based automation allows you to build a ready-to-use Kasten K10 demo environment running on EKS in about 20 minutes with deploy.sh. For simplicity and cost optimization, the EKS cluster will have only one worker node and create a separate vpc and subnets. This is bash shell based scripts which might only work on Cloud Shell. Linux and MacOS terminal may work as well, but I haven't tested it yet. 

If you already have an EKS cluster running, you only need 3 minutes to protect containers on EKS cluster by k10-deploy.sh. 

# Here're the prerequisities. 
1. Go to open AWS Cloud Shell
2. Clone the github repo, run below command
````
git clone https://github.com/yongkanghe/eks-casa.git
````
3. Install the required tools (eksctl, kubectl, helm) and input AWS Access Credentials
````
cd eks-casa;./awsprep.sh;. ./setenv.sh
````
4. Optionally, you can customize the clustername, instance-type, zone, region
````
vi setenv.sh
````

# EKS Cluster Automation 

1. To deploy an EKS cluster
````
./eks-deploy.sh
````

2. To destroy the EKS cluster after testing
````
./eks-destroy.sh
````

# Build an EKS cluster via Web UI
[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/d0vhf_ggnko/0.jpg)](https://www.youtube.com/watch?v=d0vhf_ggnko)
#### Subscribe [K8s Data Management](https://www.youtube.com/channel/UCm-sw1b23K-scoVSCDo30YQ?sub_confirmation=1) Youtube Channel

# Protect containers on EKS cluster
[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/27sIjUbxgFk/0.jpg)](https://www.youtube.com/watch?v=27sIjUbxgFk)
#### Subscribe [K8s Data Management](https://www.youtube.com/channel/UCm-sw1b23K-scoVSCDo30YQ?sub_confirmation=1) Youtube Channel

# Build an EKS + K10 via Automation
[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/v_Aks8GFBVA/0.jpg)](https://www.youtube.com/watch?v=v_Aks8GFBVA)
#### Subscribe [K8s Data Management](https://www.youtube.com/channel/UCm-sw1b23K-scoVSCDo30YQ?sub_confirmation=1) Youtube Channel

# Build an EKS + K10 on AWS Event Engine
[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/VRJVdUqMiRg/0.jpg)](https://www.youtube.com/watch?v=VRJVdUqMiRg)
#### Subscribe [K8s Data Management](https://www.youtube.com/channel/UCm-sw1b23K-scoVSCDo30YQ?sub_confirmation=1) Youtube Channel

# Kasten on AWS Workshop
[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/AB97gJMlzRE/0.jpg)](https://www.youtube.com/watch?v=AB97gJMlzRE)
#### Subscribe [K8s Data Management](https://www.youtube.com/channel/UCm-sw1b23K-scoVSCDo30YQ?sub_confirmation=1) Youtube Channel

# K10 on EKS self-paced Lab Guide
## Option 1, AWS provides access via Event Engine
http://aws-lg-ee.yongkang.cloud

## Option 2, Use your own AWS account
http://aws-lg.yongkang.cloud

# Build, Protect and Migrate Containers
[![IMAGE ALT TEXT HERE](https://pbs.twimg.com/media/FK5rsaeXwAIEmtI?format=jpg&name=small)](https://www.youtube.com/channel/UCm-sw1b23K-scoVSCDo30YQ)
#### Subscribe [K8s Data Management](https://www.youtube.com/channel/UCm-sw1b23K-scoVSCDo30YQ?sub_confirmation=1) Youtube Channel

# EKS Backup and Restore
https://blog.kasten.io/cross-cluster-application-migration-and-dr-for-aws-eks-using-kasten-k10

# CloudCasa - No. 1 Kubernetes Backup as a Service
https://cloudcasa.io 

# Contributors

#### Follow [Yongkang He](http://yongkang.cloud) on LinkedIn, Join [Kubernetes Data Management](https://www.linkedin.com/groups/13983251) LinkedIn Group

