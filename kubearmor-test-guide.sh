# KubeArmor Test Case -1, deny execution of apt / apt-get
# Package management tools can be used in the runtime env to download new binaries that will increase the attack surface of the pods. Attackers use package management tools to download accessory tooling (such as masscan) to further their cause. It is better to block usage of package management tools in production environments. Lets apply the policy to block such execution.

# Get the pod name
export POD=$(kubectl get pod -l app=nginx4yong1 -o name -n yong-nginx)

# Try to run apt / apt-get
kubectl exec -it $POD -n yong-nginx -- bash -c "apt update && apt install masscan"

# Apply the policy to deny execution of apt / apt-get
kubectl apply -f ./block-pkg-mgmt-tools-exec.yaml

# Try to run apt / apt-get again
kubectl exec -it $POD -n yong-nginx -- bash -c "apt update && apt install masscan"

# Verify policy violations
karmor logs -n yong-nginx

# KubeArmor Test Case -2, deny access to service account token
# K8s mounts the service account token by default in each pod even if there is no app using it. Attackers use these service account tokens to do lateral movements.

# Try to access the SA
kubectl exec -it $POD -n yong-nginx -- bash
curl https://$KUBERNETES_PORT_443_TCP_ADDR/api --insecure --header "Authorization: Bearer $(cat /run/secrets/kubernetes.io/serviceaccount/token)"

# Apply the policy to deny access to service account token
kubectl apply -f ./block-service-access-token-access.yaml

# Try to access the SA again
kubectl exec -it $POD -n yong-nginx -- bash
curl https://$KUBERNETES_PORT_443_TCP_ADDR/api --insecure --header "Authorization: Bearer $(cat /run/secrets/kubernetes.io/serviceaccount/token)"
# forbidden: User \"system:anonymous\" cannot get path \"/api\”

# KubeArmor Test Case -3, audit access to folders/paths
# Access to certain folders/paths might have to be audited for compliance/reporting reasons. Lets audit access to /etc/nginx/ folder within the deployment.

# By default, File visibility disabled. Let's turn it on first
kubectl annotate ns yong-nginx kubearmor-visibility="process, file, network" --overwrite

# Apply the policy to audit access to folders/paths
kubectl apply -f ./audit-etc-nginx-access.yaml

# Try to access /etc/nginx
kubectl exec -it $POD -n yong-nginx -- bash -c "head /etc/nginx/nginx.conf"

# Verify policy violations
karmor logs -n yong-nginx

# KubeArmor Test Case -4, allow only nginx to exec, deny the rest
# Least permissive policies require one to allow certain actions/operations and deny rest. With KubeArmor it is possible to specify as part of the policy as to what actions should be allowed and deny/audit the rest.
# Security Posture defines what happens to the operations that are not in the allowed list. Should it be audited (allow but alert), or denied (block and alert)?
# By default the security posture is set to audit. Lets change the security posture to default deny.

# Apply the policy to allow only nginx to exec, deny the rest
kubectl apply -f ./only-allow-nginx-exec.yaml

# By default the security posture is set to audit. Lets change the security posture to default deny.
kubectl annotate ns yong-nginx kubearmor-file-posture=block --overwrite

# Try to run a few commands
kubectl exec -it $POD -n yong-nginx -- bash -c "passwd"
kubectl exec -it $POD -n yong-nginx -- bash -c "ls"
kubectl exec -it $POD -n yong-nginx -- bash -c "chroot"

# Verify policy violations
karmor logs -n yong-nginx

# Verify you can still access nginx web page
kubectl port-forward $POD -n yong-nginx --address 0.0.0.0 8080:80





