#!/bin/bash

echo ""
echo "Searching through files ..."

function usage {
   cat << EOF
Usage: $0 -p <path>

Reads Variable
EOF
   exit 1
}

pattern='\{(.*)\}'
if [ "$1" != "-p" ]; then
  usage;
fi
find $2 -maxdepth 1 -type f -name "*.tf" |
 while read file;
   
    do \
       var=$(cat ${file} | grep -A 4 'module "eks"');
       if [[ $var =~ $pattern ]]; then \
        echo ""
        matchedString=${BASH_REMATCH[1]}
        foo=$(echo $matchedString | sed 's/[[:blank:]]*=[[:blank:]]*/=/g')
            for keyvalue in $foo; do
                key=${keyvalue%%=*} 
                value=${keyvalue##*=}
                echo $key=$value
            done
        break;
       fi

done

exit 0;
