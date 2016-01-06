:: Requirement
:: 	1. Python 2.7
::	2. GNUplot
::  3. GitStats: https://github.com/trybeee/GitStats (There is another gitstats with all small caption)
@echo off
setlocal
:: don't contaminate the PATH env
set gitbashpath="C:\Program Files\Git\bin\sh.exe"

set gitinspectorPath="F:\Documents\GitLocal\gitinspector_cmd"

set python2path="C:\Python27\python.exe"
set outputFolder="%temp%\gitactivity"
set targetGitRepo="F:\Documents\GitLocal\Latex_doc"

:: remove the folder if exist and create a new one
if exist %outputFolder% rmdir /s /q %outputFolder%
mkdir %outputFolder%

:: need to double the back slash before pass it into bash.
:: seems like no need to remove the double quote at all
set python2path_Bash=%python2path:\=\\\\%
set outputFolder_Bash=%outputFolder:\=\\\\%
set targetGitRepo_Bash=%targetGitRepo:\=\\\\%


:: cd to gitinspector path
cd %gitinspectorPath%

:: call the gitbash
:: be careful this is the bash syntax
:: the gitstats_bash.sh takes 3 args: (python2 path),(gitrepo path),(outputPath)
cmd /c  "%gitbashpath% --login -i -c "bash gitstats_bash.sh %python2path_Bash% %outputFolder_Bash% %targetGitRepo_Bash%""

:: open the webpage
start "" %outputFolder%\activity.html

endlocal
