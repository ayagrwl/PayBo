
import smtplib 

def sendemail(name, recieveremailid):
    email = smtplib.SMTP('smtp.gmail.com', 587)  
    email.starttls()  
    email.login("paybo21@gmail.com", "Paybo2021") 
    message = 'Subject: {}\n\n{}'.format('Donation Recieved', 'Dear, '+ name +'\nThanks a lot for supporting our cause. Your donation will be used in the most fruitfull manner.\n Have a nice day :) ')
    email.sendmail("paybo21@gmail.com", recieveremailid, message)  
    email.quit()
