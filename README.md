# 🔐 Policy-as-Code CI/CD Governance Platform

## Project Summary

This is an elite-level, enterprise-grade Policy-as-Code Governance Platform designed to automatically enforce security and compliance across all stages of your CI/CD pipeline. Leveraging **Conftest**, **OPA (Open Policy Agent)**, **GitHub Actions**, and **ArgoCD**, this platform brings centralized governance to code, infrastructure, secrets, and Kubernetes deployments.

> ✅ Dual implementation strategy:
>
> * **Azure (Enterprise)** — Full implementation using GitHub repos and AKS.
> * **\[Deprecated] Local (Oracle VirtualBox)** — Skipped after Phase 2.

---

## 📁 Directory Structure

```bash
policy-as-code-enterprise-azure/
├── .github/
│   └── workflows/
│       └── conftest-lint.yml
├── conftest/
│   ├── policies/
│   │   ├── disallow-latest.rego
│   │   ├── no-secrets.rego
│   │   └── allow-regions.rego
├── manifests/
│   ├── good-deployment.yaml
│   └── bad-deployment.yaml
├── gatekeeper/
│   ├── templates/
│   │   └── k8s-no-latest-tag.yaml
│   └── constraints/
│       └── no-latest-tag.yaml
├── logs/
│   └── sample-violation.md
└── README.md
```

---

# 📌 Project Phases

## 📦 Architecture & Requirements

### 🔍 Use Cases:

* Prevent hardcoded secrets
* Enforce image tag conventions (no `latest`)
* Approve only specific container registries
* Validate Terraform/K8s manifests
* Secure GitHub workflows and steps
* Restrict to specific Azure regions/modules

### 🔁 Logical Flow

1. Code pushed to GitHub → GitHub Actions triggers Conftest + OPA checks
2. Validated manifests → ArgoCD → AKS
3. Runtime Gatekeeper policies catch any unverified inputs

### 🔧 Components:

| Component      | Role                   |
| -------------- | ---------------------- |
| OPA            | Policy engine (Rego)   |
| Conftest       | CI linting tool        |
| GitHub Actions | Automation runner      |
| ArgoCD         | GitOps deployment tool |
| Gatekeeper     | K8s admission control  |

---

## 🔐 Policy Framework Setup

* Installed OPA CLI + Conftest locally
* Setup initial policy files in `conftest/policies/`
* Skipped VirtualBox beyond this phase

---

## ✍️ Writing High-Value Rego Policies

### 🧠 Sample Rego Files:

* `disallow-latest.rego`: Block image tags ending in `:latest`
* `no-secrets.rego`: Block secrets and passwords in manifests
* `allow-regions.rego`: Allow only whitelisted Azure regions

### 🔍 Example:

```rego
package main

violation["Disallowed image tag"] {
  input.image == "nginx:latest"
}
```

---

## 🤖 GitHub Actions + Conftest CI Integration

### ✅ `.github/workflows/conftest-lint.yml`

```yaml
name: Conftest Policy Lint

on:
  push:
    paths:
      - 'manifests/**'

jobs:
  conftest-lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Install Conftest
        run: |
          wget https://github.com/open-policy-agent/conftest/releases/download/v0.45.0/conftest_0.45.0_Linux_x86_64.tar.gz
          tar xzf conftest_0.45.0_Linux_x86_64.tar.gz
          sudo mv conftest /usr/local/bin/
      - name: Run Conftest
        run: conftest test manifests/
```

> ℹ️ CI fails = policy violation = ✅ enforcement works

---

## 🚀 GitOps with ArgoCD (Azure AKS)

* Deployed ArgoCD to AKS
* Synced to GitHub repo to auto-deploy validated manifests
* Verified ArgoCD only pulls compliant resources

---

## 🧰 Runtime Enforcement via OPA Gatekeeper

### 🛡️ Enforced Rules:

* No `:latest` image tags

### 🔨 Files:

* `gatekeeper/templates/k8s-no-latest-tag.yaml`
* `gatekeeper/constraints/no-latest-tag.yaml`

```rego
package k8sdisallowlatesttag

violation["Don't use :latest"] {
  endswith(input.review.object.spec.template.spec.containers[_].image, ":latest")
}
```

---

## 📊 Auditing & Dashboard

* Enabled Gatekeeper audit controller
* Exported violation logs → `logs/sample-violation.md`
* Integrated metrics via Prometheus (optional)
* Suggested visual tools:

  * Kubernetes Lens
  * Grafana Dashboards

---

## 🧪 Real-World Violations + Fixes

* Applied `bad-deployment.yaml` → Rejected by CI & K8s
* Fixed version → `good-deployment.yaml` → Deployed successfully

> Demonstrates end-to-end protection.

---

## 🌍 Bonus — Multi-Repo & Multi-Env Governance

### Examples:

* Different policy sets per environment (dev/stage/prod)
* Shared policy repo across microservices
* ArgoCD ApplicationSets + overlays

> Enables enterprise-scale governance.

---

## 📌 Tech Stack

* ✅ OPA (Open Policy Agent)
* ✅ Conftest
* ✅ GitHub Actions
* ✅ ArgoCD
* ✅ Azure Kubernetes Service (AKS)
* ✅ Optional: Prometheus + Grafana

---

## 👨‍💻 Author

**Aman Choudhary**
Cloud & DevOps Engineer
[LinkedIn](#) | [Portfolio](#) | [GitHub](#)

---

## ✅ Status

> 🟢 Fully functional on Azure Cloud, documented for reproducibility. Ready for public and enterprise-grade demonstration.

---


## 📣 Feedback

Feel free to raise issues or suggestions in the [GitHub Issues](#) section.
