# docker-git-webhook
:whale: Pull your Git code into a data volume ready to use in other containers. Provides a webhook, so that you can get new code pulled in automatically.

##### [Docker hub image: eduwass/docker-git-webhook](https://hub.docker.com/r/eduwass/docker-git-webhook/)

### Available Configuration Parameters

The following flags are a list of all the currently supported options that can be changed by passing in the variables to docker with the -e flag.

 - **GIT_REPO** : URL to the repository containing your source code
 - **GIT_BRANCH** : Select a specific branch (optional)
 - **GIT_EMAIL** : Set your email for code pushing (required for git to work)
 - **GIT_NAME** : Set your name for code pushing (required for git to work)
 - **GIT_HOOK_TOKEN** : Auth-Token used for the [docker-hook](https://github.com/schickling/docker-hook) listener
 - **SSH_KEY** : Private SSH deploy key for your repository (requires write permissions for pushing)
 - **BASE64_ENCODED_SSH_KEY** : set to true if you want to use a Base64 encoded version of the private SSH key for a little extra security
 - **STARTUP_COMMANDS** : Add any commands that will be run at the end of the start.sh script
 - **AFTER_PULL_COMMANDS** : Add any commands that will be run after pull
 - **AFTER_PUSH_COMMANDS** : Add any commands that will be run after push
 - **BEFORE_PULL_COMMANDS** : Add any commands that will be run before pull
 - **BEFORE_PUSH_COMMANDS** : Add any commands that will be run before push
 
### Available Locations to add Custom Scripts

Mount any .sh scripts you have to this location in the container so that they get executed on the corresponding step:

  - **/custom_scripts/after_pull**
  - **/custom_scripts/after_push**
  - **/custom_scripts/before_pull**
  - **/custom_scripts/before_push**
  - **/custom_scripts/on_startup**

