#!/bin/bash
#
#
#=====================================================================
#=====================================================================
# Set the following variables to your system needs
# (Detailed instructions below variables)
#=====================================================================

# Username to access the MySQL server e.g. dbuser
USERNAME=vino_spree

# Username to access the MySQL server e.g. password
PASSWORD=estrech0s


# Host name (or IP address) of MySQL server e.g localhost
DBHOST=localhost

# List of DBNAMES for Daily/Weekly Backup e.g. "DB1 DB2 DB3"
DBNAMES="vino_spreelive"

# Backup directory location e.g /backups
BACKUPDIR="/home/vino/backups"

# Directorios a copiar
DIRECTORIES="/home/vino/baseShop"

# Nombre de la máquina
COMPUTER=localhost 

# where to store time of full backup
TIMEDIR=/home/admin/backups/last-full

TAR=/bin/tar # name and locaction of tar

# Mail setup
# What would you like to be mailed to you?
# - log   : send only log file
# - files : send log file and sql files as attachments (see docs)
# - stdout : will simply output the log to the screen if run manually.
# - quiet : Only send logs if an error occurs to the MAILADDR.
MAILCONTENT="files"

# Set the maximum allowed email size in k. (4000 = approx 5MB email [see docs])
MAXATTSIZE="8000"

# Email Address to send mail to? (user@domain.com)
MAILADDR="backup@tapershop.com"


# ============================================================
# === ADVANCED OPTIONS ( Read the doc's below for details )===
#=============================================================

# List of DBBNAMES for Monthly Backups.
MDBNAMES="mysql $DBNAMES"

# List of DBNAMES to EXLUCDE if DBNAMES are set to all (must be in " quotes)
DBEXCLUDE=""

# Include CREATE DATABASE in backup?
CREATE_DATABASE=yes

# Separate backup directory and file for each DB? (yes or no)
SEPDIR=yes

# Which day do you want weekly backups? (1 to 7 where 1 is Monday)
DOWEEKLY=6

# Choose Compression type. (gzip or bzip2)
COMP=gzip

# Compress communications between backup server and MySQL server?
COMMCOMP=no

# Additionally keep a copy of the most recent backup in a seperate directory.
LATEST=no

#  The maximum size of the buffer for client/server communication. e.g. 16MB (maximum is 1GB)
MAX_ALLOWED_PACKET=

#  For connections to localhost. Sometimes the Unix socket file must be specified.
SOCKET=

# Command to run before backups (uncomment to use)
#PREBACKUP="/etc/mysql-backup-pre"

# Command run after backups (uncomment to use)
#POSTBACKUP="/etc/mysql-backup-post"

