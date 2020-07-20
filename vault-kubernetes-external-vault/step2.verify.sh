if [[ $(minikube status) ]]
then
  echo "done"
else
  echo "Minikube is not ready."
fi


