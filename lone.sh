#!/bin/bash  

# 执行 Docker 安装脚本  
bash <(curl -sSL https://linuxmirrors.cn/docker.sh)  

# 等待用户确认安装（输入 Y）  
read -p "请在安装后输入 Y 以继续: " confirm  
if [[ "$confirm" != "Y" && "$confirm" != "y" ]]; then  
    echo "安装未确认，脚本将退出。"  
    exit 1  
fi  

# 等待 10 秒  
sleep 10  

# 模拟输入 13  
echo "13" | sudo tee /dev/tty  

# 等待 10 秒  
sleep 10  

# 模拟输入 1  
echo "1" | sudo tee /dev/tty  

# 安装 QEMU 和 binfmt-support  
sudo apt-get install -y qemu-user-static binfmt-support  

# 注册 QEMU 以支持 x86 架构  
sudo update-binfmts --enable qemu-x86_64  
sudo apt-get install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils  
sudo systemctl start libvirtd  
sudo systemctl enable libvirtd  

# 输出完成信息  
echo "QEMU 和相关组件已安装并启动。"
