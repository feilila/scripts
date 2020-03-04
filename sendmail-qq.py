#!/usr/bin/python
# -*- coding: UTF-8 -*-
import smtplib
from email.mime.text import MIMEText
from email.utils import formataddr
 
my_sender='35420784@qq.com'
my_pass = 'muauwcecqxvvbgfb'
my_user='35420784@qq.com'

def _format_addr(s):
    name, addr = parseaddr(s)
    return formataddr(( \
        Header(name, 'utf-8').encode(),\
        addr.encode('utf-8') if isinstance(addr, unicode) else addr))

def mail():
    ret=True
    try:
        msg=MIMEText('test','plain','utf-8')
        msg['From']=formataddr(["FromPython",my_sender])  
        msg['To']=formataddr(["zhengsj",my_user])              
        msg['Subject']="test from 191"              
 
        server=smtplib.SMTP_SSL("smtp.qq.com", 465)
        server.set_debuglevel(1)
        server.login(my_sender, my_pass)
        server.sendmail(my_sender,[my_user],msg.as_string())
        server.quit()  
    except Exception: 
        ret=False
    return ret
 
ret=mail()
if ret:
    print("邮件发送成功")
else:
    print("邮件发送失败")

