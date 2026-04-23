HCP (Hashicorp Cloud Platform)

This has like Login credentials (no aws login and stuff)
Manage the secrets 
Automate
Store Modules
Have seperate Enviournemtns 

Organization
   └── Project
         └── Workspace


                my-company (Organization)

    Project A        Project B        Project C

    ↓                ↓                ↓

workspace A-dev   workspace B-dev   workspace C-dev
workspace A-prod  workspace B-prod  workspace C-prod


Workflow is a running flow of a workspace

these workflows can be done 
1. via ui
2. via cli 
3. via api calls    