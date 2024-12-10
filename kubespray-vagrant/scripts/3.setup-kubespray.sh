#!/usr/bin/env bash

cd ~

# 기본 쿠버네티스 버전: 1.30
git clone --branch release-2.26 https://github.com/kubernetes-sigs/kubespray.git

# Python 가상환경 생성
python3 -m venv ~/kubespray

# Python 가상환경 활성화
source ~/kubespray/bin/activate

cp -f ~/shared/requirements.txt ~/kubespray/requirements.txt

# requirements.txt 파일에서 의존성 확인 및 설치
pip install -U -r ~/kubespray/requirements.txt

# Ansible 인벤토리 준비
cp -rfp ~/kubespray/inventory/sample ~/kubespray/inventory/mycluster

# 파일 이동
cp -f ~/shared/addons.yml ~/kubespray/inventory/mycluster/group_vars/k8s_cluster/addons.yml
cp -f ~/shared/k8s-cluster.yml ~/kubespray/inventory/mycluster/group_vars/k8s_cluster/k8s-cluster.yml
cp -f ~/shared/inventory.ini ~/kubespray/inventory/mycluster/inventory.ini

# Ansible 통신 가능 확인
ansible all -i ~/kubespray/inventory/mycluster/inventory.ini -m ping

# 플레이북 실행
cd ~/kubespray
ansible-playbook -i ~/kubespray/inventory/mycluster/inventory.ini --become ~/kubespray/cluster.yml

# 자격 증명 가져오기
mkdir ~/.kube
sudo cp /etc/kubernetes/admin.conf ~/.kube/config
sudo chown $USER:$USER ~/.kube/config

# kubectl 명령 자동완성 확인
source /etc/bash_completion.d/kubectl.sh

# Kubernetes 클러스터 확인
kubectl get nodes