#=====================================================================
# Options documantation
#=====================================================================
# Set USERNAME and PASSWORD of a user that has at least SELECT permission
# to ALL databases.
#
# Set the DBHOST option to the server you wish to backup, leave the
# default to backup "this server".(to backup multiple servers make
# copies of this file and set the options for that server)
#
# Put in the list of DBNAMES(Databases)to be backed up. If you would like
# to backup ALL DBs on the server set DBNAMES="all".(if set to "all" then
# any new DBs will automatically be backed up without needing to modify
# this backup script when a new DB is created).
#
# If the DB you want to backup has a space in the name replace the space
# with a % e.g. "data base" will become "data%base"
# NOTE: Spaces in DB names may not work correctly when SEPDIR=no.
#
# You can change the backup storage location from /backups to anything
# you like by using the BACKUPDIR setting..
#
# The MAILCONTENT and MAILADDR options and pretty self explanitory, use
# these to have the backup log mailed to you at any email address or multiple
# email addresses in a space seperated list.
# (If you set mail content to "log" you will require access to the "mail" program
# on your server. If you set this to "files" you will have to have mutt installed
# on your server. If you set it to "stdout" it will log to the screen if run from 
# the console or to the cron job owner if run through cron. If you set it to "quiet"
# logs will only be mailed if there are errors reported. )
#
# MAXATTSIZE sets the largest allowed email attachments total (all backup files) you
# want the script to send. This is the size before it is encoded to be sent as an email
# so if your mail server will allow a maximum mail size of 5MB I would suggest setting
# MAXATTSIZE to be 25% smaller than that so a setting of 4000 would probably be fine.
#
# Finally copy automysqlbackup.sh to anywhere on your server and make sure
# to set executable permission. You can also copy the script to
# /etc/cron.daily to have it execute automatically every night or simply
# place a symlink in /etc/cron.daily to the file if you wish to keep it 
# somwhere else.
# NOTE:On Debian copy the file with no extention for it to be run
# by cron e.g just name the file "automysqlbackup"
#
# Thats it..
#
#
# === Advanced options doc's ===
#
# The list of MDBNAMES is the DB's to be backed up only monthly. You should
# always include "mysql" in this list to backup your user/password
# information along with any other DBs that you only feel need to
# be backed up monthly. (if using a hosted server then you should
# probably remove "mysql" as your provider will be backing this up)
# NOTE: If DBNAMES="all" then MDBNAMES has no effect as all DBs will be backed
# up anyway.
#
# If you set DBNAMES="all" you can configure the option DBEXCLUDE. Other
# wise this option will not be used.
# This option can be used if you want to backup all dbs, but you want 
# exclude some of them. (eg. a db is to big).
#
# Set CREATE_DATABASE to "yes" (the default) if you want your SQL-Dump to create
# a database with the same name as the original database when restoring.
# Saying "no" here will allow your to specify the database name you want to
# restore your dump into, making a copy of the database by using the dump
# created with automysqlbackup.
# NOTE: Not used if SEPDIR=no
#
# The SEPDIR option allows you to choose to have all DBs backed up to
# a single file (fast restore of entire server in case of crash) or to
# seperate directories for each DB (each DB can be restored seperately
# in case of single DB corruption or loss).
#
# To set the day of the week that you would like the weekly backup to happen
# set the DOWEEKLY setting, this can be a value from 1 to 7 where 1 is Monday,
# The default is 6 which means that weekly backups are done on a Saturday.
#
# COMP is used to choose the copmression used, options are gzip or bzip2.
# bzip2 will produce slightly smaller files but is more processor intensive so
# may take longer to complete.
#
# COMMCOMP is used to enable or diable mysql client to server compression, so
# it is useful to save bandwidth when backing up a remote MySQL server over
# the network. 
#
# LATEST is to store an additional copy of the latest backup to a standard
# location so it can be downloaded bt thrid party scripts.
#
# If the DB's being backed up make use of large BLOB fields then you may need
# to increase the MAX_ALLOWED_PACKET setting, for example 16MB..
#
# When connecting to localhost as the DB server (DBHOST=localhost) sometimes
# the system can have issues locating the socket file.. This can now be set
# using the SOCKET parameter.. An example may be SOCKET=/private/tmp/mysql.sock
#
# Use PREBACKUP and POSTBACKUP to specify Per and Post backup commands
# or scripts to perform tasks either before or after the backup process.
#
#
#=====================================================================
# Backup Rotation..
#=====================================================================
#
# Daily Backups are rotated weekly..
# Weekly Backups are run by default on Saturday Morning when
# cron.daily scripts are run...Can be changed with DOWEEKLY setting..
# Weekly Backups are rotated on a 5 week cycle..
# Monthly Backups are run on the 1st of the month..
# Monthly Backups are NOT rotated automatically...
# It may be a good idea to copy Monthly backups offline or to another
# server..
#
#=====================================================================
# Please Note!!
#=====================================================================
#
# I take no resposibility for any data loss or corruption when using
# this script..
# This script will not help in the event of a hard drive crash. If a 
# copy of the backup has not be stored offline or on another PC..
# You should copy your backups offline regularly for best protection.
#
# Happy backing up...
#
#=====================================================================
# Restoring
#=====================================================================
# Firstly you will need to uncompress the backup file.
# eg.
# gunzip file.gz (or bunzip2 file.bz2)
#
# Next you will need to use the mysql client to restore the DB from the
# sql file.
# eg.
# mysql --user=username --pass=password --host=dbserver database < /path/file.sql
# or
# mysql --user=username --pass=password --host=dbserver -e "source /path/file.sql" database
#
# NOTE: Make sure you use "<" and not ">" in the above command because
# you are piping the file.sql to mysql and not the other way around.
#
# Lets hope you never have to use this.. :)
#=====================================================================
#=====================================================================
#=====================================================================
#
# Should not need to be modified from here down!!
#
#=====================================================================
#=====================================================================
#=====================================================================
PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/mysql/bin 
DATE=`date +%Y-%m-%d_%Hh%Mm`				# Datestamp e.g 2002-09-21
DOW=`date +%A`							# Day of the week e.g. Monday
DNOW=`date +%u`						# Day number of the week 1 to 7 where 1 represents Monday
DOM=`date +%d`							# Date of the Month e.g. 27
DM=`date +%d%b` 						# Date and Month e.g. 27Sep
M=`date +%B`							# Month e.g January
W=`date +%V`							# Week Number e.g 37
VER=1.0								# Version Number
LOGFILE=$BACKUPDIR/$DBHOST-`date +%N`.log		# Logfile Name
LOGERR=$BACKUPDIR/ERRORS_$DBHOST-`date +%N`.log		# Logfile Name
BACKUPFILES=""
OPT="--quote-names --opt"			# OPT string for use with mysqldump ( see man mysqldump )

