#!/bin/bash
# xxx表示需要填写的信息。
# 需要注意的是数据库密码最好不要写在脚本中，即 -p 后的内容。密码可以填充在mysql的配置文件中，格式如下：
# [mysqldump]
# user=XXX
# password=XXX
# 如果将密码写在该脚本中，最好设置其访问权限为700
mysqldump -u xxx -p xxx --all -databases > /home/xxx/Bak_$(date +%Y%m%d_%H%M%S).sql

