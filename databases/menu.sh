#!/bin/bash
set -e

if ! [ -x "$(command -v dialog)" ]; then
	echo "dialog not installed"
	exit 1
fi

composeCall="docker compose"

function menu() {
	height=15
	width=40
	choice_height=4
	options=("$@")

	choice=$(dialog --clear \
                	--backtitle "$backtitle" \
                	--title "$title" \
                	--menu "$menu" \
                	$height $width $choice_height \
               		"${options[@]}" \
                	2>&1 >/dev/tty)

	if [[ -z "$choice" ]]; then
		echo "invalid option"
		exit 1
	fi

	echo $choice
}

function inputMenu() {
	height=15
	width=40

	user_input=$(dialog --clear \
										  --title "$1" \
											--inputbox "$2" \
											$height $width \
											2>&1 >/dev/tty)
	echo "$user_input"
}

function menuActions() {
	# Declare an array
	array=(Up_Database ""
				 Down_Database ""
				 Create_Database ""
				 Drop_Database ""
				 Backup_Database ""
				 Restore_Database "")

	# Call the function and pass an argument of an array
	declare title="Actions Database"
	declare menu="What action do you want?"

	choice=$(menu "${array[@]}")
	echo $choice
}

function menuDatabase() {
	# Declare an array
	array=(oracle ""
				 postgresql "" 
				 sqlserver "")

	# Call the function and pass an argument of an array
	declare title="Database Type"
	declare menu="Which database do you want to use?"

	choice=$(menu "${array[@]}")
	echo $choice
}

function menuOracleVersions() {
	array=(11gR2 "" 
				 12 ""
				 18 "" 
				 19 "" 
				 21 "")

	declare title="Oracle Database Version"
	declare menu="Which version of the Oracle database do you want to use?"

	choice=$(menu "${array[@]}")
	echo $choice
}

function menuPostgresqlVersions() {
	array=(10 "" 
				 12 ""
				 14 "")

	declare title="PostgreSQL Database Version"
	declare menu="Which version of the postgresql database do you want to use?"

	choice=$(menu "${array[@]}")
	echo $choice
}

function menuSQLServerVersions() {
	array=(17 ""
				 19 "" 
				 22 "")

	declare title="SQLServer Database Version"
	declare menu="Which version of the SQL Server database do you want to use?"

	choice=$(menu "${array[@]}")
	echo $choice
}

function upDatabase() {
	mkdir -p $dbChoice/$verChoice/{data,containers,backup,restore}
	sudo chmod 777 -R $dbChoice/$verChoice

	$composeCall -f "$dbChoice/$verChoice/docker-compose.yml" up -d
}

function downDatabase() {
	$composeCall -f "$dbChoice/$verChoice/docker-compose.yml" down
}

function dropDatabaseOracle() {
	echo "drop"
}

function dropDatabasePostgresql() {
	echo "drop"
}

function dropDatabaseSQLServer() {
	echo "drop"
}

function dropDatabase() {
	upDatabase
	
	case "$dbChoice" in
	"oracle")
		dropDatabaseOracle
		;;
	"postgresql")
		dropDatabasePostgresql
		;;
	"sqlserver")
		dropDatabaseSQLServer
		;;
esac
}

function createDatabaseOracle() {
	service_name=$(inputMenu "Oracle info" "Enter the desired service name:")
	tablespace_data=$(inputMenu "" "Oracle info" "Enter the desired tablespace_data:")
	tablespace_indexes=$(inputMenu "" "Oracle info" "Enter the desired tablespace_indexes:")
	username=$(inputMenu "" "Oracle info" "Enter the desired username:")
	password=$(inputMenu "" "Oracle info" "Enter the desired password:")
	port=$(inputMenu "" "Oracle info" "Enter the desired port:")
	server=$(inputMenu "" "Oracle info" "Enter the desired server:")
}

function createDatabasePostgresql() {
	echo "create"
}

function createDatabaseSQLServer() {
	echo "create"
}

function createDatabase() {
	#upDatabase
	
	case "$dbChoice" in
	"oracle")
		createDatabaseOracle
		;;
	"postgresql")
		createDatabasePostgresql
		;;
	"sqlserver")
		createDatabaseSQLServer
		;;
esac
}

function backupDatabase() {
	upDatabase
	echo "backup"
}

function restoreDatabase() {
	upDatabase
	echo "restore"
}

actionChoice=$(menuActions)
dbChoice=$(menuDatabase)

case "$dbChoice" in
	"oracle")
		verChoice=$(menuOracleVersions)
		;;
	"postgresql")
		verChoice=$(menuPostgresqlVersions)
		;;
	"sqlserver")
		verChoice=$(menuSQLServerVersions)
		;;
esac

clear
echo " -- > [ action: $actionChoice ] [ database: $dbChoice ] [ version: $verChoice ] < --"

case "$actionChoice" in
	"Up_Database")
		upDatabase
	;;
	"Down_Database")
		downDatabase
	;;
	"Create_Database")
		createDatabase
	;;
	"Drop_Database")
		dropDatabase
	;;
	"Backup_Database")
		backupDatabase
	;;
	"Restore_Database")
		restoreDatabase
	;;
esac