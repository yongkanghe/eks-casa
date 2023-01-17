echo '-------Creating an EKS Cluster only (typically about 15 mins)'
starttime=$(date +%s)
. ~/.bashrc
. ./setenv.sh

echo $MY_CLUSTER-$(date +%s)$RANDOM > casa_ee_eks_clustername

eksctl create cluster \
  --name $(cat casa_ee_eks_clustername) \
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

./csi-enable.sh

echo "" | awk '{print $1}'
./pg-deploy.sh

endtime=$(date +%s)
duration=$(( $endtime - $starttime ))
echo "" | awk '{print $1}'
echo "-------Total time to build an EKS cluster with PostgreSQL is $(($duration / 60)) minutes $(($duration % 60)) seconds."
echo "" | awk '{print $1}'
echo "-------Created by Yongkang"
echo "-------Email me if any suggestions or issues he@yongkang.cloud"
echo "" | awk '{print $1}'