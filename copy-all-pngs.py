#!/usr/bin/env python3

import os
import sys
from   shutil import copy2

def main(argc, argv):
    if argc != 2:
        print('Usage: %s <path>' % os.path.basename(argv[0]))
        sys.exit(1)

    path = argv[1]

    for root, dirs, files in os.walk(path):
        for f in files:
            f_fullpath = os.path.join(root, f)
            fname, ext = os.path.splitext(f)
            if 'png' in ext:
                if 'masks' in f_fullpath:
                    copy2(f_fullpath, './%s_mask.png' % fname)
                elif 'images' in f_fullpath:
                    copy2(f_fullpath, './%s_image.png' % fname)
                else:
                    print('**** error: %s' % f_fullpath)

if __name__ == '__main__':
    main(len(sys.argv), sys.argv)
