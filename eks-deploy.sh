echo '-------Creating an EKS Cluster only (typically about 15 mins)'
starttime=$(date +%s)
. ~/.bashrc
. ./setenv.sh

echo $MY_CLUSTER-$(date +%s)$RANDOM > casa_eks_clustername

# ~/eks-casa/eksctl version | grep 162

# if [ `echo $?` -eq 1 ]; then
#   echo "Install the latest eksctl"
#   curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/v0.162.0/eksctl_Linux_amd64.tar.gz" | tar xz -C ~/eks-casa
# fi

eksctl create cluster \
  --name $(cat casa_eks_clustername) \
  --version $MY_K8S_VERSION \
  --nodegroup-name workers4yong1 \
  --nodes 1 \
  --nodes-min 1 \
  --nodes-max 3 \
  --node-type $MY_INSTANCE_TYPE \
  --ssh-public-key ~/.ssh/id_rsa.pub \
  --region $AWS_REGION \
  --ssh-access \
  --managed

# aws eks update-kubeconfig --name $(cat casa_eks_clustername) --region $MY_REGION

./csi-enable.sh

echo "" | awk '{print $1}'
./pg-deploy.sh

echo "" | awk '{print $1}'

endtime=$(date +%s)
duration=$(( $endtime - $starttime ))
echo "-------Total time to build an EKS cluster is $(($duration / 60)) minutes $(($duration % 60)) seconds."
echo "" | awk '{print $1}'
echo "-------Created by Yongkang"
echo "-------Email me if any suggestions or issues he@yongkang.cloud"
echo "" | awk '{print $1}'