starttime=$(date +%s)
. ./setenv.sh

echo '-------Deleting the EKS Cluster (typically in ~ 10 mins)'

clusterid=$(kubectl get namespace default -ojsonpath="{.metadata.uid}{'\n'}")
eksctl delete cluster --name $(cat casa_ee_eks_clustername) --region $AWS_REGION

echo '-------Deleting EBS Volumes'
aws ec2 describe-volumes --region $AWS_REGION --query "Volumes[*].{ID:VolumeId}" --filters Name=tag:eks:cluster-name,Values=$(cat casa_ee_eks_clustername) | grep ID | awk '{print $2}' > ebs.list
aws ec2 describe-volumes --region $AWS_REGION --query "Volumes[*].{ID:VolumeId}" --filters Name=tag:kubernetes.io/cluster/$(cat casa_ee_eks_clustername),Values=owned | grep ID | awk '{print $2}' >> ebs.list
for i in $(sed 's/\"//g' ebs.list);do echo $i;aws ec2 delete-volume --volume-id $i --region $AWS_REGION;done

echo '-------Deleting kubeconfig for this cluster'
kubectl config delete-context $(kubectl config get-contexts | grep $(cat casa_ee_eks_clustername) | awk '{print $2}')
echo "" | awk '{print $1}'

endtime=$(date +%s)
duration=$(( $endtime - $starttime ))
echo "-------Total time to clean up is $(($duration / 60)) minutes $(($duration % 60)) seconds."
echo "" | awk '{print $1}'
echo "-------Created by Yongkang"
echo "-------Email me if any suggestions or issues he@yongkang.cloud"
echo "" | awk '{print $1}'
