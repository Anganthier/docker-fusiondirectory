#!/usr/bin/with-contenv bash

  ### Adjust NGINX Runtime Variables
  UPLOAD_MAX_SIZE=${UPLOAD_MAX_SIZE:="2G"}
  sed -i -e "s/<UPLOAD_MAX_SIZE>/$UPLOAD_MAX_SIZE/g" /etc/nginx/nginx.conf
  
  ### FusionDirectory
  ### Sanity Test, Set Default Environment Variables
  ENABLE_ARGONAUT=${ENABLE_ARGONAUT-"false"}
  LDAP_ADMIN_PASSWORD=${LDAP_ENV_LDAP_ADMIN_PASSWORD:-${LDAP_ADMIN_PASSWORD}}
  LDAP_COMM_PORT=${LDAP_COMM_PORT:-389}
  LDAP_DOMAIN=${LDAP_ENV_LDAP_DOMAIN:-${LDAP_DOMAIN}}
  LDAP_HOST=${LDAP_PORT_389_TCP_ADDR:-${LDAP_HOST}}
  LDAP_SCHEME=${LDAP_SCHEME:-"ldap"}
  LDAP_TLS=${LDAP_TLS:-"false"}
  LDAP_TLS=${LDAP_ENV_LDAP_TLS:-${LDAP_TLS}}
  PLUGIN_ALIAS=${PLUGIN_ALIAS:-false}
  PLUGIN_APPLICATIONS=${PLUGIN_APPLICATIONS:-false}
  PLUGIN_ARGONAUT=${PLUGIN_ALIAS:-false}
  PLUGIN_AUDIT=${PLUGIN_ALIAS:-false}
  PLUGIN_AUTOFS=${PLUGIN_ALIAS:-false}
  PLUGIN_CERTIFICATES=${PLUGIN_ALIAS:-false}
  PLUGIN_COMMUNITY=${PLUGIN_ALIAS:-false}
  PLUGIN_CYRUS=${PLUGIN_CYRUS:-false}
  PLUGIN_DEBCONF=${PLUGIN_DEBCONF:-false}
  PLUGIN_DEVELOPERS=${PLUGIN_DEVELOPERS:-false}
  PLUGIN_DHCP=${PLUGIN_DHCP:-false}
  PLUGIN_DNS=${PLUGIN_DNS:-false}
  PLUGIN_DOVECOT=${PLUGIN_DOVECOT:-false}
  PLUGIN_DSA=${PLUGIN_DSA:-false}
  PLUGIN_EJBCA=${PLUGIN_EJBCA:-false}
  PLUGIN_FAI=${PLUGIN_FAI:-false}
  PLUGIN_FREERADIUS=${PLUGIN_FREERADIUS:-false}
  PLUGIN_FUSIONINVENTORY=${PLUGIN_FUSIONINVENTORY:-false}
  PLUGIN_GPG=${PLUGIN_GPG:-false}
  PLUGIN_IPMI=${PLUGIN_IPMI:-false}
  PLUGIN_LDAPDUMP=${PLUGIN_LDAPDUMP:-false}
  PLUGIN_LDAPMANAGER=${PLUGIN_LDAPMANAGER:-false}
  PLUGIN_MAIL=${PLUGIN_MAIL:-false}
  PLUGIN_MIXEDGROUPS=${PLUGIN_MIXEDGROUPS:-false}
  PLUGIN_NAGIOS=${PLUGIN_NAGIOS:-false}
  PLUGIN_NETGROUPS=${PLUGIN_NETGROUPS:-false}
  PLUGIN_NEWSLETTER=${PLUGIN_NEWSLETTER:-false}
  PLUGIN_OPSI=${PLUGIN_OPSI:-false}
  PLUGIN_PERSONAL=${PLUGIN_PERSONAL:-false}
  PLUGIN_POSIX=${PLUGIN_POSIX:-false}
  PLUGIN_POSTFIX=${PLUGIN_POSTFIX:-false}
  PLUGIN_PPOLICY=${PLUGIN_PPOLICY:-false}
  PLUGIN_PUPPET=${PLUGIN_PUPPET:-false}
  PLUGIN_PUREFTPD=${PLUGIN_PUREFTPD:-false}
  PLUGIN_QUOTA=${PLUGIN_QUOTA:-false}
  PLUGIN_RENATER_PARTAGE=${PLUGIN_RENATER_PARTAGE:-false}
  PLUGIN_REPOSITORY=${PLUGIN_REPOSITORY:-false}
  PLUGIN_SAMBA=${PLUGIN_SAMBA:-false}
  PLUGIN_SOGO=${PLUGIN_SOGO:-false}
  PLUGIN_SPAMASSASSIN=${PLUGIN_SPAMASSASSIN:-false}
  PLUGIN_SQUID=${PLUGIN_SQUID:-false}
  PLUGIN_SSH=${PLUGIN_SSH:-false}
  PLUGIN_SUBCONTRACTING=${PLUGIN_SUBCONTRACTING:-false}
  PLUGIN_SUDO=${PLUGIN_SUDO:-false}
  PLUGIN_SUPANN=${PLUGIN_SUPANN:-false}
  PLUGIN_SYMPA=${PLUGIN_SYMPA:-false}
  PLUGIN_SYSTEMS=${PLUGIN_SYSTEMS:-false}
  PLUGIN_USER_REMINDER=${PLUGIN_USER_REMINDER:-false}
  PLUGIN_WEBLINK=${PLUGIN_WEBLINK:-false}
  PLUGIN_WEBSERVICE=${PLUGIN_WEBSERVICE:-false}



