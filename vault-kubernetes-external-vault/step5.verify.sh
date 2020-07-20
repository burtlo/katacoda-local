kubectl get pods --field-selector=status.phase=Running -l app= -o jsonpath="{.items[0].metadata.name}"

# kubectl get pod -l  app.kubernetes.io/name=vault-agent-injector -o json | jq ".items[0].status.containerStatuses[0].ready"
agentStatus=$(kubectl get pod -l  app.kubernetes.io/name=vault-agent-injector -o jsonpath="{.items[0].status.containerStatuses[0].ready}")

if [[ $agentStatus -eq "true" ]]
then
  echo "done"
else
  echo "Kubernetes: Vault Agent Injector is not ready"
fi


