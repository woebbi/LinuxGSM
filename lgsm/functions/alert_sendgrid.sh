#!/bin/bash
# LinuxGSM alert_sendgrid.sh function
# Author: Daniel Gibbs
# Website: https://linuxgsm.com
# Description: Sends SendGrid Email alert.

functionselfname="$(basename "$(readlink -f "${BASH_SOURCE[0]}")")"

fn_print_dots "Sending Email alert: SendGrid: ${sendgridemail}"

# Prepare the recipe
data='{
		"personalizations": [{
			"to": [{ "email": "'"${sendgridemail}"'" }],
		}],
		"subject": "'"${alertemoji} ${alertsubject} ${alertemoji}"'",
		"from": {
				"email": "'"${sendgridemailfrom}"'",
				"name": "'"LinuxGSM"'"
		},
		"content": [{
				"type": "text/plain",
				"value": "'$(cat "${alertlog}" | sed ':a;N;$!ba;s/\n/\\n/g')'"
		}]
}';

# Shoot the email
sendgridsend=$(curl -s -X "POST" "https://api.sendgrid.com/v3/mail/send" \
		-H "Authorization: Bearer ${sendgridtoken}" \
		-H "Content-Type: application/json" \
		-d "${data}")

if [ -z "${sendgridsend}" ]; then
	fn_print_fail_nl "Sending Email alert: SendGrid: ${sendgridemail}"
	fn_script_log_fatal "Sending Email alert: SendGrid: ${sendgridemaill}"
else
	fn_print_ok_nl "Sending Email alert: SendGrid: ${sendgridemail}"
	fn_script_log_pass "Sending Email alert: SendGrid: ${sendgridemail}"
fi