#### Plugin Dependencies Override
 ### Admin Plugins
  ## Audit
  if [ "$PLUGIN_AUDIT" != "FALSE" ] || [ "$PLUGIN_AUDIT" != "false" ];  then
    export PLUGIN_ARGONAUT=TRUE
  fi

  ## LDAP Dump
  if [ "$PLUGIN_LDAPDUMP" != "FALSE" ] || [ "$PLUGIN_LDAPDUMP" != "false" ];  then
    :
  fi

  ## LDAP Manager
  if [ "$PLUGIN_LDAPMANAGER" != "FALSE" ] || [ "$PLUGIN_LDAPMANAGER" != "false" ];  then
    :
  fi

  ## User Reminder
  if [ "$PLUGIN_USER_REMINDER" != "FALSE" ] || [ "$PLUGIN_USER_REMINDER" != "false" ];  then
    export PLUGIN_ARGONAUT=TRUE
  fi

  ## Webservice
  if [ "$PLUGIN_WEBSERVICE" != "FALSE" ] || [ "$PLUGIN_WEBSERVICE" != "false" ];  then
    :
  fi

 ### Mail Plugins
  ## Cyrus
  if [ "$PLUGIN_CYRUS" != "FALSE" ] || [ "$PLUGIN_CYRUS" != "false" ];  then
    export PLUGIN_MAIL=TRUE
    export PLUGIN_SYSTEMS=TRUE
  fi

  ## Dovecot
  if [ "$PLUGIN_DOVECOT" != "FALSE" ] || [ "$PLUGIN_DOVECOT" != "false" ];  then
    export PLUGIN_MAIL=TRUE
    export PLUGIN_SYSTEMS=TRUE
  fi

  ## Postfix
  if [ "$PLUGIN_POSTFIX" != "FALSE" ] || [ "$PLUGIN_POSTFIX" != "false" ];  then
    export PLUGIN_MAIL=TRUE
    export PLUGIN_SYSTEMS=TRUE
  fi

  ## Sogo
  if [ "$PLUGIN_SOGO" != "FALSE" ] || [ "$PLUGIN_SOGO" != "false" ];  then
    export PLUGIN_MAIL=TRUE
    export PLUGIN_SYSTEMS=TRUE
  fi

  ## Sympa
  if [ "$PLUGIN_SYMPA" != "FALSE" ] || [ "$PLUGIN_SYMPA" != "false" ];  then
    export PLUGIN_ALIAS=TRUE
  fi

  ## SpamAssassin
  if [ "$PLUGIN_SPAMASSASSIN" != "FALSE" ] || [ "$PLUGIN_SPAMASSASSIN" != "false" ];  then
    export PLUGIN_MAIL=TRUE
    export PLUGIN_SYSTEMS=TRUE
  fi

 ### Services Plugins
  ## AutoFS
  if [ "$PLUGIN_AUTOFS" != "FALSE" ] || [ "$PLUGIN_AUTOFS" != "false" ];  then
    export PLUGIN_SYSTEMS=TRUE
  fi

  ## DSA
  if [ "$PLUGIN_DSA" != "FALSE" ] || [ "$PLUGIN_DSA" != "false" ];  then
    :
  fi

  ## DHCP
  if [ "$PLUGIN_DHCP" != "FALSE" ] || [ "$PLUGIN_DHCP" != "false" ];  then
    export PLUGIN_SYSTEMS=TRUE
  fi

  ## DNS
  if [ "$PLUGIN_DNS" != "FALSE" ] || [ "$PLUGIN_DNS" != "false" ];  then
    :
  fi

  ## Ejbca
  if [ "$PLUGIN_EJBCA" != "FALSE" ] || [ "$PLUGIN_EJBCA" != "false" ];  then
    :
  fi

  ## FusionInventory
  if [ "$PLUGIN_FUSIONINVENTORY" != "FALSE" ] || [ "$PLUGIN_FUSIONINVENTORY" != "false" ];  then
    export PLUGIN_SYSTEMS=TRUE
  fi

  ## GPG
  if [ "$PLUGIN_GPG" != "FALSE" ] || [ "$PLUGIN_GPG" != "false" ];  then
    export PLUGIN_SYSTEMS=TRUE
  fi

  ## IPMI
  if [ "$PLUGIN_IPMI" != "FALSE" ] || [ "$PLUGIN_IPMI" != "false" ];  then
    export PLUGIN_SYSTEMS=TRUE
  fi

  ## NetGroups
  if [ "$PLUGIN_NETGROUPS" != "FALSE" ] || [ "$PLUGIN_NETGROUPS" != "false" ];  then
    :
  fi

  ## PPolicy
  if [ "$PLUGIN_PPOLICY" != "FALSE" ] || [ "$PLUGIN_PPOLICY" != "false" ];  then
    :
  fi

  ## Quota
  if [ "$PLUGIN_QUOTA" != "FALSE" ] || [ "$PLUGIN_QUOTA" != "false" ];  then
    export PLUGIN_SYSTEMS=TRUE
  fi

  ## Repository
  if [ "$PLUGIN_REPOSITORY" != "FALSE" ] || [ "$PLUGIN_REPOSITORY" != "false" ];  then
    export PLUGIN_SYSTEMS=TRUE
  fi

  ## Squid
  if [ "$PLUGIN_SQUID" != "FALSE" ] || [ "$PLUGIN_SQUID" != "false" ];  then
    :
  fi

  ## Sudo
  if [ "$PLUGIN_SUDO" != "FALSE" ] || [ "$PLUGIN_SUDO" != "false" ];  then
    :
  fi

  ## Weblink
  if [ "$PLUGIN_WEBLINK" != "FALSE" ] || [ "$PLUGIN_WEBLINK" != "false" ];  then
    :
  fi

 ### Deployment Plugins
  ## Debconf
  if [ "$PLUGIN_DEBCONF" != "FALSE" ] || [ "$PLUGIN_DEBCONF" != "false" ];  then
    :
  fi

  ## FAI
  if [ "$PLUGIN_FAI" != "FALSE" ] || [ "$PLUGIN_FAI" != "false" ];  then
    export PLUGIN_ARGONAUT=TRUE
    export PLUGIN_SYSTEMS=TRUE
  fi

  ## OPSI
  if [ "$PLUGIN_OPSI" != "FALSE" ] || [ "$PLUGIN_OPSI" != "false" ];  then
    export PLUGIN_ARGONAUT=TRUE
    export PLUGIN_DNS=TRUE
    export PLUGIN_SAMBA=TRUE
    export PLUGIN_SYSTEMS=TRUE
  fi

  ## Puppet
  if [ "$PLUGIN_PUPPET" != "FALSE" ] || [ "$PLUGIN_PUPPET" != "false" ];  then
    :
  fi

 ### System Management Plugins
  ## Argonaut
  if [ "$PLUGIN_ARGONAUT" != "FALSE" ] || [ "$PLUGIN_SYSTEMS" != "false" ];  then
    export PLUGIN_SYSTEMS=TRUE
  fi

  ## Systems
  if [ "$PLUGIN_SYSTEMS" != "FALSE" ] || [ "$PLUGIN_SYSTEMS" != "false" ];  then
    export PLUGIN_ARGONAUT=TRUE
  fi

  ## Samba
  if [ "$PLUGIN_SAMBA" != "FALSE" ] || [ "$PLUGIN_SAMBA" != "false" ];  then
    export PLUGIN_SYSTEMS=TRUE
  fi

 ### User Management Plugins
  ## Certificates
  if [ "$PLUGIN_CERTIFICATES" != "FALSE" ] || [ "$PLUGIN_CERTIFICATES" != "false" ];  then
    :
  fi

  ## FreeRadius
  if [ "$PLUGIN_FREERADIUS" != "FALSE" ] || [ "$PLUGIN_FREERADIUS" != "false" ];  then
    :
  fi

  ## Mixed Groups
  if [ "$PLUGIN_MIXEDGROUPS" != "FALSE" ] || [ "$PLUGIN_MIXEDGROUPS" != "false" ];  then
    :
  fi

  ## Nagios
  if [ "$PLUGIN_NAGIOS" != "FALSE" ] || [ "$PLUGIN_MIXEDGROUPS" != "false" ];  then
    :
  fi

  ## Newsletter
  if [ "$PLUGIN_NEWSLETTER" != "FALSE" ] || [ "$PLUGIN_NEWSLETTER" != "false" ];  then
    :
  fi

  ## Personal
  if [ "$PLUGIN_PERSONAL" != "FALSE" ] || [ "$PLUGIN_PERSONAL" != "false" ];  then
    :
  fi

  ## PureFTPd
  if [ "$PLUGIN_PUREFTPD" != "FALSE" ] || [ "$PLUGIN_PUREFTPD" != "false" ];  then
    :
  fi

  ## Quota
  if [ "$PLUGIN_QUOTA" != "FALSE" ] || [ "$PLUGIN_QUOTA" != "false" ];  then
    export PLUGIN_SYSTEMS=TRUE
  fi

  ## Subcontracting
  if [ "$PLUGIN_SUBCONTRACTING" != "FALSE" ] || [ "$PLUGIN_SUBCONTRACTING" != "false" ];  then
    :
  fi

  ## Supann
  if [ "$PLUGIN_SUPANN" != "FALSE" ] || [ "$PLUGIN_SUPANN" != "false" ];  then
    :
  fi

  PLUGINS_ENABLED=`printenv | sort | grep PLUGIN | grep TRUE |sed -e 's/PLUGIN_//g' | sed -e 's/=TRUE//g' | awk -vRS="" -vOFS=', ' '$1=$1' | tr A-Z a-z`


