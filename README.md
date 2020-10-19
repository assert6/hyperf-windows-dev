# hyperf-windows-dev
- 修改`Dockerfile`里`你的公钥`

- `docker build -t hyperf-windows-dev .`

- `Run/Edit Configurations...` 配置docker, 注意Command 和Bind ports
 ![avatar](./src/1.png)

- `Shift + F10` 启动容器
 
- `Tools/Deployment/Configurations...` 配置sftp, 填写上一步的端口和Dockerfile 里的公钥, Root path 不要选根目录 
![avatar](./src/2.png)

- 选中根目录, 勾选Automatic Upload, 上传文件到容器
![avatar](./src/3.png)

- 在容器窗口运行`hyperf-watch -c --dir /home`