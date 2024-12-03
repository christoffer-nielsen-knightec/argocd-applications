# Kubernetes Configuration Repository

---
This repository contains Kubernetes configurations managed using Kustomize. It includes base configurations, patches, and overlays for different environments.  

## Structure

---
* `common/`: Contains common configurations used across different applications.

  * `app1/`: Contains configurations specific to app1.
  * `base/`: Base configurations for app1.
  * `patches/`: Patches to modify the base configurations.
  * `overlays/`: Overlays for different environments (e.g., dev, prod).

## Kustomize Configuration

---
`kustomization.yaml`

The `kustomization.yaml` file is the main configuration file for Kustomize. It defines the resources, patches, and other configurations to be applied.  

Example:
```yaml
resources:
  - ../../common
  - external-secrets.yaml

commonLabels:
  app: tag-manager

namePrefix: tag-manager-

configMapGenerator:
  - name: configmap
    envs:
      - _base.env

replacements:
  - path: replacements.yaml

patches:
  - path: patches/deployment-env-secrets-patch.yaml
  - path: patches/ingress-basic-auth-patch.yaml
  - path: patches/ingress-paths-patch.yaml
```

## Replacements

---
Replacements are used to substitute placeholders in the manifests with values from a specified file.  

Example:
```yaml
replacements:
  - path: replacements.yaml
```

## Patches

---
Patches are used to modify existing resources. They can be used to add, remove, or modify fields in the base configurations.  

Example:
```yaml
patches:
  - path: patches/deployment-env-secrets-patch.yaml
  - path: patches/ingress-basic-auth-patch.yaml
  - path: patches/ingress-paths-patch.yaml
```

## Components

---
Components are reusable pieces of configuration that can be included in multiple overlays.  

Example:
```yaml
components:
  - ../components/logging
  - ../components/monitoring
```

## Overlays

---
Overlays are used to customize the base configurations for different environments.  

Example:
```yaml
resources:
  - ../base

patchesStrategicMerge:
  - patch.yaml
```

## Generating the ConfigMap

---
The configMapGenerator section in kustomization.yaml generates a ConfigMap from the specified environment file.  

Example:
```yaml
configMapGenerator:
  - name: configmap
    envs:
      - _base.env
```

## Modifications

---
To modify the configuration, you can add or update resources, patches, and other configurations in the kustomization.yaml file. For example, to add a new patch, add the path to the patches section.

Example:
```yaml
patches:
  - path: patches/new-patch.yaml
```
