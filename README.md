此库是Centos7下一些基础软件自动化部署的脚本。



目前包含内容：

jdk

mysql

nginx（无）

redis

tomcat（无）

nodejs（无）

展示获取机器信息

初始化机器后基础配置脚本

清理内存（配合定时）

内网镜像挂载及yum配置  （无）

---



所有基础软件默认放在 `/opt/software`目录下

脚本设置默认安装包名为：

jdk-8u181-linux-x64.rpm

mysql-5.7.25.tar.gz 	(mysql安装包是rpm包的组合包)

nginx-1.16.1.tar.gz

redis-4.0.6.tar.gz

使用不同版本安装包可在脚本中自行修改。

---



脚本运行方法：

将安装包正确放置，脚本位置随意放。

给脚本增加可执行权限：

`chmod +x XXX.sh`

若执行脚本出现：`-bash: ./test.sh: /bin/sh^M: bad interpreter: No such file or directory`

是脚本格式的问题，`vi`/`vim`报错脚本执行`:set fileformat=unix`后，保存退出再执行脚本即可。





内网环境下

外网环境下