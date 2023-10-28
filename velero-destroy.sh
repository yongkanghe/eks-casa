echo '-------Remove Velero for EKS and Clean up (typically in 3 mins)'
starttime=$(date +%s)
. ./setenv.sh

velero uninstall --force
aws s3 rb s3://$(cat bucket4velero1) --force
aws iam delete-user-policy \
    --user-name vuser4yong1 \
    --policy-name vpolicy4yong1
aws iam delete-access-key --user-name vuser4yong1 --access-key-id \
    $(grep AccessKeyId vuser4yong1.txt | awk '{print $2}' | sed -e 's/\"//g' | sed -e 's/\,//g')
aws iam delete-user --user-name vuser4yong1

endtime=$(date +%s)
duration=$(( $endtime - $starttime ))
echo "" | awk '{print $1}'
echo "-------Total time to clean up the env is $(($duration / 60)) minutes $(($duration % 60)) seconds."
echo "" | awk '{print $1}'
echo "-------Created by Yongkang"
echo "-------Email me if any suggestions or issues he@yongkang.cloud"
echo "" | awk '{print $1}'