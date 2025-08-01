# Bitnami package for Cluster Autoscaler

## What is Cluster Autoscaler?

> Cluster Autoscaler is a component that automatically adjusts the size of a Kubernetes Cluster so that all pods have a place to run and there are no unneeded nodes.

[Overview of Cluster Autoscaler](https://github.com/kubernetes/autoscaler)
Trademarks: This software listing is packaged by Bitnami. The respective trademarks mentioned in the offering are owned by the respective companies, and use of them does not imply any affiliation or endorsement.

## TL;DR

```console
docker run --name cluster-autoscaler -e ALLOW_EMPTY_PASSWORD=yes bitnami/cluster-autoscaler:latest
```

**Warning**: These quick setups are only intended for development environments. You are encouraged to change the insecure default credentials and check out the available configuration options in the [Configuration](#configuration) section for a more secure deployment.

## How to deploy Cluster Autoscaler in Kubernetes?

Cluster Autoscaler runs on the Kubernetes master node on most K8s cloud offerings.

> NOTE: It is possible to run customized Cluster Autoscaler inside of the cluster but then extra care needs to be taken to ensure that Cluster Autoscaler is up and running. User can put it into kube-system namespace (Cluster Autoscaler doesn't scale down node with non-manifest based kube-system pods running on them) and mark with scheduler.alpha.kubernetes.io/critical-pod annotation (so that the rescheduler, if enabled, will kill other pods to make space for it to run).

Currently, it is possible to run Cluster Autoscaler on:

* **AliCloud**: Consult [Cluster Autoscaler on AliCloud docs](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/cloudprovider/alicloud/README.md).
* **AWS**: Consult [Cluster Autoscaler on AWS docs](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/cloudprovider/aws/README.md).
* **Azure**: Consult [Cluster Autoscaler on Azure docs](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/cloudprovider/azure/README.md).
* **GCE**: Consult [Cluster Autoscaler on GCE docs](https://kubernetes.io/docs/concepts/cluster-administration/cluster-management#upgrading-google-compute-engine-clusters).
* **GKE**: Consult [Cluster Autoscaler on GKE docs](https://cloud.google.com/container-engine/docs/cluster-autoscaler).

Please note that Cluster Autoscaler a series of permissions/privileges to adjusts the size of the K8s cluster. For instance, to run it on AWS, you need to:

* Provide the K8s worker node which runs the cluster autoscaler with a minimum IAM policy (check [permissions docs](https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler/cloudprovider/aws#user-content-permissions) for more information).
* Create a service account for Cluster Autoscaler's deployment and bind to it some roles and cluster roles that provide the corresponding RBAC privileges.

> NOTE: Find resources to deploy Cluster Autoscaler on AWS in the [aws-examples](https://github.com/bitnami/containers/tree/main/bitnami/cluster-autoscaler/aws-examples) directory.

## ⚠️ Important Notice: Upcoming changes to the Bitnami Catalog

Beginning August 28th, 2025, Bitnami will evolve its public catalog to offer a curated set of hardened, security-focused images under the new [Bitnami Secure Images initiative](https://news.broadcom.com/app-dev/broadcom-introduces-bitnami-secure-images-for-production-ready-containerized-applications). As part of this transition:

* Granting community users access for the first time to security-optimized versions of popular container images.
* Bitnami will begin deprecating support for non-hardened, Debian-based software images in its free tier and will gradually remove non-latest tags from the public catalog. As a result, community users will have access to a reduced number of hardened images. These images are published only under the “latest” tag and are intended for development purposes
* Starting August 28th, over two weeks, all existing container images, including older or versioned tags (e.g., 2.50.0, 10.6), will be migrated from the public catalog (docker.io/bitnami) to the “Bitnami Legacy” repository (docker.io/bitnamilegacy), where they will no longer receive updates.
* For production workloads and long-term support, users are encouraged to adopt Bitnami Secure Images, which include hardened containers, smaller attack surfaces, CVE transparency (via VEX/KEV), SBOMs, and enterprise support.

These changes aim to improve the security posture of all Bitnami users by promoting best practices for software supply chain integrity and up-to-date deployments. For more details, visit the [Bitnami Secure Images announcement](https://github.com/bitnami/containers/issues/83267).

## Why use Bitnami Secure Images?

- Bitnami Secure Images and Helm charts are built to make open source more secure and enterprise ready.
- Triage security vulnerabilities faster, with transparency into CVE risks using industry standard Vulnerability Exploitability Exchange (VEX), KEV, and EPSS scores.
- Our hardened images use a minimal OS (Photon Linux), which reduces the attack surface while maintaining extensibility through the use of an industry standard package format.
- Stay more secure and compliant with continuously built images updated within hours of upstream patches.
- Bitnami containers, virtual machines and cloud images use the same components and configuration approach - making it easy to switch between formats based on your project needs.
- Hardened images come with attestation signatures (Notation), SBOMs, virus scan reports and other metadata produced in an SLSA-3 compliant software factory.

Only a subset of BSI applications are available for free. Looking to access the entire catalog of applications as well as enterprise support? Try the [commercial edition of Bitnami Secure Images today](https://www.arrow.com/globalecs/uk/products/bitnami-secure-images/).

## Why use a non-root container?

Non-root container images add an extra layer of security and are generally recommended for production environments. However, because they run as a non-root user, privileged tasks are typically off-limits. Learn more about non-root containers [in our docs](https://techdocs.broadcom.com/us/en/vmware-tanzu/application-catalog/tanzu-application-catalog/services/tac-doc/apps-tutorials-work-with-non-root-containers-index.html).

## Supported tags and respective `Dockerfile` links

Learn more about the Bitnami tagging policy and the difference between rolling tags and immutable tags [in our documentation page](https://techdocs.broadcom.com/us/en/vmware-tanzu/application-catalog/tanzu-application-catalog/services/tac-doc/apps-tutorials-understand-rolling-tags-containers-index.html).

You can see the equivalence between the different tags by taking a look at the `tags-info.yaml` file present in the branch folder, i.e `bitnami/ASSET/BRANCH/DISTRO/tags-info.yaml`.

Subscribe to project updates by watching the [bitnami/containers GitHub repo](https://github.com/bitnami/containers).

## Get this image

The recommended way to get the Bitnami Cluster-autoscaler Docker Image is to pull the prebuilt image from the [Docker Hub Registry](https://hub.docker.com/r/bitnami/cluster-autoscaler).

```console
docker pull bitnami/cluster-autoscaler:latest
```

To use a specific version, you can pull a versioned tag. You can view the [list of available versions](https://hub.docker.com/r/bitnami/cluster-autoscaler/tags/) in the Docker Hub Registry.

```console
docker pull bitnami/cluster-autoscaler:[TAG]
```

If you wish, you can also build the image yourself by cloning the repository, changing to the directory containing the Dockerfile and executing the `docker build` command. Remember to replace the `APP`, `VERSION` and `OPERATING-SYSTEM` path placeholders in the example command below with the correct values.

```console
git clone https://github.com/bitnami/containers.git
cd bitnami/APP/VERSION/OPERATING-SYSTEM
docker build -t bitnami/APP:latest .
```

## Configuration

### How to run a cluster with nodes in multiples zones for HA

`--balance-similar-node-groups` flag is intended to support this use case. If you set the flag to true, Cluster Autoscaler will automatically identify node groups with the same instance type and the same set of labels (except for automatically added zone label) and try to keep the sizes of those node groups balanced.

This does not guarantee similar node groups will have exactly the same sizes:

Currently the balancing is only done at scale-up. Cluster Autoscaler will still scale down underutilized nodes regardless of the relative sizes of underlying node groups.

### How monitor Cluster Autoscaler?

Cluster Autoscaler provides metrics and livenessProbe endpoints. By default they're available on port 8085 (configurable with --address flag), respectively under /metrics and /health-check.

Metrics are provided in Prometheus format.

### How scale my cluster to just 1 node?

Prior to version 0.6, Cluster Autoscaler was not touching nodes that were running important kube-system pods like DNS, Heapster, Dashboard etc. If these pods landed on different nodes, CA could not scale the cluster down and the user could end up with a completely empty 3 node cluster. In 0.6, we added an option to tell CA that some system pods can be moved around. If the user configures a PodDisruptionBudget for the kube-system pod, then the default strategy of not touching the node running this pod is overridden with PDB settings. So, to enable kube-system pods migration, one should set minAvailable to 0 (or <= N if there are N+1 pod replicas.) See also I have a couple of nodes with low utilization, but they are not scaled down. Why?

### How scale a node group to 0?

For GCE/GKE and for AWS, it is possible to scale a node group to 0 (and obviously from 0), assuming that all scale-down conditions are met.

For AWS, if you are using nodeSelector, you need to tag the ASG with a node-template key "k8s.io/cluster-autoscaler/node-template/label/".

For example, for a node label of foo=bar, you would tag the ASG with:

```yaml
{
    "ResourceType": "auto-scaling-group",
    "ResourceId": "foo.example.com",
    "PropagateAtLaunch": true,
    "Value": "bar",
    "Key": "k8s.io/cluster-autoscaler/node-template/label/foo"
}
```

## Notable Changes

### Starting January 16, 2024

* The `docker-compose.yaml` file has been removed, as it was solely intended for internal testing purposes.

## Contributing

We'd love for you to contribute to this container. You can request new features by creating an [issue](https://github.com/bitnami/containers/issues) or submitting a [pull request](https://github.com/bitnami/containers/pulls) with your contribution.

## Issues

If you encountered a problem running this container, you can file an [issue](https://github.com/bitnami/containers/issues/new/choose). For us to provide better support, be sure to fill the issue template.

## License

Copyright &copy; 2025 Broadcom. The term "Broadcom" refers to Broadcom Inc. and/or its subsidiaries.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

<http://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