# ruta del log de archivos
LOG=$LOGFILE

# Add --compress mysqldump option to $OPT
if [ "$COMMCOMP" = "yes" ];
	then
		OPT="$OPT --compress"
	fi

# Add --compress mysqldump option to $OPT
if [ "$MAX_ALLOWED_PACKET" ];
	then
		OPT="$OPT --max_allowed_packet=$MAX_ALLOWED_PACKET"
	fi
	
echo -e "\n" >> $LOGFILE
echo -e "\n Script de Backup iniciado: `date`" >> $LOGFILE

# Create required directories
if [ ! -e "$BACKUPDIR" ]		# Check Backup Directory exists.
	then
	mkdir -p "$BACKUPDIR"
fi

if [ ! -e "$BACKUPDIR/daily" ]		# Check Daily Directory exists.
	then
	mkdir -p "$BACKUPDIR/daily"
fi

if [ ! -e "$BACKUPDIR/weekly" ]		# Check Weekly Directory exists.
	then
	mkdir -p "$BACKUPDIR/weekly"
fi

if [ ! -e "$BACKUPDIR/monthly" ]	# Check Monthly Directory exists.
	then
	mkdir -p "$BACKUPDIR/monthly"
fi

if [ "$LATEST" = "yes" ]
then
	if [ ! -e "$BACKUPDIR/latest" ]	# Check Latest Directory exists.
	then
		mkdir -p "$BACKUPDIR/latest"
	fi
eval rm -fv "$BACKUPDIR/latest/*"
fi

# IO redirection for logging.
touch $LOGFILE
exec 6>&1           # Link file descriptor #6 with stdout.
                    # Saves stdout.
exec > $LOGFILE     # stdout replaced with file $LOGFILE.
touch $LOGERR
exec 7>&2           # Link file descriptor #7 with stderr.
                    # Saves stderr.
exec 2> $LOGERR     # stderr replaced with file $LOGERR.


# Functions

# Database dump function
dbdump () {
mysqldump --user=$USERNAME --password=$PASSWORD --host=$DBHOST $OPT $1 > $2
return 0
}

# Compression function plus latest copy
SUFFIX=""
compression () {
if [ "$COMP" = "gzip" ]; then
	gzip -f "$1"
	echo
	echo Backup Information for "$1"
	gzip -l "$1.gz"
	SUFFIX=".gz"
elif [ "$COMP" = "bzip2" ]; then
	echo Compression information for "$1.bz2"
	bzip2 -f -v $1 2>&1
	SUFFIX=".bz2"
else
	echo "No compression option set, check advanced settings"
fi
if [ "$LATEST" = "yes" ]; then
	cp $1$SUFFIX "$BACKUPDIR/latest/"
fi	
return 0
}


