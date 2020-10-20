# hyperf-windows-dev
因`Docker` 底层原因, `Windows` / `Mac` 下挂载磁盘启动`Hyperf` 非常慢, 这里提供一个思路: 不挂载磁盘, 容器内部署`SFTP` 配合ide同步代码

(新版Docker 配合WSL2 已经解决文件共享问题, [推荐使用](https://docs.docker.com/docker-for-windows/wsl/))
 
1. 下载`Dockerfile`, 将`Dockerfile`里`你的公钥` 替换为你的`SSH` 公钥 (例:C:\Users\Administrator\.ssh\id_rsa.pub)

2. 命令行构建镜像 `docker build -t hyperf-windows-dev .`

3. 以下在`PHPStorm` 你的`Hyperf`项目中

4. 打开菜单`Run/Edit Configurations...` 
配置`Docker`, `Command`填`sh -c "/usr/sbin/sshd && /bin/bash"`, `Bind ports` 22端口为容器`SFTP`端口(写死), 822为向外暴露端口, 不可重复
 ![avatar](./src/1.png)

5. `Shift + F10` 启动容器, 留意这一步中`Attached Console` 窗口, 最后一步在这里输入
 
6. `Tools/Deployment/Configurations...` 配置SFTP, 填写上一步暴露的22端口和Dockerfile 里的公钥 
![avatar](./src/2.png)

7. Devployment path不要选根目录
![avatar](./src/4.png)

8. 选中根目录, 勾选Automatic Upload, 上传文件到容器
![avatar](./src/3.png)

9. 在第5步容器窗口中运行`hyperf-watch -c --dir /home`