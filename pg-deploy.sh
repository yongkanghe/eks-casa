echo '-------Deploy a PostgreSQL sample database'

kubectl create namespace yong-postgresql
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install --namespace yong-postgresql postgres bitnami/postgresql --set primary.persistence.size=1Gi