# Run command before we begin
if [ "$PREBACKUP" ]
	then
	echo ======================================================================
	echo "Prebackup command output."
	echo
	eval $PREBACKUP
	echo
	echo ======================================================================
	echo
fi


if [ "$SEPDIR" = "yes" ]; then # Check if CREATE DATABSE should be included in Dump
	if [ "$CREATE_DATABASE" = "no" ]; then
		OPT="$OPT --no-create-db"
	else
		OPT="$OPT --databases"
	fi
else
	OPT="$OPT --databases"
fi

# Hostname for LOG information
if [ "$DBHOST" = "localhost" ]; then
	HOST=`hostname`
	if [ "$SOCKET" ]; then
		OPT="$OPT --socket=$SOCKET"
	fi
else
	HOST=$DBHOST
fi

# If backing up all DBs on the server
if [ "$DBNAMES" = "all" ]; then
        DBNAMES="`mysql --user=$USERNAME --password=$PASSWORD --host=$DBHOST --batch --skip-column-names -e "show databases"| sed 's/ /%/g'`"

	# If DBs are excluded
	for exclude in $DBEXCLUDE
	do
		DBNAMES=`echo $DBNAMES | sed "s/\b$exclude\b//g"`
	done

        MDBNAMES=$DBNAMES
fi
	
echo ======================================================================
echo AutoMySQLBackup VER $VER
echo http://sourceforge.net/projects/automysqlbackup/
echo 
echo Backup of Database Server - $HOST
echo ======================================================================

# Test is seperate DB backups are required
if [ "$SEPDIR" = "yes" ]; then
echo -e "\n Backup de BBDD: `date`" >> $LOGFILE
echo -e "======================================================================"  >> $LOGFILE
	# Monthly Full Backup of all Databases
	if [ $DOM = "01" ]; then
		for MDB in $MDBNAMES
		do
 
			 # Prepare $DB for using
		        MDB="`echo $MDB | sed 's/%/ /g'`"

			if [ ! -e "$BACKUPDIR/monthly/$MDB" ]		# Check Monthly DB Directory exists.
			then
				mkdir -p "$BACKUPDIR/monthly/$MDB"
			fi
			echo -e "Backup mensual de '$MDB'" >> $LOGFILE
			echo
				dbdump "$MDB" "$BACKUPDIR/monthly/$MDB/${MDB}_$DATE.$M.$MDB.sql"
				compression "$BACKUPDIR/monthly/$MDB/${MDB}_$DATE.$M.$MDB.sql"
				BACKUPFILES="$BACKUPFILES $BACKUPDIR/monthly/$MDB/${MDB}_$DATE.$M.$MDB.sql$SUFFIX"
		done
	fi

	for DB in $DBNAMES
	do
	# Prepare $DB for using
	DB="`echo $DB | sed 's/%/ /g'`"
	
	# Create Seperate directory for each DB
	if [ ! -e "$BACKUPDIR/daily/$DB" ]		# Check Daily DB Directory exists.
		then
		mkdir -p "$BACKUPDIR/daily/$DB"
	fi
	
	if [ ! -e "$BACKUPDIR/weekly/$DB" ]		# Check Weekly DB Directory exists.
		then
		mkdir -p "$BACKUPDIR/weekly/$DB"
	fi
	
	# Weekly Backup
	if [ $DNOW = $DOWEEKLY ]; then
		echo -e "Backup semanal de '$DB'" >> $LOGFILE
		echo -e "Rotado de los backups de 5 semanas" >> $LOGFILE
			if [ "$W" -le 05 ];then
				REMW=`expr 48 + $W`
			elif [ "$W" -lt 15 ];then
				REMW=0`expr $W - 5`
			else
				REMW=`expr $W - 5`
			fi
		eval rm -fv "$BACKUPDIR/weekly/$DB_week.$REMW.*" 
		echo
			dbdump "$DB" "$BACKUPDIR/weekly/$DB/${DB}_week.$W.$DATE.sql" >> $LOGFILE
			compression "$BACKUPDIR/weekly/$DB/${DB}_week.$W.$DATE.sql" >> $LOGFILE
			BACKUPFILES="$BACKUPFILES $BACKUPDIR/weekly/$DB/${DB}_week.$W.$DATE.sql$SUFFIX" >> $LOGFILE
	
	# Daily Backup
	else
		echo -e "Backup diario de '$DB'" >> $LOGFILE
		echo -e "Rotado del backup de la ultima semana" >> $LOGFILE
		eval rm -fv "$BACKUPDIR/daily/$DB/*.$DOW.sql.*" 
		echo
			dbdump "$DB" "$BACKUPDIR/daily/$DB/${DB}_$DATE.$DOW.sql" >> $LOGFILE
			compression "$BACKUPDIR/daily/$DB/${DB}_$DATE.$DOW.sql" >> $LOGFILE
			BACKUPFILES="$BACKUPFILES $BACKUPDIR/daily/$DB/${DB}_$DATE.$DOW.sql$SUFFIX" >> $LOGFILE
	fi
	done
