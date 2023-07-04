# Add Wiz Helm Charts
helm repo add wiz-sec https://charts.wiz.io/
helm repo update

# Create a Complete Kubernetes Integration type Service Account from Wiz Portal
# Set Wiz Client ID env
export WIZ_CLIENT_ID=$(cat wiz_client_id)
# Set Wiz Client Secret env
export WIZ_CLIENT_SECRET=$(cat wiz_client_secret)

# Get Username and Password from Wiz Portal User Settings->Tenant->Wiz Rgistry Credentials
# Set imagePullSecret Username CSAPROD
export WIZ_IMG_USER=$(cat wiz_img_user)
# Set imagePullSecret Password Demo
export WIZ_IMG_PASS=$(cat wiz_img_pass)

# Install the Runtime Sensor on a cluster
helm upgrade --install yong-wiz-sensor wiz-sec/wiz-sensor \
  --create-namespace \
  --namespace=wiz \
  --set imagePullSecret.username=$WIZ_IMG_USER \
  --set imagePullSecret.password=$WIZ_IMG_PASS \
  --set wizApiToken.clientId=$WIZ_CLIENT_ID \
  --set wizApiToken.clientToken=$WIZ_CLIENT_SECRET