End-to-end GitOps With Terraform and ArgoCD For EKS

Argo CD is a GitOps-based continuous delivery (CD) tool for Kubernetes.

2 Repos 
a for terraform  (done to make the eks)
b for the application 

So what this does is if there are any changes made it will revert it back to make sure there is no drift detection and then only the terraform state will be the source of truth 

Drift is basically when there is a change in the desired and the actual state , argoCD monitors this and say if we make any change via console , api or cli , argoCD will revert it back 

Manifest is the code for argoCD


Here we add the various providers like kubernetes, argocd and so on , and then we should also pull the binary and code base for argocd, so to make sure it doesnt always take the latest and we can have them handy.

This allows us to use tools like kustomize and stuff
