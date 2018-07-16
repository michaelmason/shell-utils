#!/usr/bin/env python3

import os
import sys

import cv2
import numpy as np
from matplotlib import pyplot as plt

def main(argc, argv):

    if argc != 3:
        print('Usage;')
        print('    %s <input-image> <plot-mode>' % os.path.basename(argv[0]))
        print()
        print('Arguments:')
        print('    input-image  Name of the image to plot')
        print('    plot-mode    Plot mode to use for the image')
        print('                     image: Interpret input file as an image')
        print('                     mask   Interpret input file as a mask')
        sys.exit(1)

    img_fname = argv[1]
    img_mode  = argv[2]

    assert img_mode in ('image', 'mask')

    if img_mode == 'image':
        # min_val, max_val = np.
        gray_img              = cv2.imread(img_fname, cv2.IMREAD_GRAYSCALE)
        gray_img
        cv2.imshow(img_fname, gray_img)
        plt.hist(gray_img.ravel(), 256, [0, 256])
        plt.title('histogram for %s' % img_fname)
        plt.show()
    elif img_mode == 'mask':
        gray_img              = cv2.imread(img_fname, cv2.IMREAD_GRAYSCALE)
        gray_img[gray_img==1] = 255
        cv2.imshow(img_fname, gray_img)
        plt.hist(gray_img.ravel(), 256, [0, 256])
        plt.title('histogram for %s' % img_fname)
        plt.show()

    while True:
        k = cv2.waitKey(0) & 0xFF
        if k == 27:
            # ----------------------------------------------------------------
            # ESC key to exit
            # ----------------------------------------------------------------
            break

    cv2.destroyAllWindows()

if __name__ == '__main__':
    main(len(sys.argv), sys.argv)
