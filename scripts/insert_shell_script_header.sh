#!/bin/sh

# insert_shell_script_header.sh: create script description automatically

fullFileName="${1}"

cat << _EOF_ > "${fullFileName}"
#!/bin/sh
#
#===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== 
# Filename:		${fullFileName}
# Description:
# Date:			`date +%F`
# Author:		Li Yang
# Website:		https://liyang85.com
#===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== 


_EOF_

chmod +x "${fullFileName}"

if [[ -x "command -v nvim" ]]; then
	nvim + -c 'startinsert' "${fullFileName}"
else
	vim + -c 'startinsert' "${fullFileName}"
fi
