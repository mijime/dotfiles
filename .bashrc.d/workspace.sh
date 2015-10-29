#!/bin/bash

echoR(){
    echo -e "\e[31m$@\e[m"
}

echoG(){
    echo -e "\e[32m$@\e[m"
}

echoY(){
    echo -e "\e[33m$@\e[m"
}

render_template(){
    eval "echo \"`cat $1`\""
}

render_templates(){
    find $@ -type f -name '*.tmpl' | while read tmpl
    do
        tmpl_result=${tmpl%.tmpl}
        [[ -f $tmpl_result ]] &&
           echoY "already exists: $tmpl_result"

        echo -n "rendering... $tmpl: "
        render_template $tmpl > $tmpl_result &&
            echoG "success" ||
            echoR "error"
    done
}
