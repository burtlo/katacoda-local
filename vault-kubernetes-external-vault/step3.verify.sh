kubectl get pods --field-selector=status.phase=Running -l app=devwebapp -o jsonpath="{.items[0].metadata.name}"

if [[ $? -eq 0 ]]
then
  echo "done"
else
  echo "Kubernetes: devwebapp pod is not ready"
fi


