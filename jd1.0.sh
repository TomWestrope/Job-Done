#!usr/bin/env bash

#[J]ob [D]one
#reads the toDo.txt file and presents tasks. User selects completed task and
#that task is removed from toDo.txt and added to toDosComplete.txt with a date
#stamp of today.

#Usage
#  run command - see next five jobs by default
#    jd
#  run command with user defined {number} of jobs dispalyed
#    jd {number}
#  NB add in or re-arrange jobs directly in toDo.txt using a text editor

#Set-up
#  replace filepaths throughout code to match your set-up preference.
#  touch toDo.txt and toDosComplete.txt files into matching filepath.
#  manually populate toDo.txt with your to do tasks.
#  save the code below into your ~/.bash_profile.
#  run {source ~/.bash_profile} from the terminal.

function readandecho-toptasks {
  readarray tasks < ~/Path/to/toDo.txt ;
  awk 'NR==1, NR=='$NoJobs' {print NR,$0}' ~/Path/to/toDo.txt ;
}

function ask-whatcomplete {
  read -p "jd- Which job number have you completed?: " job &&
  manage-taskslist ;
}

function manage-taskslist {
  if [[ $job -le $NoJobs ]] && [[ $job -gt 0 ]]; then
    comp_task=$((job-1)) ;
    echo $'\n'
    echo "jd- Have you really completed '"${tasks[comp_task]}"'" ;
    read -p "y/n?: " confirm ;
      if [[ $confirm = "y" ]]; then
        DATE=$(date +%Y-%m-%d) ;
        echo $DATE" "${tasks[comp_task]} >> ~/Path/to/toDosComplete.txt &&
        unset tasks[comp_task] ;
          for value in "${tasks[@]}"
            do
            echo $value >> ~/Path/to/toDo2.txt
          done &&
        mv ~/Path/to/toDo2.txt ~/Path/to/toDo.txt
      elif [[ $confirm = "n" ]]; then
        echo $'\n'
        echo "jd- OK, Let's try again" ;
        readandecho-toptasks ;
        ask-whatcomplete
      elif [[ $confirm = "exit" ]] || [[ $confirm = "q" ]]; then
        echo "jd: exiting jd"
      else
        echo $'\n'
        echo "jd- answer must be \"y\" or \"n\"" ;
        manage-taskslist
      fi
  elif [[ $job = "exit" ]] || [[ $job = "q" ]]; then
    echo "jd- exiting jd"
  else
    echo $'\n'
    echo "jd- that's not a job" ;
    ask-whatcomplete
  fi
}

function jd {
  echo "Type 'exit' or 'q' to exit" ;
    if [ $# -eq 0 ]; then NoJobs=5; fi
    if [ $# -eq 1 ] && [ $1 -le 0 ]; then
      echo "Don't be silly, the number of jobs should be positive" ; NoJobs="5"; fi
    if [ $# -eq 1 ] && [ $1 -gt 0 ]; then NoJobs="$1"; fi
  readandecho-toptasks && ask-whatcomplete ;
}

jd
