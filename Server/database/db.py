from mongoengine import *
import datetime

connect(db='paybo', host='localhost', port=27017)

mainCauseList = [ "Dummy", "Technicals", "Culturals", "Avana", "Event"]

CauseList = {
    "Technicals": {
        11: "Robtics Club", 12: "Programming Club", 13: "Aeromodelling Club", 
        14: "Developer Students Club", 15: "Cynaptics Club", 16: "Electronics Club", 
        17: "Team Engines and Daemons Club", 18: "CAE Club", 19: "Concreate Club", 
        20: "Metacryst Club", 21: "CFA Club", 22: "Astronomy Club", 23: "Technical Fest", 
    },
    "Culturals": {
        51 : "Dance Club", 52 : "Music Club", 53 : "Drama Club", 54 : "Kalakriti Club", 
        55 : "DOCM Club", 56 : "Debating Society", 57 : "Literary Club", 58 : "Quiz Club", 
        59 : "MUN", 60 : "FLUXUS",
    },
    "Avana": {
        101: "ORM", 102: "Donation Drive", 151: "Kerela Relief Fund", 152: "Bihar Relief Fund",
    }
}


class Donation(EmbeddedDocument):
    name = StringField(required=True)
    amount = FloatField(min_value=0,required=True)
    cause = StringField(max_length=200)
    tstamp = DateTimeField(default=datetime.datetime.now())

class Avana(Document):
    cause = IntField(required=True, unique=True, choices=CauseList["Avana"].keys())
    donations = ListField(EmbeddedDocumentField(Donation))
    meta = {'allow_inheritance': True}

class Tech(Document):
    cause = IntField(required=True, unique=True, choices=CauseList["Technicals"].keys())
    donations = ListField(EmbeddedDocumentField(Donation))
    meta = {'allow_inheritance': True}

class Cult(Document):
    cause = IntField(required=True, unique=True, choices=CauseList["Culturals"].keys())
    donations = ListField(EmbeddedDocumentField(Donation))
    meta = {'allow_inheritance': True}

class Events(Document):
    eid = IntField(required=True, unique=True)
    title = StringField(unique=True, required=True, max_length=40)
    main_cause = StringField(required=True, choices=mainCauseList)
    sub_cause = StringField(required=True)
    descrep = StringField()
    createdAt = DateTimeField(default=datetime.datetime.now())
    donations = ListField(EmbeddedDocumentField(Donation))

class Contacts(Document):
    name = StringField(required=True)
    email = StringField(required=True, unique=True)
    mobile = StringField(min_length=10, max_length=13)


# This Function has done its job
# def makeDummy():
#     for name in CauseList["Avana"]:
#         Avana(cause=name, donations = []).save()
    
#     for name in CauseList["Technicals"].keys():
#         Tech(cause=name, donations = []).save()
    
#     for name in CauseList["Culturals"].keys():
#         Cult(cause=name, donations = []).save()
        

def insertEvent(eid, title, main_cause, sub_cause, description):
    try:
        result = Events(eid=eid, title=title, main_cause=main_cause, sub_cause=sub_cause, descrep=description, donations = []).save()
        print("{title} Event Added".format(title=title))
    except:
        result = Events.objects(eid=eid).first()
    finally:
        if result == None:
            print("Error inserting event")
            return False
        else:
            print("Event Inserted")
            return True

def getEvents():
    events = []
    for event in Events.objects:
        events.append({
            category: event.cause,
            subCategory: event.subcause,
            eventID: event.eid,
            eventHeading: event.title,
            eventDescription: event.descrep,
        })

    return events

def getDonations():
    pass

# def getTech():
#     events = []
#     for event in Tech.objects:
#         print(event.cause)
# 
# getTech()


def donate(main_cause, sub_cause, name, amount, cause=""):
    if main_cause == 1: 
        docref = Tech.objects(cause=sub_cause).first()
    elif main_cause == 2:
        docref = Cult.objects(cause=sub_cause).first()
    elif main_cause == 3:
        docref = Avana.objects(cause=sub_cause).first()
    elif main_cause == 4:
        docref = Events.objects(cause=sub_cause).first()
    else:
        print("Unidentified cause: {0}".format(main_cause)) 

    donobj = Donation(name=name, amount=amount, cause=cause)
    docref.donations.append(donobj)
    docref.save()
