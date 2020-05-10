#!/usr/bin/python
# -*- coding: UTF-8 -*-
import sys
import smtplib
import os.path
from email.mime.text import MIMEText
from email.utils import formataddr
from email.mime.multipart import MIMEMultipart

mail_user='zhengsj'
mail_pass = 'Zhengsj1113'

mail_host='mail.clo.com.cn'
mail_to='zhengsj@clo.com.cn'
mail_postfix='clo.com.cn'

def mail(to_list,cc_list,subject,content,attach_filepath):
    ret=True
    try:
        me=mail_user+"<"+mail_user+"@"+mail_postfix+">"
        #msg = MIMEMultipart('alternative')   二选一
        msg = MIMEMultipart()
        msg.attach(MIMEText(content,'html','utf-8'))
        msg['Subject'] = subject
        msg['From'] = me
        msg['To'] = ";".join(to_list)
        if len(cc_list)!=0:
            msg['Cc']=";".join(cc_list)
        
        if len(attach_filepath)>0 and os.path.isfile(attach_filepath):
            # 构造附件1，传送当前目录下的 test.txt 文件
            att1 = MIMEText(open(attach_filepath, 'rb').read(), 'base64', 'utf-8')
            att1["Content-Type"] = 'application/octet-stream'
            # 这里的filename可以任意写，写什么名字，邮件中显示什么名字
            filename=attach_filepath.split('/').pop()
            att1["Content-Disposition"] = 'attachment; filename='+filename
            msg.attach(att1)
         

        server=smtplib.SMTP()
        server.set_debuglevel(1)
        server.connect(mail_host)
        server.login(mail_user, mail_pass)
        server.sendmail(me,to_list+cc_list, msg.as_string())
        server.quit()
    except Exception,e:
        print str(e)
        ret=False
    return ret

to_list=[]
cc_list=[]
mail_subject="" 
mail_content=""
mail_attachFile=""

for i in range(0,len(sys.argv)):
    param=sys.argv[i].strip()
    
    if len(param)!=0 and param[0]=="-":
        print "param=",param
        if param=="-t" and (i+1)<len(sys.argv):
            to_list=sys.argv[i+1].strip().split(';')
            print "to_list=",to_list
        elif param=='-c' and (i+1)<len(sys.argv):
            cc_list=sys.argv[i+1].strip().split(';')
            print "cc_list=",cc_list
        elif param=='-s' and (i+1)<len(sys.argv):
                 mail_subject=sys.argv[i+1]
                 print "mail subject=",mail_subject
        elif param=='-ct' and (i+1)<len(sys.argv):
                 mail_content=sys.argv[i+1]
                 print "mail content=",mail_content
        elif param=='-a' and (i+1)<len(sys.argv): 
                 mail_attachFile=sys.argv[i+1]
                 print "mail_attachFile=",mail_attachFile
	
if len(to_list)==0 or len(cc_list)==0 or len(mail_subject)==0 or len(mail_content)==0:
       print "len(to_list)=%d or len(cc_list)=%d or len(mail_subject)=%d or len(mail_content)=%d" %(len(to_list),len(cc_list),len(mail_subject),len(mail_content))
       print "usage:sys.argv[0] -t [to_addr1;to_addr2;...] -c [cc_addr1,cc_addr2;....] -s [mail subject] -ct [mail content] -a [attch file]"
       exit(1)

for each_addr in (to_list+cc_list):
      if("@" not in each_addr):
          print "to_list or cc_list =%s is invalidate!"% (to_list+cc_list)
          exit(1)

 
ret=mail(to_list,cc_list,mail_subject,mail_content,mail_attachFile)

if ret:
      print("mail send successfully")
      exit(0)
else:
      print("mail send failed")
      exit(1)
