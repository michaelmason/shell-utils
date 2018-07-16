# ----------------------------------------------------------------------------
#
# NAME:
# 
#     cpp2html.awk
#
# PURPOSE:
#
#     Converts C and C++ code into HTML pages
#
# USAGE:
#
#     awk -f cpp2html.awk -v TITLE="foo.cpp" \
#	      -v PREFACE="`cat HTMLHEAD`"        \
#	      -v HTMLPATH="boost=."              \
#	       < foo.cpp > foo.cpp.html
#
# NOTES:
#
#     + Makes any local include statement such as:  #include "foo.hpp" a
#       hyperlink to foo.hpp.html
#
#     + You can specify paths for system header files to create links the
#       same way:
#
#           -v HTMLPATH=<path>,<path>,<path> ...
#
#       where path is: <codepath>=<browserpath>
#
#       For example:
#
#           -v HTMLPATH="/usr/include,boost=."
#
#       makes for:
#
#           <foo.hpp> a link to /usr/include/foo.hpp.html
#           <boost/foo.hpp> a link to ./foo.hpp.html
#
#     + Comments are presented in a  different color and font
#
# WARNING:
#
#     + Unable to handle tabulators properly (expand tabulators to
#       characters first)
#
#     + Unable to process @ in code properly
#
#     + Unable to process nested comments properly
#
#     + Unable to process comment characters inside strings properly
#
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
#
# BEGIN
#     - initial settings and
#     - initial HTML output
#
# before processing each line
#
# ----------------------------------------------------------------------------
BEGIN {
  # comment settings
  #     COMCOL: color entry for a comment
  #     COMBEG: beginning of comment (starts comment style)
  #     COMEND: end of a comment (end comment style)
  COMCOL = " color=\"0000FF\" " 
  COMBEG = "<i><font face=\"Arial,Helvetica,sans-serif\"" COMCOL ">"
  COMEND = "</font></i>"

  # as style sheets don't work properly with Netscape yet
  # COMBEG = "<span class=\"Comment\">"
  # COMEND = "</span>"

  # currently we are no in a comment
  incomment = 0

  # print heading 
  #     - title could be passed to awk with option "-v TITLE=..."
  #     - STYLE SETTINGS
  print "<html>"
  print "<head>"
  if(TITLE != "") {
      print "<title>" TITLE "</title>"
  }

  # as style sheets don't work properly with Netscape yet
  # print "<STYLE type=\"text/css\">"
  # print " SPAN.Source {"
  # print "  font-family: monospace;"
  # print " }"
  # print " SPAN.Comment {"
  # print "  font-family: sans-serif;"
  # print "  font-style: italic;"
  # print "  color: blue;"
  # print " }"
  # print "</STYLE>"

  # start body (black text on white background)
  print "</head>"
  print ""
  print "<body text=\"#000000\" bgcolor=\"#FFFFFF\">"
  print "&nbsp;"

  # print grey title banner if title passed
  if(TITLE != "") {
      print "<table height=\"40\" width=\"100%\">"
      print "<tr> <td align=\"left\" width=\"100%\" bgcolor=\"#DDDDDD\">"
      print "<font face=\"Arial,Helvetica\" size=+2><B>"
      print "&nbsp;" TITLE
      print "</b></font>"
      print "</td></tr></table><br>"
  }
  print ""

  # insert additional HTML preface if passed with "-v PREFACE=..."
  if(PREFACE != "") {
      print PREFACE
      print ""
  }

  # start code (use source style)
  print "<br><br>"
  print "<tt>"
  print "<span class=\"Source\">"
  
# }

# ----------------------------------------------------------------------------
#
# BEGIN: handling HTMLPATH
#
# NOTE:  only gawk understands more than one BEGIN clause
#
# ----------------------------------------------------------------------------
#BEGIN {
  # handling HTMLPATH option
    HTMLNUM = 0
    if(HTMLPATH != "") {
        # split into array of settings
        HTMLNUM = split(HTMLPATH, HTMLARRAY, ",")
        for(i=1; i<=HTMLNUM; i++) {
	        n = split(HTMLARRAY[i], tmp, "=")
	        if(n == 1) {
	            # global setting
	            CODEPATH[i] = ""
	            BROWPATH[i] = HTMLARRAY[i]
	        }
	        else {
                CODEPATH[i] = tmp[1]
                BROWPATH[i] = tmp[2]
            }
	        # print "CODEPATH[" i "]: " CODEPATH[i] > "/dev/stderr"
	        # print "BROWPATH[" i "]: " BROWPATH[i] > "/dev/stderr"
        }
    }
}

# ----------------------------------------------------------------------------
# print warnings
# ----------------------------------------------------------------------------
/\t/ {
    print "WARNING: line " NR " contains a tabulator (please expand first)" \
    	> "/dev/stderr"
}
/@/ {
    print "WARNING: line " NR " contains a @ character (converted to space)" \
    	> "/dev/stderr"
}

