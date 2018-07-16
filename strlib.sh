#!/bin/bash

# ----------------------------------------------------------------------------
# name:
#     strcat
#
# usage:
#     strcat s1 s2
#
# description:
#     Appends the value of 's2' on to the end of 's1'
#
# example:
#     a="foo"
#     b="bar"
#     strcat a b
#     echo $a
#     => foobar
# ----------------------------------------------------------------------------
###;;;autoload --> autoloading of function commented out <--
function strcat ()
{
    local s1_val s2_val

    s1_val=${!1}                        # indirect variable expansion
    s2_val=${!2}
    eval "$1"=\'"${s1_val}${s2_val}"\'
    # ==> eval $1='${s1_val}${s2_val}' avoids problems,
    # ==> if one of the variables contains a single quote.
}

# ----------------------------------------------------------------------------
# name:
#     strncat
#
# usage:
#     strncat s1 s2 $n
#
# description:
#     Line strcat, but strncat appends a maximum of n characters from the
#     value of variable s2.  It copies fewer if the value of variabl s2 is
#     shorter than n characters.  Echoes result on stdout.
#
# example:
#     a=foo
#     b=barbaz
#     strncat a b 3
#     echo $a
#     => foobar
# ----------------------------------------------------------------------------
###;;;autoload --> autoloading of function commented out <--
function strncat ()
{
    local s1="$1"
    local s2="$2"
    local -i n="$3"
    local s1_val s2_val

    s1_val=${!s1}                       # ==> indirect variable expansion
    s2_val=${!s2}

    if [ ${#s2_val} -gt ${n} ]; then
        s2_val=${s2_val:0:$n}            # ==> substring extraction
    fi

    eval "$s1"=\'"${s1_val}${s2_val}"\'
    # ==> eval $1='${s1_val}${s2_val}' avoids problems,
    # ==> if one of the variables contains a single quote.
}

# ----------------------------------------------------------------------------
# name:
#     strcmp
#
# usage:
#     strcmp $s1 $s2
#
# description:
#     Strcmp compares its arguments and returns an integer less than,
#     equal to, or greater than zero, depending on whether string s1 is
#     lexicographically less than, equal to, or greater than string s2.
#
# example:
# ----------------------------------------------------------------------------
###;;;autoload --> autoloading of function commented out <--
function strcmp ()
{
    [ "$1" = "$2" ] && return 0

    [ "${1}" '<' "${2}" ] > /dev/null && return -1

    return 1
}

# ----------------------------------------------------------------------------
# name:
#     strncmp
#
# uage:
#     strncmp $s1 $s2 $n
#
# description:
#     Like strcmp, but makes the comparison by examining a maximum of n
#     characters (n less than or equal to zero yields equality).
#
# example:
# ----------------------------------------------------------------------------
###;;;autoload --> autoloading of function commented out <--
function strncmp ()
{
    if [ -z "${3}" -o "${3}" -le "0" ]; then
        return 0
    fi

    if [ ${3} -ge ${#1} -a ${3} -ge ${#2} ]; then
        strcmp "$1" "$2"
        return $?
    else
        s1=${1:0:$3}
        s2=${2:0:$3}
        strcmp $s1 $s2
        return $?
    fi
}

# ----------------------------------------------------------------------------
# name:
#     strlen
#
# usage:
#     strlen s
#
# description:
#     Strlen returns the number of characters in string literal s.
#
# example:
# ----------------------------------------------------------------------------
###;;;autoload --> autoloading of function commented out <--
function strlen ()
{
    eval echo "\${#${1}}"
    # ==> Returns the length of the value of the variable
    # ==> whose name is passed as an argument.
}

# ----------------------------------------------------------------------------
# name:
#     strspn
#
# usage:
#     strspn $s1 $s2
#
# description:
#     Strspn returns the length of the maximum initial segment of string s1,
#     which consists entirely of characters from string s2.
#
# example:
# ----------------------------------------------------------------------------
###;;;autoload --> autoloading of function commented out <--
function strspn ()
{
    # Unsetting IFS allows whitespace to be handled as normal chars.
    local IFS=
    local result="${1%%[!${2}]*}"

    echo ${#result}
}

# ----------------------------------------------------------------------------
# name:
#     strcspn
#
# usage:
#     strcspn $s1 $s2
#
# description:
#     Strcspn returns the length of the maximum initial segment of string s1,
#     which consists entirely of characters not from string s2.
#
# usage:
# ----------------------------------------------------------------------------
###;;;autoload --> autoloading of function commented out <--
function strcspn ()
{
    # Unsetting IFS allows whitspace to be handled as normal chars.
    local IFS=
    local result="${1%%[${2}]*}"

    echo ${#result}
}

# ----------------------------------------------------------------------------
#
#:docstring strstr:
# Usage: strstr s1 s2
#
# Strstr echoes a substring starting at the first occurrence of string s2 in
# string s1, or nothing if s2 does not occur in the string.  If s2 points to
# a string of zero length, strstr echoes s1.
#:end docstring:

###;;;autoload --> autoloading of function commented out <--
function strstr ()
{
    # if s2 points to a string of zero length, strstr echoes s1
    [ ${#2} -eq 0 ] && { echo "$1" ; return 0; }

    # strstr echoes nothing if s2 does not occur in s1
    case "$1" in
        *$2*) ;;
        *) return 1;;
    esac

    # use the pattern matching code to strip off the match and everything
    # following it
    first=${1/$2*/}

    # then strip off the first unmatched portion of the string
    echo "${1##$first}"
}

# ----------------------------------------------------------------------------
#
#:docstring strtok:
# Usage: strtok s1 s2
#
# Strtok considers the string s1 to consist of a sequence of zero or more
# text tokens separated by spans of one or more characters from the
# separator string s2.  The first call (with a non-empty string s1
# specified) echoes a string consisting of the first token on stdout. The
# function keeps track of its position in the string s1 between separate
# calls, so that subsequent calls made with the first argument an empty
# string will work through the string immediately following that token.  In
# this way subsequent calls will work through the string s1 until no tokens
# remain.  The separator string s2 may be different from call to call.
# When no token remains in s1, an empty value is echoed on stdout.
#:end docstring:

###;;;autoload --> autoloading of function commented out <--
function strtok ()
{
    :
}

# ----------------------------------------------------------------------------
#
#:docstring strtrunc:
# Usage: strtrunc $n $s1 {$s2} {$...}
#
# Used by many functions like strncmp to truncate arguments for comparison.
# Echoes the first n characters of each string s1 s2 ... on stdout.
#:end docstring:

###;;;autoload --> autoloading of function commented out <--
function strtrunc ()
{
    n=$1 ; shift
    for z; do
        echo "${z:0:$n}"
    done
}

# provide string

# string.bash ends here


# ========================================================================== #
# ==> Everything below here added by the document author.

# ==> Suggested use of this script is to delete everything below here,
# ==> and "source" this file into your own scripts.

# strcat
string0=one
string1=two
echo
echo "Testing \"strcat\" function:"
echo "Original \"string0\" = $string0"
echo "\"string1\" = $string1"
strcat string0 string1
echo "New \"string0\" = $string0"
echo

# strlen
echo
echo "Testing \"strlen\" function:"
str=123456789
echo "\"str\" = $str"
echo -n "Length of \"str\" = "
strlen str
echo



# Exercise:
# --------
# Add code to test all the other string functions above.


exit 0
