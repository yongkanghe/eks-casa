# Add Wiz Helm Charts
helm repo add wiz-sec https://charts.wiz.io/
helm repo update

# Set Wiz Client ID env
export WIZ_CLIENT_ID=$(cat wiz_client_id)
# Set Wiz Client Secret env
export WIZ_CLIENT_SECRET=$(cat wiz_client_secret)

# Create a Wiz for EKS Connector yaml file
cat <<EOF > values_wiz-eks-connector.yaml
wizApiToken:
  clientId: "$WIZ_CLIENT_ID"
  clientToken: "$WIZ_CLIENT_SECRET"
  clientEndpoint: ""
broker:
  enabled: false
autoCreateConnector:
 connectorName: "yong-eks-connector"
 apiServerEndpoint: "$(kubectl config view --minify --raw -o jsonpath="{.clusters[0].cluster.server}")"
 clusterFlavor: "EKS"
EOF

# Install Wiz Connector Helm Chart
helm install yong-eks-connector wiz-sec/wiz-kubernetes-connector --values values_wiz-eks-connector.yaml -n wiz --create-namespace
