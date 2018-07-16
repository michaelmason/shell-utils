#!/usr/bin/env python

import os
import sys
import smtplib

MSG_STRUCT = '''
To:      %s
From:    %s
Subject: %s

%s'''

# ----------------------------------------------------------------------------
# name:
#     sendmail
#
# description:
#     Sends an email using smtplib
#
# init parameters:
#     smtp_serv  string  SMTP server address (hostname or IP address)
#     dest_addr  string  Recipient email address (separate by ',')
#     from_addr  string  Sender's email address
#     mesg_subj  string  Subject of the email message
#     mesg_body  string  Body of the email message
# ----------------------------------------------------------------------------
class sendmail(object):
    def __init__ (self, smtp_serv, dest_addr, from_addr, mesg_subj, mesg_body):
        self.smtp_serv = smtp_serv
        self.dest_addr = dest_addr
        self.from_addr = from_addr
        self.mesg_subj = mesg_subj
        self.mesg_body = mesg_body

        # build email message
        self.mesg_text = MSG_STRUCT % (','.join(dest_addr),
                                       from_addr,
                                       mesg_subj,
                                       mesg_body)

    def send (self):
        s = smtplib.SMTP(self.smtp_serv)
        s.sendmail(self.from_addr, self.dest_addr, self.mesg_text)

    def __str__(self):
        s  = '**** smtp_serv: %s\n' % smtp_serv
        s += '**** mesg_subj: %s\n' % mesg_subj
        s += '**** mesg_body: %s\n' % mesg_body
        s += '**** from_addr: %s\n' % from_addr
        s += '**** dest_spec: %s'   % dest_spec
        return s

if __name__ == "__main__":
    if len (sys.argv) < 6:
        pgm_name = os.path.basename(sys.argv[0])
        print 'Usage: %s smtp-server msg-subject msg-body ' \
              'from-addr dest-addr [dest-addr] ...' % pgm_name
        print
        print 'Description:'
        print '    Python script for sending email from the command line'
        print
        print 'Arguments:'
        print '    smtp-server  Hostname or IP adress of the SMTP server'
        print '    msg-subject  Subject message of the email message'
        print '    msg-body     Body of the email message'
        print '    from-addr    Sender email address'
        print '    dest-addr    Destination email address'
        print
        print 'Note:'
        print '    Enclose msg-subject in double quotes if it contains '
        print '    multiple words'
        print
        print '    Enclose msg-body in double quotes if it contains '
        print '    multiple words'
        print
        print '    Multiple destination addresses may be specified by '
        print '    listing them separated by spaces'
        print
        print 'Examples:'
        print '    Send email from mlm@ngc.com to test@ngc.com:'
        print
        print '    ./sendmail.py smtp.it-protect.com \"Test Subject\" ' \
              '\"Test Body 1 2 3 ...\" mlm@ngc.com test@ngc.com'
        print
        print '    Send email from mlm@ngc.com to rja@ngc.com and avr@ngc.com:'
        print
        print '    ./sendmail.py smtp.it-protect.com \"Test Subject\" ' \
              '\"Test Body 1 2 3 ...\" mlm@ngc.com rja@ngc.com avr@ngc.com'
        print
        sys.exit(1)

    smtp_serv = sys.argv[1]
    mesg_subj = sys.argv[2]
    mesg_body = sys.argv[3]
    from_addr = sys.argv[4]
    dest_spec = sys.argv[5:]  # assume the rest of the args are email addrs

    # print '**** smtp_serv: ', smtp_serv
    # print '**** mesg_subj: ', mesg_subj
    # print '**** mesg_body: ', mesg_body
    # print '**** from_addr: ', from_addr
    # print '**** dest_spec: ', dest_spec

    sm = sendmail(smtp_serv, dest_spec, from_addr, mesg_subj, mesg_body)
    print sm

    try:
        sm.send()
    except smtplib.SMTPException, e:
        print 'An error occurred while attempting to send the message:'
        print '    %s' % e
        sys.exit(1)
