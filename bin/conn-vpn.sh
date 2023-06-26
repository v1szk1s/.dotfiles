#!/usr/bin/expect -f  

# Constants  
cd /home/v1szk1s/work/vpn

set user "aattila"  
set pass $env(VPN_PASSWD)
set sudo_pass $env(PASSWD)
set timeout -1  

# Options  
match_max 100000  
log_user 0  

# Access to device  
spawn sudo openvpn --config /home/v1szk1s/work/vpn/Ambrus_Attila-infint.ovpn
expect {[sudo]*}
send -- "$sudo_pass\r"  

expect "*?sername:*"  
send -- "$user\r"

expect "*?assword:*"  
send -- "$pass\r"

#interact
#close


expect eof
exit
