# hyperf-windows-dev
windows 下使用docker 挂载磁盘启动Hyperf非常慢, 这里提供一个思路: 不挂载磁盘, 容器内启用sftp 配合ide同步代码 
- 修改`Dockerfile`里`你的公钥`

- `docker build -t hyperf-windows-dev .`

- `Run/Edit Configurations...` 配置docker, Command:`sh -c "/usr/sbin/sshd && /bin/bash"`, Bind ports 22端口为容器sftp
 ![avatar](./src/1.png)

- `Shift + F10` 启动容器
 
- `Tools/Deployment/Configurations...` 配置sftp, 填写上一步暴露的22端口和Dockerfile 里的公钥 
![avatar](./src/2.png)

- Devployment path不要选根目录
![avatar](./src/4.png)

- 选中根目录, 勾选Automatic Upload, 上传文件到容器
![avatar](./src/3.png)

- 在容器窗口运行`hyperf-watch -c --dir /home`