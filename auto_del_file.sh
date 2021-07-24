#!/bin/bash
find /xx -mtime +2 -name "*.sql"  -exec -rm -rf {} \;
# /xx 指需要清理目录的路径
# +2 指清理两天前的数据
# “*.sql” 指需要清理的文件格式