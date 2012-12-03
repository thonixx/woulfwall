#woulfwall
Scripts used for iptable thingies.

##Notice:
To use the restore script please create the iptables.up.rules with "iptables-save > iptables.up.rules".


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
	a threshold value.

    Example:  
        ./failed-logins.sh 5  
        Just show failed logins if failed 5 times  
        Default value is 10.

###block.sh
>	Define an IP to block.

    Example:  
        ./block.sh 123.123.123.123  
        Block IP 123.123.123.123

###check.sh
>	Check if an IP or IP range is being blocked.

    Example:  
        ./check.sh 123.123.123.123
