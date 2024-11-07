#!/bin/bash  

# 修改 sshd_config 以允许 root 登录和密码认证  
sed -i 's/#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config  
sed -i 's/#PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config  

# 创建一个临时文件  
temp_file=$(mktemp)  

# 从 authorized_keys 文件中复制不需要删除的行到临时文件  
grep -v 'no-port-forwarding,no-agent-forwarding,no-X11-forwarding,command="echo '\''Please login as the user \"linux1\" rather than the user \"root\".'\'';echo;sleep 10;exit 142"' /root/.ssh/authorized_keys > "$temp_file"  

# 将临时文件替换为原文件  
mv "$temp_file" /root/.ssh/authorized_keys  

# 重新启动 ssh 服务以应用更改  
systemctl restart sshd  

# 输出提示信息  
echo "SSH 配置已更新，特定条目已从 /root/.ssh/authorized_keys 中删除，并已重新启动 SSH 服务。"
