# Job-Done
Simple ToDo task manager using Bash for managing text files

## [J]ob [D]one
reads the `toDo.txt` file and presents tasks. User selects completed task and
that task is removed from `toDo.txt` and added to `toDosComplete.txt` with a date
stamp of today.

## Usage
run command - see next five jobs by default  
```
jd
````

run command with user defined {number} of jobs dispalyed  
```
jd {number}
```
> NB add in or re-arrange jobs directly in `toDo.txt` using a text editor

## Set-up
- replace filepaths throughout code to match your set-up preference.
- touch `toDo.txt` and `toDosComplete.txt` files into matching filepath.
- manually populate `toDo.txt` with your to do tasks.
- save the code below into your `~/.bash_profile`.
- run `source ~/.bash_profile` from the terminal.
