echo '-------Destroy a PostgreSQL sample database'

helm uninstall postgres -n yong-postgresql
kubectl delete namespace yong-postgresql
