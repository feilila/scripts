#!/usr/bin/python
# -*- coding: UTF-8 -*-
import sys
import smtplib
from email.mime.text import MIMEText
from email.utils import formataddr
from email.mime.multipart import MIMEMultipart
 
mail_user='zhengsj'
mail_pass = 'Zhengsj1113'

mail_host='mail.clo.com.cn'
mail_to='zhengsj@clo.com.cn'
mail_postfix='clo.com.cn'

def mail(to_list,subject,content):
    ret=True
    try:
        me=mail_user+"<"+mail_user+"@"+mail_postfix+">"
        msg = MIMEMultipart('alternative')
        #msg=MIMEText(content,'html','utf-8')
        msg.attach(MIMEText(content,'html','utf-8'))
        msg['Subject'] = subject
        msg['From'] = me
        msg['To'] = ";".join(to_list)

        server=smtplib.SMTP()
        server.set_debuglevel(1)
        server.connect(mail_host)
        server.login(mail_user, mail_pass)
        server.sendmail(me,to_list, msg.as_string())
        server.quit()
    except Exception,e:
        print str(e)
        ret=False
    return ret
 
if len(sys.argv)<4:
   print "usage:sys.argv[0] [to_addr1;to_addr2;to_addr3...] [mail subject] [mail content]"
   exit(1)
else:
   mailto_list=sys.argv[1].strip().split(';')
   if len(mailto_list)==0:
      print "mail_to_list=%s is invalidate!"% (sys.argv[1])
      exit(1)
   else:
      print ("mail content=",sys.argv[3])
      ret=mail(mailto_list,sys.argv[2],sys.argv[3])
      if ret:
          print("mail send successfully")
          exit(0)
      else:
          print("mail send failed")
          exit(1)
