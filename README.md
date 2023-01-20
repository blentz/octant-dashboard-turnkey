# Octant Dashboard turnkey Docker image and Helm deployment files

This repository provides ready-to-use Helm deployment files and a Docker image
to run the [Octant](https://octant.dev/) tool inside a container.

## What is Octant

From the [Octant GitHub repository](https://github.com/vmware-tanzu/octant):

> A highly extensible platform for developers to better understand the complexity of Kubernetes clusters.

Octant is a tool for developers to understand how applications run on a Kubernetes cluster. It aims to be part of the developer's toolkit for gaining insight and approaching complexity found in Kubernetes. Octant offers a combination of introspective tooling, cluster navigation, and object management along with a plugin system to further extend its capabilities.

## How to build

`docker build -t octant:latest .`

## How to run

`docker run --name octant -p 7777:7777 --rm -d -v ~/.kube:/home/octant/.kube -v ~/.config:/home/octant/.config octant:latest`
