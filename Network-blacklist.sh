#!/usr/bin/ksh
#------------------------------------------------------------------------------------
# - Nombre: ./blacklist.sh 
# - Version: 1.0
# - Fecha: 16/03/2012
# - Creador: SI Mundial
# - descripción: THis script search the IP on the public blacklist.
#------------------------------------------------------------------------------------
#set -x
#------------------------------------------------------------------------------------

print "
 
 
░

 
░░░█▀▀▀░░▀█▀░░░░░░░█▄█░░█░░█░░█▀▀█░░█▀▀▄░░▀█▀░░█▀▀█░░█░░░░░
░░░▀▀██░░░█░░░░░░░░█░█░░█░░█░░█░░█░░█░░█░░░█░░░█▀▀█░░█░░░░░
░░░▀▀▀▀░░▀▀▀░░░░░░░▀░▀░░▀▀▀▀░░▀░░▀░░▀▀▀░░░▀▀▀░░▀░░▀░░▀▀▀░░░





               \033[0;31m- Spanish \033[1;33mSecurity \033[0;31mTeam -

           \033[1;37m[- http://www.SIMundial.blogspot.com -]\033[0;37m\033[m
"
sleep 1
print "\033[1;31mInsert the Sospicius IP...\033[m"
read IP
print "\033[1;31mElija una opcion:
\t \033[1;32m1) \033[1;34mWhois\033[m
\t \033[1;32m2) \033[1;34mLookup\033[m
\t \033[1;32m3) \033[1;34mSearch Domains on Robtex\033[m
\t \033[1;32m4) \033[1;34mTraceroute\033[m
\t \033[1;32m5) \033[1;34mCheck IPs on Publics Blacklist\033[m
\t \033[1;32m6) \033[1;34mSearch in all Blacklist URL with firefox\033[m
\t \033[1;32m0) \033[1;34mEXIT\033[m

"
rm /tmp/listurl > /dev/null 2>&1
read OPCION

###################################################################################################
# Check on blacklist
###################################################################################################
if  [[ ${OPCION} == 5 ]]; 
	then
		wget -P/tmp/threatexpert http://www.threatexpert.com/reports.aspx?find=$IP&x=0&y=0  

		wget -P/tmp/malwareurl http://www.malwareurl.com/ns_listing.php?ip=$IP 

		wget -P/tmp/malwaregroup http://www.malwaregroup.com/ipaddresses/details/$IP 

		#wget -P/tmp/scumware http://www.scumware.org/report/$IP 

		wget -P/tmp/hosts-file http://hosts-file.net/default.asp?s=$IP 

		wget -P/tmp/clean-mx support.clean-mx.de/clean-mx/viruses.php?ip=$IP 

print " \033[1;34mThe results of $IP are:

"

			if grep "Risk" /tmp/threatexpert/* > /dev/null 2>&1;
				then
					print "\t\033[1;34mThreatexpert [\033[1;31mMalicius\033[m\033[1;34m]
					"
					print "http://www.threatexpert.com/reports.aspx?find=$IP&x=0&y=0" >> /tmp/listurl
					
				else
					print "\t\033[1;34mThreatexpert [\033[1;32mClean\033[m\033[1;34m] 
					"
			fi
		rm -R /tmp/threatexpert > /dev/null 2>&1
			if grep "details" /tmp/malwareurl/* > /dev/null 2>&1;
				then
					print "\t\033[1;34mMalwareurl [\033[1;31mMalicius\033[m\033[1;34m]
					"
					print " http://www.malwareurl.com/ns_listing.php?ip=$IP" >> /tmp/listurl
				else
					print "\t\033[1;34mMalwareurl [\033[1;32mClean\033[m\033[1;34m]
					"
			fi
		rm -R /tmp/malwareurl > /dev/null 2>&1
			if grep "red-shield.png" /tmp/malwaregroup/* > /dev/null 2>&1;
				then
					print "\t\033[1;34mMalwaregroup [\033[1;31mMalicius\033[m\033[1;34m\033[1;34m]
					"
					print "http://www.malwaregroup.com/ipaddresses/details/$IP" >> /tmp/listurl
				else
					print "\t\033[1;34mMalwaregroup [\033[1;32mClean\033[m]
					"
			fi
		rm -R /tmp/malwaregroup > /dev/null 2>&1
			if grep "zellennormal" /tmp/clean-mx/* > /dev/null 2>&1;
				then
					print "\t\033[1;34mClean-mx [\033[1;31mMalicius\033[m\033[1;34m]
					"
					print "support.clean-mx.de/clean-mx/viruses.php?ip=$IP" >> /tmp/listurl
				else
					print "\t\033[1;34mClean-mx [\033[1;32mClean\033[m\033[1;34m]
					"
			fi
		rm -R /tmp/clean-mx > /dev/null 2>&1
			#if grep "md5" /tmp/scumware/* > /dev/null 2>&1;
			#	then
			#		print "\t\033[1;34mScumware [\033[1;31mMalicius\033[m\033[1;34m]
			#		"
			#	else
			#		print "\t\033[1;34mScumware [\033[1;32mClean\033[m\033[1;34m]
			#		"
			#fi
		#rm -R /tmp/scumware
			if grep "were found in our database " /tmp/hosts-file/* > /dev/null 2>&1;
				then
					print "\t\033[1;34mHosts-file [\033[1;31mMalicius\033[m\033[1;34m]\033[m
					"
					print "http://hosts-file.net/default.asp?s=$IP" >> /tmp/listurl
				else
					print "\t\033[1;34mHosts-file [\033[1;32mClean\033[m\033[1;34m]\033[m
					"
			fi
print "Do you want to see on firefox the links were the $IP was reported? y/n  
" 
read OPEN
	if [[ "$OPEN" = "y" ]];
		then
			while read line
			do 
			   firefox -new-tab "$line"
			done < /tmp/listurl
			rm /tmp/listurl > /dev/null 2>&1
		else
			rm /tmp/listurl > /dev/null 2>&1
	fi 
		rm -R /tmp/hosts-file > /dev/null 2>&1
fi


###################################################################################################
# Todas las URL
###################################################################################################
	if  [[ "$OPCION" = "6" ]]; 
 		then
			firefox -new-tab http://whois.domaintools.com/$IP
			firefox -new-tab http://www.robtex.com/ip/$IP.html#ip
			firefox -new-tab http://www.threatexpert.com/reports.aspx?find=$IP&x=0&y=0
			firefox -new-tab http://www.malwareurl.com/ns_listing.php?ip=$IP
			firefox -new-tab http://www.malwaregroup.com/ipaddresses/details/$IP
			firefox -new-tab support.clean-mx.de/clean-mx/viruses.php?ip=$IP
			firefox -new-tab http://www.scumware.org/report/$IP
			firefox -new-tab http://www.google.com/safebrowsing/diagnostic?site=$IP
			firefox -new-tab http://hosts-file.net/default.asp?s=$IP
			firefox -new-tab http://www.mywot.com/en/scorecard/$IP
			firefox -new-tab http://www.mcafee.com/threat-intelligence/ip/default.aspx?ip=$IP	
fi
###################################################################################################
# Whois
###################################################################################################
	if  [[ "$OPCION" = "1" ]]; 
 		then
			whois $IP	
fi
###################################################################################################
# Lookup
###################################################################################################
	if  [[ "$OPCION" = "2" ]]; 
 		then
			dig -x $IP	
fi
###################################################################################################
# Robtex
###################################################################################################
	if  [[ "$OPCION" = "3" ]]; 
 		then
			firefox -new-tab http://www.robtex.com/ip/$IP.html#ip
fi
###################################################################################################
# Traceroute
###################################################################################################
	if  [[ "$OPCION" = "4" ]]; 
 		then
			traceroute $IP
fi
