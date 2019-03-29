#!/bin/bash
PASSWORD=$(tr -cd 'a-zA-z0-9' < /dev/urandom | head -c 10)
if [ $# -ne 1 ]
then 
 echo "please input 'a' to add,input 'd' to del"
 exit
elif [ $1 == a ]
   then    
         read -p "add vpn-user：" USERNAME
           if grep -w $USERNAME /etc/openvpn/psw-file
          	then "exit"
          	else
             echo $USERNAME $PASSWORD >>/etc/openvpn/psw-file
             echo -e "username: $USERNAME  password: $PASSWORD    \n吾好wiki文档: http://wiki. 或查看钉钉大群VPN文件夹 " | mail -s "WH-VPN" $USERNAME@qq.com
             /bin/bash /etc/openvpn/transfer.sh
           fi
elif [ $1 == d ]
   then
          read -p "delete vpn-user：" USERNAME
           if grep -w $USERNAME /etc/openvpn/psw-file
                  then 
             sed -i '/'"$USERNAME"'/d' /etc/openvpn/psw-file
             /bin/bash /etc/openvpn/transfer.sh
               else
             echo $USERNAME not have vpn 
           fi
else
 exit
fi