# ----------------------------------------------------------------------------
# process each code line
# - note: @ will internally be used as spaces
#         thus any @ in the code will get converted to a space
# ----------------------------------------------------------------------------
{
    #process line as "line"
    line = $0

    # replace spaces by @
    gsub(" ","@",line)

    # replace < and > by appropriate statements
    gsub("<", "\\&lt;", line)
    gsub(">", "\\&gt;", line)

    if(incomment) {
        #
        # We are in a C++ comment ...
        #
        # if comment ends with */ then:
        #     process anything between leading blanks and */ as comment
        #     and leave comment
        # else
        #     process anything between leading blanks and EOL as comment
        # fi
        #
        if(line ~ /\*\//) {
            line = gensub("(@*)(.*)\\*/", "\\1" COMBEG "\\2*/" COMEND, "g",line)
            incomment = 0;
        }
        else {
            line = gensub("(@*)(.*)$","\\1" COMBEG "\\2" COMEND, "g", line)
        }
    }
    else {
        #
        # We are in a C++ comment ...
        #
        # process anything between // and end of line as comment
        #
        line = gensub("//(.*)$", COMBEG "//\\1" COMEND, "g",line)
        if(line ~ /\/\*/) {
            #
            # if comment starts with with /* and ends with */ then:
            #     process between /* and */ as comment
            #
            # if comment starts with with /* and doesn't end end with */ then:
            #     process anything between /* and end of line as comment
            #     and turn incomment flag on
            # fi
            #
            if(line ~ /\/\*.*\*\//) {
                line = gensub("/\\*(.*)\\*/", \
                              COMBEG "/*\\1*/" COMEND, "g",line)
                incomment = 0
            }
            else {
                line = gensub("/\\*(.*)$", "<font" COMCOL ">/</font>" \
                              COMBEG "*\\1" COMEND, "g",line)
                incomment = 1
            }
        }
    }

    # replace each @ by explicit space
    gsub ("@","\\&nbsp;",line)
}

# ----------------------------------------------------------------------------
# Handling HTMLPATH
# make #include <path/foo.hpp> a hyperlink to foo.hpp.html
# in a directory specified in HTMLPATH
# ----------------------------------------------------------------------------
line ~ /#.*include.*&lt;.*&gt;/ {
    if(line ~ /href/) {
        # print "schon einmal ersetzt: " line > "/dev/stderr"
    }
    else if(HTMLPATH != "") {
        # extract full file name
        file = substr(line,index(line,"&lt;")+4,               \
                      index(line,"&gt;")-index(line,"&lt;")-4)
        # print file > "/dev/stderr"

        # split file name into basename and filename
        n = split (file, tokens, "/")
        basename = ""
        if(n > 1) {
            basename = tokens[1]
            for(i=2; i<n; i++) {
                basename = basename "/" tokens[i]
            }
        }
        filename = tokens[n]
        # print basename > "/dev/stderr"
        # print filename > "/dev/stderr"

        # create browser path for each source path passed as option HTMLPATH
        for(i=1; i<=HTMLNUM; i++) {
            if(CODEPATH[i] == file) {
                line = gensub ("&lt;(.*)&gt;",                  \
                               "\\&lt;<a href=\"" BROWPATH[i]   \
                               "\">\\1</a>\\&gt;", "1", line)
                print "create link to " BROWPATH[i]             \
                    " for header <" file ">" > "/dev/stderr"
                break  # THE LOOP
                # print line > "/dev/stderr"
            }
            if(CODEPATH[i] == basename) {
                line = gensub("&lt;(.*)&gt;",                                \
                              "\\&lt;<a href=\"" BROWPATH[i]                 \
                              "/"filename".html\">\\1</a>\\&gt;", "1", line)
                print "create link to " BROWPATH[i]"/"filename".html"        \
                    " for header <" file ">" > "/dev/stderr"
                break  # THE LOOP
                # print line > "/dev/stderr"
            }
        }
    }
}

# ----------------------------------------------------------------------------
# make #include "foo.hpp" a hyperlink to foo.hpp.html
#
# NOTE: In each line that contains "include" and a string ending with
#       something like .h, .hpp, .cpp, .HPP, or so, make the string contents
#       a hyperlink to string contents with .html appended
# ----------------------------------------------------------------------------
line ~ /#.*include.*".*[.][cChHpP]*"/ {
    if(line ~ /href/) {
        # print "schon einmal ersetzt: " line > "/dev/stderr"
    }
    else {
        split(line, tokens, "\"")
        line = gensub("\"([a-zA-Z]+[a-zA-Z0-9/]*[.][cChHpP]*)\"", \
                      "\"<a href=\"\\1.html\">\\1</a>\"", "1", line)
        print "create link to " tokens[2] ".html for header \"" tokens[2] "\"" \
          > "/dev/stderr"
    }
}

# ----------------------------------------------------------------------------
# end of line processing, so print it
# ----------------------------------------------------------------------------
{
    print line "<br>"
}

# ----------------------------------------------------------------------------
# final HTML output
# ----------------------------------------------------------------------------
END {
  print "</span>"
  print "</tt>"
  print "</body>"
  print "</html>"
}

