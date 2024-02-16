# Context

In vscode there are three main things I tend to be concerned with to set up my environment. These things are:

1. The `settings.json` file: This is a file containing a `json` object which stores your settings. For example, if you put the following into `settings.json` it will prevent the minimap from being displayed:

   ```
   {
       "editor.minimap.autohide": true
   }
   ```

1. The `keybindings.json` file: This is a file containing an array of `json` objects which stores the various keybindings you want to map. For example if you put the following into `keybindings.json` it will toggle the terminal when you press the key chord `ctrl+t`:
   ```
   [
       {
           "key": "ctrl+t",
           "command": "workbench.action.terminal.toggleTerminal"
       }
   ]
   ```
1. The extensions which are installed on vscode. We will use the command `code --install-extension <extension ID>` to install extension.

# Overview

This repo has the script `manage-vscode.sh` which automates the installation of:

- Extensions
- Settings
- Keybindings

This script is destructive in the sense that it will destroy any settings and keybindings you have before. We reccomend to manage everything by code (so if you're using this script and method to manage everything, only use this script and method).

This installation is meant for ubuntu linux where `Bash` was the main shell being used.

# Prerequisites

Ensure that you have the following installed:

- `code` command for vscode. To install this go to the command pallete (`ctrl+shift+p`) and type in `Shell Command: Install 'code' command in PATH`.
- `Hack Nerd Font`. To install this go to the [nerd font repo](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Hack/Regular) and download the `HackNerdFontMono-Regular.ttf` file. Put this font file in the `~/.local/share/fonts/` folder.

# Summary of usage

## Applying the changes

- Change directory into the repo containing the script `manage-vscode.sh`. This step is important because we use relative pathing for scripting.
- To run the script type in the command `./manage-vscode.sh`.
  - Make sure that you change the variables `VSCODE_SETTINGS_FILE` and `VSCODE_KEYBINDINGS_FILE` to include the paths of of your settings and keybindings!

## Adding a new Extension, Setting and Keybindings combination

- To add your own `extension`, `settings` and `keybindings` combination:
  1. Create a new folder in the same working directory as `manage-vscode.sh`. The name of the folder must be the `Extension ID` of the extension you want to install.
  1. [Optional Step] Create `settings.txt` and `keybindings.txt` file in the folder where:
     - The `settings.txt` file is almost a json object-- we exclude the `{}`.
     - The `keybindings.txt` file is almost an array of json objects-- we exclude the `[]`.
     - We do this because we use the `cat` command to append files together (`jq` doesn't handle comments).
     - If you choose not to create `settings.txt` or `keybindings.txt` this will just not install `settings` or `keybindings` for that extension. That is, if you just have an empty directory with the name being the extension ID, the effect is to just install the extension. We add an empty file (`buffer.txt`) to empty directories so that git will recognise the directories. Once the directory is cloned, `buffer.txt` can be deleted.
  1. The following is a quick diagram of how it may look to add some extensions on. We see:
     - That in each directory you either have `settings.txt`, `keybindings.txt` or `buffer.txt` (for empty directories. This could be deleted but then you cannot upload this to `github`):
     - The files `base_settings.txt` and `base_keybindings.txt` are text files which are initally added without the help of extensions. Think of these as your "base" vscode layer.
     ```
     .
     ├── aaron-bond.better-comments
     │   └── settings.txt
     ├── base_keybindings.txt
     ├── base_settings.txt
     ├── esbenp.prettier-vscode
     │   └── settings.txt
     ├── Llam4u.nerdtree
     │   ├── keybindings.txt
     │   └── settings.txt
     ├── manage-vscode.sh
     ├── ms-azure-devops.azure-pipelines
     │   └── buffer.txt
     ├── ms-vscode.PowerShell
     │   └── settings.txt
     ├── ms-vscode-remote.remote-containers
     │   └── buffer.txt
     ├── naumovs.color-highlight
     │   └── buffer.txt
     ├── README.md
     ├── ryuta46.multi-command
     │   └── buffer.txt
     └── vscodevim.vim
         ├── keybindings.txt
         └── settings.txt
     ```
