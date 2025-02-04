#!/bin/sh
cat <<-EOF > /root/cloudreve/conf.ini
[System]
; 运行模式
Mode = master
; 监听端口
Listen = :${PORT}
#Listen = :8080
; 是否开启 Debug
Debug = false
#[Redis]
#Server = 127.0.0.1:6379
#Password =
#DB = 0
[Database]
#测试aws的数据库成功，阿里云的数据库不行
Type = $DB_Type
Host = $DB_Host
Port = $DB_Port
User = $DB_User
Password = $DB_Password
Name = $DB_Name
Charset = $DB_Charset
TablePrefix = $DB_TablePrefix
; Session 密钥, 一般在首次启动时自动生成
; 5201314的md5加密密文为723d505516e0c197e42a6be3c0af910e
; 搭配cloudreve.db 默认关闭注册 管理员为 admin@cloudreve.org / cloudreve@2020
SessionSecret = 723d505516e0c197e42a6be3c0af910e
; Hash 加盐, 一般在首次启动时自动生成
HashIDSalt = 723d505516e0c197e42a6be3c0af910e
EOF
(redis-server &) && (./cloudreve -c /root/cloudreve/conf.ini)
