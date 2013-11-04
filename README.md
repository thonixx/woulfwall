#woulfwall
Scripts used for iptable thingies.

##Prepare the environment:
To use the restore script please create the iptables.up.rules with **"iptables-save > iptables.up.rules"**.
For the first time it is recommended to hard link the iptables rules from **"/path/to/git/iptables.up.rules"** to **"/etc/iptables.up.rules"**.
After that you can add the following line to the network interfaces configuration to ensure iptables restore at interface start:

    auto eth0  
        iface [...]  
        [...]  
        post-up iptables-restore < /etc/iptables.up.rules

##Scripts:

###allow.sh
>	Opening firewall and drop nothing.

###restore.sh
>	Used to restore rules in iptables.up.rules and the geoblock with your custom rules.

###geoblock.sh
>	Apply geoblock for Korean/Asian/Chinese ip ranges and your  
	custom rules in iptables.ranges file.

###failed-logins.sh
>	Parse auth.log for failed logins and list. You can define  
	a threshold value. Also you can write "rev" as second parameter  
	to show the reverse entry of an IP address.

    Example:  
        ./failed-logins.sh 5  
        Just show failed logins if failed 5 times  
        Default value is 10.
          
        ./failed-logins.sh 1 rev
        Show all more than 1 times failed logins with  
        a corresponding reverse DNS entry.

###block.sh
>	Define an IP to block.

    Example:  
        ./block.sh 123.123.123.123  
        Block IP 123.123.123.123

###check.sh
>	Check if an IP or IP range is being blocked.

    Example:  
        ./check.sh 123.123.123.123