### Create Plugins Archive
  if [ "$PLUGIN_ALIAS" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/alias ; fi;
  if [ "$PLUGIN_APPLICATIONS" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/applications ; fi;
  if [ "$PLUGIN_ARGONAUT" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/argonaut ; fi;
  if [ "$PLUGIN_AUDIT" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/audit ; fi;
  if [ "$PLUGIN_AUTOFS" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/autofs ; fi;
  if [ "$PLUGIN_CERTIFICATES" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/certificates ; fi;
  if [ "$PLUGIN_COMMUNITY" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/community ; fi;
  if [ "$PLUGIN_CYRUS" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/cyrus ; fi;
  if [ "$PLUGIN_DEBCONF" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/debconf ; fi;
  if [ "$PLUGIN_DEVELOPERS" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/developers ; fi;
  if [ "$PLUGIN_DHCP" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/dhcp ; fi;
  if [ "$PLUGIN_DNS" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/dns ; fi;
  if [ "$PLUGIN_DOVECOT" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/dovecot ; fi;
  if [ "$PLUGIN_DSA" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/dsa ; fi;
  if [ "$PLUGIN_EJBCA" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/ejbca ; fi;
  if [ "$PLUGIN_FAI" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/fai ; fi;
  if [ "$PLUGIN_FREERADIUS" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/freeradius ; fi;
  if [ "$PLUGIN_FUSIONINVENTORY" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/fusioninventory ; fi;
  if [ "$PLUGIN_GPG" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/gpg ; fi;
  if [ "$PLUGIN_IPMI" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/ipmi ; fi;
  if [ "$PLUGIN_LDAPDUMP" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/ldapdump ; fi;
  if [ "$PLUGIN_LDAPMANAGER" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/ldapmanager ; fi;
  if [ "$PLUGIN_MAIL" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/mail ; fi;
  if [ "$PLUGIN_MIXEDGROUPS" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/mixedgroups ; fi;
  if [ "$PLUGIN_NAGIOS" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/nagios ; fi;
  if [ "$PLUGIN_NETGROUPS" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/netgroups ; fi;
  if [ "$PLUGIN_NEWSLETTER" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/newsletter ; fi;
  if [ "$PLUGIN_OPSI" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/opsi ; fi;
  if [ "$PLUGIN_PERSONAL" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/personal ; fi;
  if [ "$PLUGIN_POSIX" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/posix ; fi;
  if [ "$PLUGIN_POSTFIX" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/postfix ; fi;
  if [ "$PLUGIN_PPOLICY" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/ppolicy ; fi;
  if [ "$PLUGIN_PUPPET" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/puppet ; fi;
  if [ "$PLUGIN_PUREFTPD" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/pureftpd ; fi;
  if [ "$PLUGIN_QUOTA" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/quota ; fi;
  if [ "$PLUGIN_RENATER_PARTAGE" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/renater-partage ; fi;
  if [ "$PLUGIN_REPOSITORY" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/repository ; fi;
  if [ "$PLUGIN_SAMBA" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/samba ; fi;
  if [ "$PLUGIN_SOGO" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/sogo ; fi;
  if [ "$PLUGIN_SPAMASSASSIN" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/spamassassin ; fi;
  if [ "$PLUGIN_SQUID" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/squid ; fi;
  if [ "$PLUGIN_SSH" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/ssh ; fi;
  if [ "$PLUGIN_SUBCONTRACTING" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/subcontracting ; fi;
  if [ "$PLUGIN_SUDO" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/sudo ; fi;
  if [ "$PLUGIN_SUPANN" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/supann ; fi;
  if [ "$PLUGIN_SYMPA" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/sympa ; fi;
  if [ "$PLUGIN_SYSTEMS" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/systems ; fi;
  if [ "$PLUGIN_USER_REMINDER" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/user-reminder ; fi;
  if [ "$PLUGIN_WEBLINK" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/weblink ; fi;
  if [ "$PLUGIN_WEBSERVICE" != "TRUE" ]; then rm -rf /assets/fusiondirectory-plugins/webservice ; fi;
  cd /assets
  echo '** Enabling the following plugins: '$PLUGINS_ENABLED
  tar cfz fusiondirectory-plugins.tar.gz ./fusiondirectory-plugins

### Install Plugins
  echo '/assets/fusiondirectory-plugins.tar.gz' | fusiondirectory-setup --set-fd_home=/www/fusiondirectory --write-vars --install-plugins --check-directories --update-locales --update-cache  >/dev/null
  rm -rf /assets/fusiondirectory-plugins.tar.gz /assets/fusiondirectory-plugins

### Configuration File Building
  if [ -z ${LDAP_DOMAIN} ] ; then printf "\n\nLDAP_DOMAIN is not defined!\n"; exit 1; fi;
  if [ -z ${LDAP_HOST} ] ; then printf "\n\nLDAP_HOST is not defined!\n"; exit 1; fi;
  if [ -z ${LDAP_ADMIN_PASSWORD} ] ; then printf "\n\nLDAP_ADMIN_PASSWORD is not defined!\n"; exit 1; fi;

  IFS='.' read -a domain_elems <<< "${LDAP_DOMAIN}"

  suffix=""
  for elem in "${domain_elems[@]}" ; do
      if [ "x${suffix}" = x ] ; then
          suffix="dc=${elem}"
      else
          suffix="${suffix},dc=${elem}"
      fi
  done

  if [ -z ${LDAP_ADMIN_DN} ] ; then
      BASE_DN="dc=$(echo ${LDAP_DOMAIN} | sed 's/^\.//; s/\.$//; s/\./,dc=/g')"
      : ${LDAP_ADMIN:="admin"}
      LDAP_ADMIN_DN="cn=${LDAP_ADMIN},${BASE_DN}"
      echo "** LDAP_ADMIN_DN is not defined and set to '${LDAP_ADMIN_DN}'"
  fi

  if ${LDAP_TLS}; then
      LDAP_SCHEME="ldaps"
      LDAP_COMM_PORT=636
  fi

  
### Write Fusiondirectory Configuration
  cat <<EOF > /etc/fusiondirectory/fusiondirectory.conf
<?xml version="1.0"?>
<conf>
  <!-- Main section **********************************************************
       The main section defines global settings, which might be overridden by
       each location definition inside.

       For more information about the configuration parameters, take a look at
       the FusionDirectory.conf(5) manual page.
  -->
  <main default="${INSTANCE}"
        logging="TRUE"
        displayErrors="FALSE"
        forceSSL="FALSE"
        templateCompileDirectory="/var/spool/fusiondirectory/"
        debugLevel="0"
    >

    <!-- Location definition -->
    <location name="${INSTANCE}"
    >
        <referral URI="${LDAP_SCHEME}://${LDAP_HOST}:${LDAP_COMM_PORT}/${suffix}"
                        adminDn="${LDAP_ADMIN_DN}"
                        adminPassword="${LDAP_ADMIN_PASSWORD}" />
    </location>
  </main>
</conf>
EOF

#### Disable or Enable Argonaut Server from Starting
  if [ "$ENABLE_ARGONAUT" = "FALSE" ] || [ "$ENABLE_ARGONAUT" = "false" ];  then
    s6-svc -d /var/run/s6/services/30-argonaut
  else
    sed -i -e "s/#BASE	dc=example,dc=com/BASE   ${BASE_DN}/g" /etc/openldap/ldap.conf
    sed -i -e "s/#URI	ldap:\/\/ldap.example.com ldap:\/\/ldap-master.example.com:666/URI ${LDAP_SCHEME}:\/\/${LDAP_HOST}:${LDAP_COMM_PORT}/g" /etc/openldap/ldap.conf
    sed -i -e "s/config   = \/etc\/ldap\/ldap.conf/config   = \/etc\/openldap\/ldap.conf/g" /etc/argonaut/argonaut.conf  
    sed -i -e "s/dn       = cn=admin,dc=fusiondirectory,dc=org/dn       = ${LDAP_ADMIN_DN}/g" /etc/argonaut/argonaut.conf	
    sed -i -e "s/password = secret/password = ${LDAP_ADMIN_PASSWORD}/g" /etc/argonaut/argonaut.conf	
    if [ "$LDAP_SCHEME" = "ldaps" ];  then 
    	sed -i -e "s/tls      = off/tls      = on/g" /etc/argonaut/argonaut.conf
    fi
  fi


  chmod 640 /etc/fusiondirectory/fusiondirectory.conf
  chown root:www-data /etc/fusiondirectory/fusiondirectory.conf
  echo 'Yes' | fusiondirectory-setup --set-fd_home=/www/fusiondirectory --check-directories --check-config --update-cache >/dev/null
  fusiondirectory-setup --set-fd_home="/www/fusiondirectory" --set-fd_smarty_dir="/usr/share/php/smarty3/Smarty.class.php" --write-vars >/dev/null
 
  ### Theme Support
  if [ -d /assets/fusiondirectory ] ; then
     echo "Custom HTML Found, Copying over top of Master.."
     cp -R /assets/fusiondirectory/* /www/html/fusiondirectory/
  fi

  mkdir -p /tmp/state
  touch /tmp/state/00-container-initialized