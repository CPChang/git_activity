:: Requirement
:: 	1. Python 2.7
::	2. GNUplot
::  [3. already included as submodule] trybeee/GitStats: https://github.com/trybeee/GitStats (There is another gitstats with all small caption)

:: Example
:: `gitstate_cmd.bat ..\..\Matlab`
:: `gitstate_cmd.bat ..\..\Matlab dropbox`
:: 
:: The difference will be the output folder. 
::
:: * default:                            %temp%\gitactivity\[git_folder_name]
:: * dropbox: F:\Dropbox\Softwares_setting_sync\gitactivity\[git_folder_name]
::
:: The dropbox option is for those repository change rapidly, and need to be sync 
:: across computers. For example: Matlab, cb_function
::
:: An additional folder for different git_folder is added, so the files from 
:: different repository will not be overwritten.
::
:: Files will be written in local temp folder first, then copy to dropbox folder
:: if needed. Instead of delete and write the dropbox folder, which cause twice 
:: network traffic.  
:: If not delete the old data, python will have error. `KeyError: 'x'`


@echo off
setlocal
:: don't contaminate the PATH env

set dropboxFolder="F:\Dropbox\Softwares_setting_sync\gitactivity\%~n1"
set tempFolder="%temp%\gitactivity\%~n1"
:: ================== customize path ===============================
set gitInstallDir="C:\Program Files\Git"
set python2path="C:\Python27\python.exe"
:: =================================================================

if "%2" == "dropbox" (
	set outputFolder=%dropboxFolder%
) else (
	set outputFolder=%tempFolder%
)

set gitbashpath="%gitInstallDir:"=%\bin\sh.exe"
set targetGitRepo=%~f1


:: remove the tempFolder if exist and create a new one
:: later will copy to outputFolder
if exist %tempFolder% rmdir /s /q %tempFolder%
mkdir %tempFolder%

:: cd to the folder contain this script
set thisFolderPath=%~dp0
cd %thisFolderPath%


:: need to double the back slash before pass it into bash.
:: seems like no need to remove the double quote at all
set python2path_Bash=%python2path:\=\\\\%
set outputFolder_Bash=%tempFolder:\=\\\\%
set targetGitRepo_Bash=%targetGitRepo:\=\\\\%

:: call the gitbash
:: be careful this is the bash syntax
:: the gitstats_bash.sh takes 3 args: (python2 path),(gitrepo path),(outputPath)
cmd /c  "%gitbashpath% --login -i -c "bash gitstats_bash.sh %python2path_Bash% %outputFolder_Bash% %targetGitRepo_Bash%""

:: copy to output folder if needed
:: /C Continues copying even if errors occur.
:: /L Displays files that would be copied.
:: /Y Suppresses prompting to confirm you want to overwrite an existing destination file.
if not "%outputFolder%" == "%tempFolder%" (
	xcopy %tempFolder%\* %outputFolder% /C /L /Y
)


:: open the webpage
start "" %outputFolder%\activity.html

endlocal
