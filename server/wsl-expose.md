wsl -d kali-linux

hostname -I



$wslIp = wsl -d kali-linux hostname -I
$wslIp = $wslIp.Trim()
netsh interface portproxy add v4tov4 listenport=2222 listenaddress=0.0.0.0 connectport=22 connectaddress=$wslIp


New-NetFirewallRule -DisplayName "WSL Kali SSH Temp" -Direction Inbound -Protocol TCP -LocalPort 2222 -Action Allow

ssh <kali_username>@<windows_host_ip> -p 2222



Remove forwarding when done:
netsh interface portproxy delete v4tov4 listenport=2222 listenaddress=0.0.0.0
