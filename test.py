#!/usr/bin/env python

import os
import sys
import time

with open('/home/mlm/cron_test.txt', 'a') as f:
    now = time.strftime("%c")
    # date and time representation
    s = '%s\n' % time.strftime("%c")
    f.write(s)