echo -e "Fin del backup de BBDD `date`" >> $LOGFILE
echo -e "======================================================================" >> $LOGFILE


else # One backup file for all DBs
echo -e "Inicio del Backup de todas las BBDD `date`" >> $LOGFILE
	# Monthly Full Backup of all Databases
	if [ $DOM = "01" ]; then
		echo -e "Backup completo mensual de  '$MDBNAMES'" >> $LOGFILE
		echo
			dbdump "$MDBNAMES" "$BACKUPDIR/monthly/$DATE.$M.all-databases.sql" >> $LOGFILE
			compression "$BACKUPDIR/monthly/$DATE.$M.all-databases.sql" >> $LOGFILE
			BACKUPFILES="$BACKUPFILES $BACKUPDIR/monthly/$DATE.$M.all-databases.sql$SUFFIX" >> $LOGFILE
	fi

	# Weekly Backup
	if [ $DNOW = $DOWEEKLY ]; then
		echo -e "Backup semanal de todas las BBDD '$DBNAMES'" >> $LOGFILE
		echo -e "Rotado de 5 semanas de backups" >> $LOGFILE
			if [ "$W" -le 05 ];then
				REMW=`expr 48 + $W`
			elif [ "$W" -lt 15 ];then
				REMW=0`expr $W - 5`
			else
				REMW=`expr $W - 5`
			fi
		eval rm -fv "$BACKUPDIR/weekly/week.$REMW.*" 
			dbdump "$DBNAMES" "$BACKUPDIR/weekly/week.$W.$DATE.sql" >> $LOGFILE
			compression "$BACKUPDIR/weekly/week.$W.$DATE.sql"  >> $LOGFILE
			BACKUPFILES="$BACKUPFILES $BACKUPDIR/weekly/week.$W.$DATE.sql$SUFFIX"  >> $LOGFILE
		
	# Daily Backup
	else
		echo -e "Backup diario de todas las BBDD '$DBNAMES'" >> $LOGFILE
		echo -e "Rotado del backup de la última semana" >> $LOGFILE
		eval rm -fv "$BACKUPDIR/daily/*.$DOW.sql.*" 
		echo
			dbdump "$DBNAMES" "$BACKUPDIR/daily/$DATE.$DOW.sql" >> $LOGFILE
			compression "$BACKUPDIR/daily/$DATE.$DOW.sql" >> $LOGFILE
			BACKUPFILES="$BACKUPFILES $BACKUPDIR/daily/$DATE.$DOW.sql$SUFFIX" >> $LOGFILE
	fi
echo -e "Fin del Backup de BBDD `date`" >> $LOGFILE
fi
echo -e "Espacio total utilizado para Backups:" >> $LOGFILE
echo Size - Location >> $LOGFILE
echo `du -hs "$BACKUPDIR"` >> $LOGFILE


# Añadido para copia de ficheros
echo -e "========================================================" >> $LOGFILE

if [ ! -e "$TIMEDIR/$COMPUTER-full-date" ]		# Comprobación inicial 
	then
	date +%d%b > $TIMEDIR/$COMPUTER-full-date
fi

