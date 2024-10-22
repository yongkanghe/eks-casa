echo '-------Deploy Velero for EKS Backup (typically in 1 min)'
starttime=$(date +%s)
. ./setenv.sh

echo "-------Download and Install verlero CLI if needed"
if [ ! -f ~/eks-casa/velero ]; then
  wget https://github.com/vmware-tanzu/velero/releases/download/v1.14.1/velero-v1.14.1-linux-amd64.tar.gz
  tar -zxvf velero-v1.14.1-linux-amd64.tar.gz
  sudo mv velero-v1.14.1-linux-amd64/velero ~/eks-casa
  sudo rm velero-v1.14.1-linux-amd64.tar.gz
  sudo rm -rf velero-v1.14.1-linux-amd64
fi

echo "-------Create a S3 storage bucket if not exist"
cat bucket4velero1
if [ `echo $?` -eq 1 ];then
  echo $MY_BUCKET-$(date +%d%H%M%s) > bucket4velero1
  aws s3api create-bucket \
    --bucket $(cat bucket4velero1) \
    --region $AWS_REGION \
    --create-bucket-configuration LocationConstraint=$AWS_REGION
fi

echo "-------Create an IAM user and set permissions for velero"
aws iam create-user --user-name vuser4yong1

cat > velero-policy.json <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeVolumes",
                "ec2:DescribeSnapshots",
                "ec2:CreateTags",
                "ec2:CreateVolume",
                "ec2:CreateSnapshot",
                "ec2:DeleteSnapshot"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:DeleteObject",
                "s3:PutObject",
                "s3:AbortMultipartUpload",
                "s3:ListMultipartUploadParts"
            ],
            "Resource": [
                "arn:aws:s3:::$(cat bucket4velero1)/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::$(cat bucket4velero1)"
            ]
        }
    ]
}
EOF

aws iam put-user-policy \
  --user-name vuser4yong1 \
  --policy-name vpolicy4yong1 \
  --policy-document file://velero-policy.json

aws iam create-access-key --user-name vuser4yong1 > vuser4yong1.txt

export V_AWS_ACCESS_KEY_ID=$(grep AccessKeyId vuser4yong1.txt | awk '{print $2}' | sed -e 's/\"//g' | sed -e 's/\,//g')
export V_AWS_SECRET_ACCESS_KEY=$(grep SecretAccessKey vuser4yong1.txt | awk '{print $2}' | sed -e 's/\"//g' | sed -e 's/\,//g')

cat << EOF  > ./credentials-velero
[default]
aws_access_key_id=${V_AWS_ACCESS_KEY_ID}
aws_secret_access_key=${V_AWS_SECRET_ACCESS_KEY}
EOF

echo "-------Install velero using the IAM user and access key"
velero install \
    --provider aws \
    --plugins velero/velero-plugin-for-aws:v1.10.1 \
    --bucket $(cat bucket4velero1) \
    --backup-location-config region=$AWS_REGION \
    --snapshot-location-config region=$AWS_REGION \
    --secret-file ./credentials-velero

echo "-------One time On-Demand Backup of yong-postgresql namespace"
kubectl wait --for=condition=ready --timeout=180s -n velero pod -l component=velero
velero backup create yong-postgresql-backup --include-namespaces yong-postgresql

echo "-------Hourly scheduled backup of yong-postgresql namespace"
kubectl create -f velero-schedule.yaml

endtime=$(date +%s)
duration=$(( $endtime - $starttime ))
echo "" | awk '{print $1}'
echo "-------Total time to enable Velero backup for EKS is $(($duration / 60)) minutes $(($duration % 60)) seconds."
echo "" | awk '{print $1}'
echo "-------Created by Yongkang"
echo "-------Email me if any suggestions or issues he@yongkang.cloud"
echo "" | awk '{print $1}'