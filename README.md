#PHPStorm Command Completion for Any Symfony Cli application

This very small project automatically creates and install a command line completion configuration XML for any symfony-cli based application
 for the PHPStorm (or any IntelliJ based IDE) see https://www.jetbrains.com/phpstorm/help/command-line-tool-support.html

USAGE: run path_to_this/install {cli-tool} in your PHPStorm project directory
It will generate for any symfony-cli based tool command line completions for 
PHPStorm for example './install platform'

By default this creates a configuration for the awseome CLI for the awesome http://platform.sh PaaS which you should totally check out (you can install the CLI by running ```composer global require 'platformsh/cli:1.*' ```) 