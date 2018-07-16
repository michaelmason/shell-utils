#!/usr/bin/env python

import os, sys
import socket

def print_mem_info(mem_total, mem_used, mem_avail):
    hostname  = socket.gethostname()
    hn_len    = len(hostname)
    title_len = 24
    title_div = '-' * (hn_len + title_len)

    print title_div
    print 'System Memory Summary (%s)' % socket.gethostname()
    print title_div
    print 'Total: {:5.2f}G'.format(mem_total)
    print 'Used:  {:5.2f}G'.format(mem_used)
    print 'Avail: {:5.2f}G'.format(mem_avail)
    print title_div

def main(argc, argv):
    cmd      = 'free -m'
    output   = os.popen(cmd)
    line_num = 0; mem_total = 0; mem_used = 0; mem_avail = 0
    for line in output:
        if line_num == 1:
            # extract mem_total
            line_sp   = line.split()
            mem_total = line_sp[1]
        elif line_num == 2:
            # extract mem_used and mem_avail
            line_sp   = line.split()
            mem_used  = line_sp[2]
            mem_avail = line_sp[3]
        line_num += 1
    mem_total = float(mem_total) / 1024.0
    mem_used  = float(mem_used)  / 1024.0
    mem_avail = float(mem_avail) / 1024.0
    print_mem_info(mem_total, mem_used, mem_avail)
  
if __name__ == "__main__":
    main(len(sys.argv), sys.argv)
