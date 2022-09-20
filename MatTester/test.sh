#!/bin/bash

check_binaries() {
    retval=0

    for (( i=0; i<$1; i++ ))
    do    
        FILE=binaries/rush0$i\_ref
        if test -f "$FILE"; then
                    ./binaries/rush0$i\_ref > log/log_ref$i.log && ./binaries/rush0$i\_piscine > log/log_piscine$i.log
            diff log/log_ref$i.log log/log_piscine$i.log > diff/diff$i.log
            if [ -s diff/diff$i.log ]
            then
                echo "Test$((i+1))" $' - Diff spotted, check log file\t[\u274C]'
                retval=1
            else
                echo "Test$((i+1))" $'\t\t\t\t\t[\U2705]'
            fi
        fi
    done
    return $retval
}

check_compi() {
    retval=0
    for (( i=0; i<$1; i++ ))
    do    
        compile_ref=$(gcc -Wall -Wextra -Werror $2/main.c $2/ft_putchar.c $2/rush0$i.c &>/dev/null )
        compile_ref_bis=$(gcc -Wall -Wextra -Werror MatTester/ex00/main.c $2/ft_putchar.c $2/rush0$i.c -o MatTester/binaries/rush0$i\_ref &>/dev/null )
        compile_corrected=$(gcc -Wall -Wextra -Werror MatTester/ex00/main.c MatTester/ex00/ft_putchar.c MatTester/ex00/rush0$i.c -o MatTester/binaries/rush0$i\_piscine)
        $compile_ref
        if [ $? -ne 0 ]
        then
            echo "Test$((i+1))" $' - Could not compiled\t\t[\u274C]'
            retval=1
        else
            echo "Test$((i+1))" $'\t\t\t\t\t[\U2705]'
        fi
        $compile_ref_bis
        $compile_corrected
    done
    return $retval
}

check_norm() {
    c_files=$(find -type f -name "*.c" | wc -l)
    norm=$(norminette -R CheckForbiddenSourceHeader | wc -l)
    retval=0

    if [ $c_files -ne $norm ]
        then
        echo $'Norminette error(s) ! Shame one you.\t[\u274C]'
        retval=1
        else
        echo $'Test 1\t\t\t\t\t[\U2705]'
    fi
    return $retval
}

no_ex00() {
    echo $'Test1 - Could not find ex00\t\t[\u274C]'
    echo $'Test2 - Could not find ex00\t\t[\u274C]'
    echo $'Test3 - Could not find ex00\t\t[\u274C]'
    echo $'\033[1mREPOSITORY TESTS\t\t\t[\e[31mFAILED\e[0m]\n'
    echo $'Test1 - Could not find ex00\t\t[\u274C]'
    echo $'\033[1mNORMINETTE TESTS\t\t\t[\e[31mFAILED\e[0m]\n'
}

check_repo() {
    hidden_nb=$(find -name ".*" | wc -l)
    not_c=$(find -not \( -type f -name "*.c" \) | wc -l)
    mandatory_file=$(find -type f -name "rush0*" -o -name "main.c" -o -name "ft_putchar.c" | wc -l)
    retval=0

    if [ $hidden_nb -gt 1 ]
    then
        echo $'Hidden file(s) found ! Shame one you.\t[\u274C]'
        retval=1
        else
        echo $'Test 1\t\t\t\t\t[\U2705]'

    fi
    if [ $not_c -gt 1 ]
    then
        echo $'Not only .c files ! Shame one you.\t[\u274C]'
        retval=1
        else
        echo $'Test 2\t\t\t\t\t[\U2705]'
    fi
    if [ $mandatory_file -lt 3 ]
    then
        echo $'Could not find all 3 mandatory files\t[\u274C]'
        retval=1
        else
        echo $'Test 3\t\t\t\t\t[\U2705]'
    fi
    return $retval
}

echo $'\t\U0001f33b\U0001f33b\U0001f33b\U0001f33b\U0001f33b\U0001f33b\U0001f33b\U0001f33b\U0001f33b\U0001f33b\U0001f33b\U0001f33b\U0001f33b'
echo $'\t\U0001f33b\t\t\t\U0001f33b'
echo $'\t\U0001f33b\033[1m    mlarboul TESTER   \U0001f33b'
echo $'\t\U0001f33b\t\t\t\U0001f33b'
echo $'\t\U0001f33b\U0001f33b\U0001f33b\U0001f33b\U0001f33b\U0001f33b\U0001f33b\U0001f33b\U0001f33b\U0001f33b\U0001f33b\U0001f33b\U0001f33b'

