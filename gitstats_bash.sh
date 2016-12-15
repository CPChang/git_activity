#!bin/bash
# the gitstats_bash.sh takes 3 args: (gitinspectorpath),(python2 path),(gitrepo path)

function pause(){
   read -p "$*"
}

winpath() {
    if [ ${#} -eq 0 ]; then
        : skip
    elif [ -f "$1" ]; then
        local dirname=$(dirname "$1")
        local basename=$(basename "$1")
        echo "$(cd "$dirname" && pwd -W)/$basename" \
        | sed \
          -e 's|/|\\|g';
    elif [ -d "$1" ]; then
        echo "$(cd "$1" && pwd -W)" \
        | sed \
          -e 's|/|\\|g';
    else
        echo "$1" \
        | sed \
          -e 's|^/\(.\)/|\1:\\|g' \
          -e 's|/|\\|g'
    fi
}



unixpath() {
    echo "$1" \
    | sed -r \
      -e 's/\\/\//g' \
      -e 's/^([^:]+):/\/\1/'
}



pythonPath=$(unixpath "$1")
gitrepoPath=$(unixpath "$2")
outputPath=$(unixpath "$3")

echo ${pythonPath}
echo ${gitrepoPath}
echo ${outputPath}

$pythonPath GitStats/git-stats $outputPath $gitrepoPath 

echo "Wait for 5 sec"
sleep 5