echo -e "\nComenzando el copiado de ficheros" >> $LOGFILE
if [ $DOM = "01" ]; then
NEWER=""
echo -e "\nIniciado mensual completo... " >> $LOGFILE
tar $NEWER -zcf $BACKUPDIR/$COMPUTER-$DM.tar.gz $DIRECTORIES
echo -e "\nMensual completo terminado " >> $LOGFILE
fi

# Copia completa semanal
if [ $DOW = "Sun" ]; then
NEWER=""
NOW=`date +%d-%b`

echo -e "\nIniciado semanal completo... " >> $LOGFILE
# Actualizando fecha de copia completa
echo $NOW > $TIMEDIR/$COMPUTER-full-date
tar $NEWER -zcf $BACKUPDIR/$COMPUTER-$DOW.tar.gz $DIRECTORIES
echo -e "\nFinalizado semanal completo" >> $LOGFILE

# Copia incremental - sobresescribe las últimas semanas
else

# Obtener fecha para backup completo
echo -e "\nIniciado incremental diario... " >> $LOGFILE
NEWER="--newer `cat $TIMEDIR/$COMPUTER-full-date`"
tar $NEWER -zcf $BACKUPDIR/$COMPUTER-$DOW.tar.gz $DIRECTORIES
echo -e "\nFinalizado incremental diario " >> $LOGFILE
fi

echo -e "\n --- Backup  de ficheros finalizado --- " >> $LOGFILE


# Run command when we're done
if [ "$POSTBACKUP" ]
	then
	echo ======================================================================
	echo "Postbackup command output."
	echo
	eval $POSTBACKUP
	echo
	echo ======================================================================
fi

#Clean up IO redirection
exec 1>&6 6>&-      # Restore stdout and close file descriptor #6.
exec 1>&7 7>&-      # Restore stdout and close file descriptor #7.

if [ "$MAILCONTENT" = "files" ]
then
	if [ -s "$LOGERR" ]
	then
		# Include error log if is larger than zero.
		BACKUPFILES="$BACKUPFILES $LOGERR"
		ERRORNOTE="WARNING: Error Reported - "
	fi
	#Get backup size
	ATTSIZE=`du -c $BACKUPFILES | grep "[[:digit:][:space:]]total$" |sed s/\s*total//`
	if [ $MAXATTSIZE -ge $ATTSIZE ]
	then
		BACKUPFILES=`echo "$BACKUPFILES" | sed -e "s# # -a #g"`	#enable multiple attachments
		mutt -s "$ERRORNOTE MySQL Backup Log and SQL Files for $HOST - $DATE" $BACKUPFILES $MAILADDR < $LOGFILE		#send via mutt
	else
		cat "$LOGFILE" | mail -s "WARNING! - MySQL Backup exceeds set maximum attachment size on $HOST - $DATE" $MAILADDR
	fi
elif [ "$MAILCONTENT" = "log" ]
then
	cat "$LOGFILE" | mail -s "MySQL Backup Log for $HOST - $DATE" $MAILADDR
	if [ -s "$LOGERR" ]
		then
			cat "$LOGERR" | mail -s "ERRORS REPORTED: MySQL Backup error Log for $HOST - $DATE" $MAILADDR
	fi	
elif [ "$MAILCONTENT" = "quiet" ]
then
	if [ -s "$LOGERR" ]
		then
			cat "$LOGERR" | mail -s "ERRORS REPORTED: MySQL Backup error Log for $HOST - $DATE" $MAILADDR
			cat "$LOGFILE" | mail -s "MySQL Backup Log for $HOST - $DATE" $MAILADDR
	fi
else
	if [ -s "$LOGERR" ]
		then
			cat "$LOGFILE"
			echo
			echo "###### WARNING ######"
			echo "Errors reported during AutoMySQLBackup execution.. Backup failed"
			echo "Error log below.."
			cat "$LOGERR"
	else
		cat "$LOGFILE"
	fi	
fi

if [ -s "$LOGERR" ]
	then
		STATUS=1
	else
		STATUS=0
fi

# Clean up Logfile
eval rm -f "$LOGFILE"
eval rm -f "$LOGERR"

exit $STATUS
