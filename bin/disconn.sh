#!/usr/bin/expect -f  

# Constants  

set sudo_pass $env(PASSWD)

spawn sudo killall openvpn
expect {[sudo]*}
send -- "$sudo_pass\r"  

expect eof
exit
