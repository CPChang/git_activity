This is windows batch script to show git activity. Through using `git-cmd.exe` and `usr/bin/sh.exe`, git is not required to be in `PATH`

Currently there are two packages which can read the .git directory and generate html report. 

# Basics
## Requirement
**git for windows.** Other requirement will depends on which package using. 

# GitStats
<https://github.com/trybeee/GitStats>



## Requirement
* Python 2
* GNUplot. 

Gitstats has already been included as submodule, no need to install. This batch script will use `<GITDIR>/bin/sh.exe` and mingw to run the GitStats because it requires some bash command like `wc` and `grep`. 

## Default Output 
`%temp%\gitactivity\activity.html`. The folder `%temp%\gitactivity` will be completely removed and created freshly during the run, 


# gitinspector 
<https://github.com/ejwa/gitinspector>	

## Requirement
* gitinspector Installation (python)

After installation, `gitinspector.exe` will be appreared in `script` folder of python. This batch script will use `<GITDIR>/git-cmd.exe` to ensure the git will always be found. 

## Default Output 
`%temp%\gitactivity\gitactivity.html`. The folder `%temp%\gitactivity` will be completely removed and created freshly during the run, 