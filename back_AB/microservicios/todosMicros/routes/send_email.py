import smtplib 
from email.message import EmailMessage 
from flask import Blueprint, request, jsonify
import random

from dataBase.insertarDatos import insertDatataWhere


send_email=Blueprint("send_email",__name__)

def generateCode():
    randomlist = []
    for i in range(5):
        n = random.randint(1,9)
        randomlist.append(n)
    return str(randomlist)
generateCode()


@send_email.route('/send_email',methods=['GET'])
def sendEmail():
    respuesta=request.json
    emailUser=respuesta['email']
    if respuesta['send_email']==True:
        email_subject = "CODIGO ANIMALBOOKING" 
        sender_email_address = "infoanimalbooking@gmail.com" 
        receiver_email_address = emailUser
        email_smtp = "smtp.gmail.com" 
        email_password = "e36739503" 

        # Create an email message object 
        message = EmailMessage() 

        # Configure email headers 
        message['Subject'] = email_subject 
        message['From'] = sender_email_address 
        message['To'] = receiver_email_address 

        codigo=generateCode()

        # Set email body text 
        message.set_content('Su codigo de registro es: ' + codigo) 

        # Set smtp server and port 
        server = smtplib.SMTP(email_smtp, '587') 

        # Identify this client to the SMTP server 
        server.ehlo() 

        # Secure the SMTP connection 
        server.starttls() 

        # Login to email account 
        server.login(sender_email_address, email_password) 

        # Send email 
        server.send_message(message) 

        # Close connection to server 
        server.quit()
        

        # cambio el database en el avatar_credentials
        # insertDatataWhere('avatar_credentials','secure_code', codigo ,'avatar_info_id',respuesta['avatar_info_id'])
        

    # sendEmail()

    return jsonify({
            "message":"Code created Succesfully", 
            "succefully":True,     
            "email":emailUser,
            "code":codigo})


# def checkRegisterCode():