echo

mkdir "binaries" &>/dev/null
mkdir "log" &>/dev/null
mkdir "diff" &>/dev/null

check_root() {
    files_nb=$(find -maxdepth 1 | wc -l)
    dir_name=$(find -type d -name "ex00")
    gitignore=$(find -type f -name ".gitignore")
    retval=0

    if [ $files_nb -gt 5 ] || [[ $files_nb -gt 4 && -z "$(find -type f -name ".gitignore")" ]]
    then
        echo $'Too many files in you repo git\t\t[\u274C]'
        retval=1
        else
        echo $'Test 1\t\t\t\t\t[\U2705]'
    fi
    if [ -z "$dir_name" ]
    then
        echo $'ex00 directory not found\t\t[\u274C]'
        retval=1
        else
        echo $'Test 2\t\t\t\t\t[\U2705]'
    fi
    return $retval
}

rush_is_ok=1
rush_nb=0
path_ex="ex00"

cd ../

check_root
if [ $? -eq 0 ]
then
    echo $'\033[1mROOT TESTS\t\t\t\t[\e[32mSUCCED\e[0m]\n'
else
    echo $'\033[1mROOT TESTS\t\t\t\t[\e[31mFAILED\e[0m]\n'
    rush_is_ok=0
fi

cd "ex00" &>/dev/null
if [ $? -ne 0 ]
then
    no_ex00
    rush_is_ok=-1
else
    check_repo
    if [ $? -eq 0 ]
    then
        echo $'\033[1mREPOSITORY TESTS\t\t\t[\e[32mSUCCED\e[0m]\n'
    else
        echo $'\033[1mREPOSITORY TESTS\t\t\t[\e[31mFAILED\e[0m]\n'
        rush_is_ok=0
    fi
    check_norm
    if [ $? -eq 0 ]
    then
        echo $'\033[1mNORMINETTE TESTS\t\t\t[\e[32mSUCCED\e[0m]\n'
    else
        echo $'\033[1mNORMINETTE TESTS\t\t\t[\e[31mFAILED\e[0m]\n'
        rush_is_ok=0
    fi
    cd ..
fi

echo
if [ $rush_is_ok -eq 1 ]
then
    echo $'Congratulations, all is well... for now! [\U0001f984]'
else
    echo $'Arff.. 0 at your first rush, life is a bitch.. [\U0001f92a]'
fi
read -p 'Any way, how many rush have you done (between 1 and 5)? ' rush_nb
while [[ $rush_nb -lt 1 || $rush_nb -gt 5 ]]
do
    read -p 'Please focus... How many rush have you done (between 1 and 5)? ' rush_nb
done
if [ $rush_is_ok -eq -1 ]
then
    read -p 'What is the name your exercice directory? ' path_ex
fi
echo

check_compi $rush_nb $path_ex
if [ $? -eq 0 ]
then
    echo $'\033[1mCOMPILE TESTS\t\t\t\t[\e[32mSUCCED\e[0m]\n'
else
    echo $'\033[1mCOMPILE TESTS\t\t\t\t[\e[31mFAILED\e[0m]\n'
    rush_is_ok=0
fi
rm a.out &>/dev/null

cd MatTester/
check_binaries $rush_nb
if [ $? -eq 0 ]
then
    rm log/*
    rm diff/*
    echo $'\033[1mBINARIES TESTS\t\t\t\t[\e[32mSUCCED\e[0m]\n'
else
    echo $'\033[1mBINARIES TESTS\t\t\t\t[\e[31mFAILED\e[0m]\n'
    rush_is_ok=0
fi
rm binaries/rush* &>/dev/null

if [ $rush_is_ok -eq 1 ]
then

    echo $'\033[1m\e[32mALL TESTS WENT WELL - GOOD JOB!!\e[0m\n'
else
    echo $'\033[1m\e[31mSOMETHING WENT WRONG - TOO BAD..\e[0m\n'
    rush_is_ok=0
fi
