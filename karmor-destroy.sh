starttime=$(date +%s)
echo '-------Deleting KubeArmor from the EKS Cluster (typically in few mins)'

# Uninstall KubeArmor
helm uninstall kubearmor-operator -n yong-kubearmor
kubectl delete ns yong-nginx
kubectl delete ns yong-kubearmor

echo "" | awk '{print $1}'
endtime=$(date +%s)
duration=$(( $endtime - $starttime ))
echo "-------Total time is $(($duration / 60)) minutes $(($duration % 60)) seconds."
echo "" | awk '{print $1}'
echo "-------Created by Yongkang"
echo "-------Email me if any suggestions or issues he@yongkang.cloud"