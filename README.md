# commerce-rework-sw-project
Local development environment for the commerce-rework-sw-project project

**TLDR;**
For Windows devs, see the "Before using this repository" section

**Folder structure**

.devcontainer: A git submodule that:

* Offers a containerized, VSCode-ready environment for running your app
* Is added as git submodule, `git submodule add -b master git@github.com:iqual-ch/devcontainer-runtime.git .devcontainer && git submodule init`
* Can be "frozen" to a specific commit (or tag) in order to provide basic dependency management
* Can be used to track the latest state of a specific branch

.vscode: A VSCode workspace folder, specific to the software project managed in this repository


@see https://www.vogella.com/tutorials/GitSubmodules/article.html for further info about using submodules in GIT

**Before using this repository**

N.B.: These instructions are for developers working on Windows 10 with VSCode

1. Make sure you have installed Remote-Containers and Remote-WSL for VS Code. (@see installation instructions here https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers, resp. https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl)
2. You will need to install a linux distro from the App store in you don't have one already, Debian should be more than enough; after installing it you need to do the folowing:
    1. Make sure you enable WSL2 support for your distro (Docker Desktop > Settings > Resources > WSL Integration)
    2. Start your distro (you will get a terminal) and run the following:
        1. `sudo apt-get update`
        2. `sudo apt-get install socat git ssh wget`
        3. `mkdir -p .ssh && touch $HOME/.ssh/ssh-agent`
        4.
            ```
            echo 'if [ -z "$SSH_AUTH_SOCK" ]; then
	           # Check for a currently running instance of the agent
	           RUNNING_AGENT=$(ps -ax | grep "ssh-agent -s" | grep -v grep | wc -l | tr -d "[:space:]")
	           if [ "$RUNNING_AGENT" = "0" ]; then
	            # Launch a new instance of the agent
	            ssh-agent -s &> $HOME/.ssh/ssh-agent
	           fi
	           eval $(cat $HOME/.ssh/ssh-agent)
            fi
            if [ -f $HOME/.bashrc ]; then
                source $HOME/.bashrc
            fi
            ' >> ~/.bash_profile
            ```
        5. Generate new keys and add them to Github (or Bitbucket or sth else). Don't use a passphrase and make sure those keys stay inside your WSL distro. They should ultimately be stored inside ~/.ssh
		(@see https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh)
        6. Edit your ~/.ssh/config file so that it looks like this:

            ```
            Host github.com
                AddKeysToAgent yes
                User git
                IdentityFile ~/.ssh/YOU_GITHUB_PRIVATE_KEY
            ```
        7. Check that things work:

            ```
            source ~/.bash_profile
            ssh-add ~/.ssh/github_rsa
            ssh -vT git@github.com
            ```
            This should produce a response similar to the following:
            ```
            Hi stefanospetrakis! You've successfully authenticated, but GitHub does not provide shell access.
            ```
        8. Make sure you have git configured globally in your WSL2 Distro, with the following two settings:

            ```
            git config --global user.email "Email you use with iqual's github"
            git config --global user.name "Firstname Lastname"
            ```


**Using this repository**

1. Clone the repository (including submodules)
   `git clone git@github.com:iqual-ch/commerce-rework-sw-project.git -b dx/restructuring_folders_git_submodules`
2. Log into your iqual hub.docker account to be able to pull private docker images.
   `docker login -u USERNAME_ON_HUB_DOCKER`
3. Open the root folder of the repository with VS Code
   `cd commerce-rework-sw-project && code .`
4. Select the action "Remote-Containers: Reopen in Container" from the Command Palette (Ctrl+Shift+P)
5. Wait till the containers are up and running (thie first time may take longer due to docker images downloading).
6. Fall into the VSCode terminal and type `cd /project/app && bash instantiate-drupal`; this should install a db and import configuration.

At this point, you should be able to access https://commerce-rework-sw-project.localdev.iqual.ch/

**Included VSCode extensions and tooling includes:**

* PHPCS/PHPCBF with Drupal standards
* XDebug (simply set breakpoints and use a browser helper to remote-start the debugger)
* SQL Tools with a preset connection to the Drupal DB
* GIT Lens


**The following needs to be updated**

**Exposing the web server publically via Pagekite**

By running
```
docker-compose -f app/.runtimes/dev/docker-compose.pagekite.dev.yml up
```

the following URL would be available to the public internet

https://commerce-rework-sw-project.iqual.pagekite.me

N.B.: This would require that the iqual-ch/dc-proxy-for-localdev service is installed and running.
