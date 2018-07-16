#!/usr/bin/env python

import os
import sys

smtp_serv = '10.40.255.12'                   # IP address of NG SMTP gateway
from_addr = 'michael.l.mason@gmail.com'      # 'from' email address
dest_addr = 'michael.mason@ngc.com'          # 'to' email address
mail_prog = '/opt/ohpc/pub/apps/sendmail.py' # python script which sends email

# ----------------------------------------------------------------------------
# set the email message subject and body
# ----------------------------------------------------------------------------
mesg_subj = '\"testing sendmail.py ...\"' # email subject
mesg_body = '\"Testing 1 2 3 ...\"'       # email body

cmd = '%s %s %s %s %s %s' % (mail_prog, smtp_serv, mesg_subj, mesg_body,
                             from_addr, dest_addr)
os.system(cmd)
