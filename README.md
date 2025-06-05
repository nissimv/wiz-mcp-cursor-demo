# Wiz MCP Cursor Demo

This project demonstrates a simple Python application and various infrastructure-as-code (IaC) examples for cloud deployment and security testing.

## Project Structure

- **app/**: Python application
  - `main.py`: Fetches data from an example API
  - `requirements.txt`: Python dependencies
  - `config.yaml`: Example config (contains secrets; do not use in production)
- **iac/**: Infrastructure as Code
  - `terraform/`, `terraform-tel-aviv/`: Terraform scripts for AWS resources
  - `cloudformation/`: AWS CloudFormation template
  - `ansible/`: Ansible playbook
- **tel-aviv-deploy/**: Kubernetes and AWS deployment YAMLs

## Quick Start

### 1. Python App
```bash
cd app
pip install -r requirements.txt
python main.py
```

### 2. Infrastructure as Code
- **Terraform**: See `iac/terraform/` or `iac/terraform-tel-aviv/`
- **CloudFormation**: See `iac/cloudformation/template.yaml`
- **Ansible**: See `iac/ansible/playbook.yml`
- **Kubernetes**: See `tel-aviv-deploy/k8_deployment.yml`

## Security Note
- `app/config.yaml` contains example secrets. **Do not commit real secrets to version control.**

## License
MIT
