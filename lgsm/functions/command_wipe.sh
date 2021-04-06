#!/bin/bash
# LinuxGSM command_backup.sh module
# Author: Daniel Gibbs
# Contributors: http://linuxgsm.com/contrib
# Website: https://linuxgsm.com
# Description: Wipes server data, useful after updates for some games like Rust.

commandname="WIPE"
commandaction="Wiping"
functionselfname="$(basename "$(readlink -f "${BASH_SOURCE[0]}")")"
fn_firstcommand_set

# Provides an exit code upon error.
fn_wipe_exit_code(){
	exitcode=$?
	if [ "${exitcode}" != 0 ]; then
		fn_print_fail_eol_nl
		core_exit.sh
	else
		fn_print_ok_eol_nl
	fi
}

# Removes files to wipe server.
<<<<<<< HEAD
fn_wipe_server_files(){
=======
fn_wipe_files(){
>>>>>>> master
	fn_print_start_nl "${wipetype}"
	fn_script_log_info "${wipetype}"

	# Remove Map files
	if [ -n "${serverwipe}" ]||[ -n "${mapwipe}" ]; then
		if [ -n "$(find "${serveridentitydir}" -type f -name "*.map")" ]; then
			echo -en "removing .map file(s)..."
			fn_script_log_info "removing *.map file(s)"
			fn_sleep_time
			find "${serveridentitydir:?}" -type f -name "*.map" -printf "%f\n" >>  "${lgsmlog}"
			find "${serveridentitydir:?}" -type f -name "*.map" -delete | tee -a "${lgsmlog}"
			fn_wipe_exit_code
		else
<<<<<<< HEAD
			echo -e "no *.map file(s) to remove"
			fn_sleep_time
			fn_script_log_pass "no .map file(s) to remove"
		fi
	fi
	# Remove Save files.
	if [ -n "${serverwipe}" ]||[ -n "${mapwipe}" ]; then
		if [ -n "$(find "${serveridentitydir}" -type f -name "*.sav*")" ]; then
			echo -en "removing .sav file(s)..."
			fn_script_log_info "removing .sav file(s)"
			fn_sleep_time
=======
			echo -e "no .map file(s) to remove"
			fn_sleep_time
			fn_script_log_pass "no .map file(s) to remove"
		fi
	fi
	# Remove Save files.
	if [ -n "${serverwipe}" ]||[ -n "${mapwipe}" ]; then
		if [ -n "$(find "${serveridentitydir}" -type f -name "*.sav*")" ]; then
			echo -en "removing .sav file(s)..."
			fn_script_log_info "removing .sav file(s)"
			fn_sleep_time
>>>>>>> master
			find "${serveridentitydir:?}" -type f -name "*.sav*" -printf "%f\n" >>  "${lgsmlog}"
			find "${serveridentitydir:?}" -type f -name "*.sav*" -delete
			fn_wipe_exit_code
		else
			echo -e "no .sav file(s) to remove"
			fn_script_log_pass "no .sav file(s) to remove"
			fn_sleep_time
		fi
	fi
	# Remove db files for full wipe.
	# Excluding player.tokens.db for Rust+.
<<<<<<< HEAD
	if [ -n "${serverwipe}" ]||[ -n "${playerwipe}" ]; then
		if [ -n "$(find "${serveridentitydir}" -type f -name "*.db")" ]; then
=======
	if [ -n "${serverwipe}" ]; then
		if [ -n "$(find "${serveridentitydir}" -type f ! -name 'player.tokens.db' -name "*.db")" ]; then
>>>>>>> master
			echo -en "removing .db file(s)..."
			fn_script_log_info "removing .db file(s)"
			fn_sleep_time
			find "${serveridentitydir:?}" -type f ! -name 'player.tokens.db' -name "*.db" -printf "%f\n" >> "${lgsmlog}"
			find "${serveridentitydir:?}" -type f ! -name 'player.tokens.db' -name "*.db" -delete
			fn_wipe_exit_code
		else
			echo -e "no .db file(s) to remove"
			fn_sleep_time
			fn_script_log_pass "no .db file(s) to remove"
		fi
	fi
}

fn_map_wipe_warning(){
<<<<<<< HEAD
	fn_print_warn "Map wipe will reset the map data and keep player data"
	fn_script_log_warn "Map wipe will reset the map data and keep player data"
	totalseconds=3
	for seconds in {3..1}; do
		fn_print_warn "Map wipe will reset the map data and keep player data: ${totalseconds}"
=======
	fn_print_warn "Map wipe will reset the map data and keep blueprint data"
	fn_script_log_warn "Map wipe will reset the map data and keep blueprint data"
	totalseconds=3
	for seconds in {3..1}; do
		fn_print_warn "Map wipe will reset the map data and keep blueprint data: ${totalseconds}"
>>>>>>> master
		totalseconds=$((totalseconds - 1))
		sleep 1
		if [ "${seconds}" == "0" ]; then
			break
		fi
	done
<<<<<<< HEAD
	fn_print_warn_nl "Map wipe will reset the map data and keep player data"
}

fn_player_wipe_warning(){
	fn_print_warn "Player wipe will keep the map data and remove player data"
	fn_script_log_warn "Player wipe will keep the map data and remove player data"
	totalseconds=3
	for seconds in {3..1}; do
		fn_print_warn "Player wipe will keep the map data and remove player data: ${totalseconds}"
=======
	fn_print_warn_nl "Map wipe will reset the map data and keep blueprint data"
}

fn_full_wipe_warning(){
	fn_print_warn "Server wipe will reset the map data and remove blueprint data"
	fn_script_log_warn "Server wipe will reset the map data and remove blueprint data"
	totalseconds=3
	for seconds in {3..1}; do
		fn_print_warn "Server wipe will reset the map data and remove blueprint data: ${totalseconds}"
>>>>>>> master
		totalseconds=$((totalseconds - 1))
		sleep 1
		if [ "${seconds}" == "0" ]; then
			break
		fi
	done
<<<<<<< HEAD
	fn_print_warn_nl "Player wipe will keep the map data and remove player data"
}

fn_server_wipe_warning(){
	fn_print_warn "Server wipe will reset the map data and remove player data"
	fn_script_log_warn "Server wipe will reset the map data and remove player data"
	totalseconds=3
	for seconds in {3..1}; do
		fn_print_warn "Server wipe will reset the map data and remove player data: ${totalseconds}"
		totalseconds=$((totalseconds - 1))
		sleep 1
		if [ "${seconds}" == "0" ]; then
			break
		fi
	done
	fn_print_warn_nl "Server wipe will reset the map data and remove player data"
}

# Will change the seed everytime the wipe is run, if the seed is not defined by the user.
fn_wipe_random_seed(){
	if [ -f "${datadir}/${selfname}-seed.txt" ]&&[ -n "${serverwipe}" ]||[ -n "${mapwipe}" ]; then
		shuf -i 1-2147483647 -n 1 > "${datadir}/${selfname}-seed.txt"
		seed=$(cat "${datadir}/${selfname}-seed.txt")
=======
	fn_print_warn_nl "Server wipe will reset the map data and remove blueprint data"
}

# Will change the seed if the seed is not defined by the user.
fn_wipe_random_seed(){
	if [ -f "${datadir}/${selfname}-seed.txt" ]&&[ -n "${randomseed}" ]; then
		shuf -i 1-2147483647 -n 1 > "${datadir}/${selfname}-seed.txt"
		seed=$(cat "${datadir}/${selfname}-seed.txt")
		randomseed=1
>>>>>>> master
		echo -en "generating new random seed (${cyan}${seed}${default})..."
		fn_script_log_pass "generating new random seed (${cyan}${seed}${default})"
		fn_sleep_time
		fn_print_ok_eol_nl
	fi
}

<<<<<<< HEAD
# Summary of what wipe is going to do
fn_wipe_details(){
	fn_print_information_nl "Wipe doe not remove Rust+ data."
=======
# A summary of what wipe is going to do.
fn_wipe_details(){
	fn_print_information_nl "Wipe does not remove Rust+ data."
>>>>>>> master
	echo -en "* Wipe map data: "
	if [ -n "${serverwipe}" ]||[ -n "${mapwipe}" ]; then
		fn_print_yes_eol_nl
	else
		fn_print_no_eol_nl
	fi

<<<<<<< HEAD
	echo -en "* Wipe player data: "
	if [ -n "${serverwipe}" ]||[ -n "${playerwipe}" ]; then
=======
	echo -en "* Wipe blueprint data: "
	if [ -n "${serverwipe}" ]; then
>>>>>>> master
		fn_print_yes_eol_nl
	else
		fn_print_no_eol_nl
	fi

<<<<<<< HEAD
	echo -en "* Change seed: "
	if [ -n "${randomseed}" ]&&[ -n "${serverwipe}" ]||[ -n "${mapwipe}" ]; then
=======
	echo -en "* Change Procedural Map seed: "
	if [ -n "${randomseed}" ]; then
>>>>>>> master
		fn_print_yes_eol_nl
	else
		fn_print_no_eol_nl
	fi
}

fn_print_dots ""
check.sh
fix_rust.sh

# Check if there is something to wipe.
<<<<<<< HEAD
if [ -n "$(find "${serveridentitydir}" -type f -name "*.sav*")" ]||[ -n "$(find "${serveridentitydir}" -type f -name "Log.*.txt")" ]||[ -n "$(find "${serveridentitydir}" -type f -name "*.db")" ]; then
	if [ -n "${serverwipe}" ]; then
		wipetype="Server wipe"
		fn_server_wipe_warning
=======
if [ -n "$(find "${serveridentitydir}" -type f -name "*.map")" ]||[ -n "$(find "${serveridentitydir}" -type f -name "*.sav*")" ]&&[ -n "$(find "${serveridentitydir}" -type f ! -name 'player.tokens.db' -name "*.db")" ]; then
	if [ -n "${serverwipe}" ]; then
		wipetype="Full wipe"
		fn_full_wipe_warning
>>>>>>> master
		fn_wipe_details
	elif [ -n "${mapwipe}" ]; then
		wipetype="Map wipe"
		fn_map_wipe_warning
		fn_wipe_details
<<<<<<< HEAD
	elif [ -n "${playerwipe}" ]; then
		wipetype="Player wipe"
		fn_player_wipe_warning
		fn_wipe_details
=======
>>>>>>> master
	fi
	check_status.sh
	if [ "${status}" != "0" ]; then
		fn_print_restart_warning
		exitbypass=1
		command_stop.sh
		fn_firstcommand_reset
<<<<<<< HEAD
		fn_wipe_server_files
=======
		fn_wipe_files
>>>>>>> master
		fn_wipe_random_seed
		fn_print_complete_nl "${wipetype}"
		fn_script_log_pass "${wipetype}"
		exitbypass=1
		command_start.sh
		fn_firstcommand_reset
	else
<<<<<<< HEAD
		fn_wipe_server_files
=======
		fn_wipe_files
>>>>>>> master
		fn_wipe_random_seed
		fn_print_complete_nl "${wipetype}"
		fn_script_log_pass "${wipetype}"
	fi
else
	fn_print_ok_nl "Wipe not required"
	fn_script_log_pass "Wipe not required"
fi
core_exit.sh
