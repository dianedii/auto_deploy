此库是Centos7下一些基础软件自动化部署的脚本。

所有脚本主要是为了支持内网部署，由于外网部署较为方便，这里除auto_nginx.sh外，其他的未作支持。

---



目前包含内容：

* jdk

* mysql

* nginx（脚本需要复制到与nginx及其相关安装包同一目录下进行执行，在此即为`/opt/software`下）

* redis	（`/opt/software/redis-4.0.6/config`下会生成启/停脚本）

* tomcat（无）

* nodejs（无）

* 展示获取机器信息

* 初始化机器后基础配置脚本

* 清理内存（配合定时）

* 内网镜像挂载及yum配置  （iso镜像放置位置无要求）

---



所有基础软件默认放在 `/opt/software`目录下

脚本设置默认安装包名为：

* jdk-8u181-linux-x64.rpm

* mysql-5.7.25.tar.gz 	(mysql安装包是rpm包的组合包)

* nginx-1.16.1.tar.gz（依赖包：zlib-1.2.11.tar.gz	pcre-8.40.tar.gz	openssl-1.1.1j.tar.gz）

* redis-4.0.6.tar.gz

使用不同版本安装包可在脚本中自行修改。



* 部分安装包下载百度网盘：

  链接：https://pan.baidu.com/s/1CdNLB-g8R4T1kLvwJjmbww 
  提取码：l14o 

---



脚本运行方法：

将安装包正确放置，除nginx脚本外，其余脚本位置无要求。

给脚本增加可执行权限：

`chmod +x XXX.sh`

若执行脚本出现：`-bash: ./test.sh: /bin/sh^M: bad interpreter: No such file or directory`

是脚本格式的问题，`vi`/`vim`报错脚本执行`:set fileformat=unix`后，保存退出再执行脚本即可。

---




