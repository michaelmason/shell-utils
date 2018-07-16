#!/usr/bin/env python

import os
import sys

def write_block_comment(f, comment):
    '''Write comment, offset by divider/comment-lines'''
    f.write('# ' + '-' * 76 + '\n')
    f.write('# %s\n' % comment)
    f.write('# ' + '-' * 76 + '\n')

def write_header(f):
    '''Writes python script header'''
    f.write('#!/usr/bin/env python\n\n')          # add shebang line
    write_block_comment(f, 'system modules')      # add system block
    f.write('import os\n')                        # ...
    f.write('import sys\n\n')                     # ...
    write_block_comment(f, 'third-party modules') # add third-party block
    f.write('\n\n')                               # ...
    write_block_comment(f, 'local modules')       # add local block
    f.write('\n\n')                               # ...

def write_work_fn(f, fn_name):
    f.write('def %s():\n' % fn_name)                     # add work-fn skeleton
    f.write('    \'\'\'<insert-comment>\'\'\'\n')        # add fn comment
    f.write('    print \'**** enter %s\'\n\n' % fn_name) # add print statement

def write_main(f, fn_name):
    '''Writes main function'''
    f.write('def main(argc, argv):\n')
    f.write('    if argc != 1:\n')
    f.write('        print \'Usage: %s <arg>\' % os.path.basename(argv[0])\n')
    f.write('        sys.exit(1)\n')
    f.write('    %s()\n\n' % fn_name)

def write_module_check(f):
    '''Write check for __main__ block'''
    f.write('if __name__ == \'__main__\':\n')
    f.write('    main(len(sys.argv), sys.argv)\n')

def write_skeleton(fname):
    '''Writes the skeleton of the python script'''
    with open(fname, 'w') as f:
        write_header(f)                          # write the script header
        fn_name = os.path.basename(fname)[:-3]   # get the work-function name
        write_work_fn(f, fn_name)                # write the work-function skel
        write_main(f, fn_name)                   # write the main function
        write_module_check(f)                    # add module check

def make_exec(path):
    mode = os.stat(path).st_mode   # get the current mode
    mode |= (mode & 0444) >> 2     # copy 'R' bits to 'X'
    os.chmod(path, mode)

def main(argc, argv):
    if argc != 2:
        print 'Usage: %s <new-python-filename>' % os.path.basename(argv[0])
        sys.exit(1)

    fname = argv[1]
    print '**** creating new python file: ', fname

    if os.path.exists(fname):
        print '**** file already exists'
        sys.exit(1)

    write_skeleton(fname)  # generate skeleton program
    make_exec(fname)       # make the file executable

if __name__ == '__main__':
    main(len(sys.argv), sys.argv)
