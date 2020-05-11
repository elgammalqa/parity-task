# Take Home Test from Parity Technologies


This project to deploy[Polkadot](https://github.com/paritytech/polkadot) node and join to Kusama network .         



## Tools

- [Terraform](https://www.terraform.io) provide the structure at the GCP.
- [Ansible](https://www.ansible.com) execute playbooks and install required softwares over the VM.
- [Docker](https://www.docker.com) abstract all tools and don't blow up your localhost.

## Prerequisites

* [Docker](https://docs.docker.com/engine/installation/)


### Setup

First off all, clone this repository and setup the docker image with all the tools to get things done.

```bash
$ git clone 
$ cd polkadot
$ make setup
```




### local setup

** assume your ssh keys  `$HOME/.ssh/` with the names `id_rsa` and `id_rsa.pub` if you're using other path, edit the path at `Makefile` on line `13`:

```bash
--volume $(HOME)/.ssh/:/home/polkadot/.ssh/:ro \
```


```bash
$  export GCP_TOKEN=$(cat /path/to/your/key.json)
$  export PROJECT="your-project-ID"
```

Choose the number of polkadots nodes you want deploy, and their respective names at `ansible/all.yml`

```yaml
- polkadot_node_name: "YOUR-POLKADOT-NODE-NAME-HERE"
- polkadot_node_count: 4
```


## Deploy resources

### creating the infrastructure

To create the environment, execute:

```bash
$ make build-all
```

### provisioning the polkadot

After the VM was deployed, configure executing:

```bash
$ make provision-all
```

## Check service status

You could check you polkadot node running [here](https://telemetry.polkadot.io/). 

## Destroy the infrastructure


```bash
$ make destroy-all
```
