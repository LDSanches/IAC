divert(-1)dnl
include(\`/usr/share/sendmail-cf/m4/cf.m4')dnl
VERSIONID(\`setup for linux')dnl
OSTYPE(\`linux')dnl
define(\`SMART_HOST', \`exccor02ap.corporate.int')dnl
define(\`confDEF_USER_ID', \`\`8:12'')dnl
define(\`confTO_CONNECT', \`1m')dnl
define(\`confTRY_NULL_MX_LIST', \`True')dnl
define(\`confDONT_PROBE_INTERFACES', \`True')dnl
define(\`PROCMAIL_MAILER_PATH', \`/usr/bin/procmail')dnl
define(\`ALIAS_FILE', \`/etc/aliases')dnl
define(\`STATUS_FILE', \`/var/log/mail/statistics')dnl
define(\`UUCP_MAILER_MAX', \`2000000')dnl
define(\`confUSERDB_SPEC', \`/etc/mail/userdb.db')dnl
define(\`confPRIVACY_FLAGS', \`authwarnings,novrfy,noexpn,restrictqrun')dnl
define(\`confAUTH_OPTIONS', \`A')dnl
define(\`confTO_IDENT', \`0')dnl
FEATURE(\`no_default_msa', \`dnl')dnl
FEATURE(\`smrsh', \`/usr/sbin/smrsh')dnl
FEATURE(\`mailertable', \`hash -o /etc/mail/mailertable.db')dnl
FEATURE(\`virtusertable', \`hash -o /etc/mail/virtusertable.db')dnl
FEATURE(redirect)dnl
FEATURE(always_add_domain)dnl
FEATURE(use_cw_file)dnl
FEATURE(use_ct_file)dnl
FEATURE(local_procmail, \`', \`procmail -t -Y -a \$h -d \$u')dnl
FEATURE(\`access_db', \`hash -T<TMPF> -o /etc/mail/access.db')dnl
FEATURE(\`blacklist_recipients')dnl
EXPOSED_USER(\`root')dnl
DAEMON_OPTIONS(\`Port=smtp,Addr=127.0.0.1, Name=MTA')dnl
FEATURE(\`accept_unresolvable_domains')dnl
LOCAL_DOMAIN(\`localhost.localdomain')dnl
MAILER(smtp)dnl
MAILER(procmail)dnl
