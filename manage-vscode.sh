#! /usr/bin/bash

#################### Begin Script ####################
# Install the vscode extension multicommands because settings rely on this
code --install-extension ryuta46.multi-command > /dev/null 2>&1
mkdir -p ryuta46.multi-command

# Paths to the vscode settings and keybindings files
VSCODE_SETTINGS_FILE="${HOME}/.config/Code/User/settings.json"
VSCODE_KEYBINDINGS_FILE="${HOME}/.config/Code/User/keybindings.json"

# Temporary files we make to build up the settings and json files
TEMP_SETTINGS_FILE="temp_settings.txt"
TEMP_KEYBINDINGS_FILE="temp_keybindings.txt"

# Prepend for json objects and arrays
echo "{" > ${TEMP_SETTINGS_FILE}
echo "[" > ${TEMP_KEYBINDINGS_FILE}

# Base configuration for settings and keybindings
cat base_settings.txt >> ${TEMP_SETTINGS_FILE}
cat base_keybindings.txt >> ${TEMP_KEYBINDINGS_FILE}

######################################## DRIVING CODE ########################################
for directory in $(ls --classify | grep '.*/$' | sed 's/\/$//'); do
    code --install-extension ${directory} > /dev/null 2>&1
    if [[ -e "${directory}/settings.txt" ]]; then
        echo "${directory}/settings.txt exists"
    fi

    if [[ -e "${directory}/keybindings.txt" ]]; then
        echo "${directory}/keybindings.txt exists"
    fi
done

# Uninstall any extensions which are not present as a directory
for vscode_extension in $(comm -13 <(ls --classify | grep '.*/$' | sed 's/\/$//' | sort) <(code --list-extensions | sort)); do 
    code --uninstall-extension ${vscode_extension}
done
##############################################################################################

# Append for json objects and arrays
echo "}" >> ${TEMP_SETTINGS_FILE}
echo "]" >> ${TEMP_KEYBINDINGS_FILE}

# Replace the current files
cat ${TEMP_SETTINGS_FILE} > ${VSCODE_SETTINGS_FILE}
cat ${TEMP_KEYBINDINGS_FILE} > ${VSCODE_KEYBINDINGS_FILE}

# Remove the temporary files
rm ${TEMP_SETTINGS_FILE} ${TEMP_KEYBINDINGS_FILE}
