from mongoengine import *
import datetime
import json

mongo_Url  = "mongodb+srv://impulz.w6t9o.mongodb.net/"

try:
    connect(db="paybo", username = "pbuser", password="wticmppYLwLAuO6J", host=mongo_Url)
except err:
    print(err)
    
mainCauseList = ["Dummy", "Technicals", "Culturals", "Avana", "Event"]

CauseList = {
    "Technicals": {
        11: "Robtics Club",
        12: "Programming Club",
        13: "Aeromodelling Club",
        14: "Developer Students Club",
        15: "Cynaptics Club",
        16: "Electronics Club",
        17: "Team Engines and Daemons Club",
        18: "CAE Club",
        19: "Concreate Club",
        20: "Metacryst Club",
        21: "CFA Club",
        22: "Astronomy Club",
        23: "Technical Fest",
    },
    "Culturals": {
        51: "Dance Club",
        52: "Music Club",
        53: "Drama Club",
        54: "Kalakriti Club",
        55: "DOCM Club",
        56: "Debating Society",
        57: "Literary Club",
        58: "Quiz Club",
        59: "MUN",
        60: "FLUXUS",
    },
    "Avana": {
        101: "ORM",
        102: "Donation Drive",
        151: "Kerela Relief Fund",
        152: "Bihar Relief Fund",
    },
}


class Donation(EmbeddedDocument):
    name = StringField(required=True)
    email = StringField(required=True)
    amount = FloatField(min_value=0, required=True)
    cause = StringField(max_length=200)
    tstamp = DateTimeField(default=datetime.datetime.now())


class Avana(Document):
    cause = IntField(required=True, unique=True, choices=CauseList["Avana"].keys())
    donations = ListField(EmbeddedDocumentField(Donation))
    meta = {"allow_inheritance": True}


class Tech(Document):
    cause = IntField(required=True, unique=True, choices=CauseList["Technicals"].keys())
    donations = ListField(EmbeddedDocumentField(Donation))
    meta = {"allow_inheritance": True}


class Cult(Document):
    cause = IntField(required=True, unique=True, choices=CauseList["Culturals"].keys())
    donations = ListField(EmbeddedDocumentField(Donation))
    meta = {"allow_inheritance": True}


class Events(Document):
    eid = IntField(required=True, unique=True)
    title = StringField(unique=True, required=True, max_length=40)
    main_cause = IntField(required=True, choices=[1, 2, 3, 4])
    sub_cause = IntField(required=True)
    descrep = StringField()
    createdAt = DateTimeField(default=datetime.datetime.now())
    donations = ListField(EmbeddedDocumentField(Donation))
    

class Contacts(EmbeddedDocument):
    name = StringField(required=True)
    email = StringField(required=True, unique=True)
    mobile = StringField(min_length=10, max_length=13)


class Aggregate(Document):
    cause = StringField(required=True, unique=True)
    totald = FloatField(required=True)


# This Function has done its job
def makeDummy():
    # for name in CauseList["Avana"]:
    #     Avana(cause=name, donations=[]).save()

    # for name in CauseList["Technicals"].keys():
    #     Tech(cause=name, donations=[]).save()

    # for name in CauseList["Culturals"].keys():
    #     Cult(cause=name, donations=[]).save()

    # Aggregate(cause="Technicals", totald=0).save()
    # Aggregate(cause="Culturals", totald=0).save()
    # Aggregate(cause="Avana", totald=0).save()
    # Aggregate(cause="Events", totald=0).save()

    # Events(
    #     title="General Welfare",
    #     eid="1001",
    #     main_cause=3,
    #     sub_cause=102,
    #     donations=[],
    # ).save()
    pass

# makeDummy()

def insertEvent(eid, title, main_cause, sub_cause, description):
    try:
        result = Events(
            eid=eid,
            title=title,
            main_cause=main_cause,
            sub_cause=sub_cause,
            descrep=description,
            donations=[],
        ).save()
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
        events.append(
            {
                "category": event.main_cause,
                "subCategory": event.sub_cause,
                "eventID": event.eid,
                "eventHeading": event.title,
                "eventDescription": event.descrep,
            }
        )
    return json.dumps(events)


def getDonations(main_cause, sub_cause):
    main_cause = str(main_cause)
    sub_cause = str(sub_cause)

    if main_cause == "1":
        docref = Tech.objects(cause=sub_cause).first()
    elif main_cause == "2":
        docref = Cult.objects(cause=sub_cause).first()
    elif main_cause == "3":
        docref = Avana.objects(cause=sub_cause).first()
    elif main_cause == "4":
        docref = Events.objects(cause=sub_cause).first()
    else:
        print("Unidentified cause: {0}".format(main_cause))
        return False

    result = []
    for obj in docref.donations:
        result.append(obj.to_json())

    return json.dumps(result)


def donate(main_cause, sub_cause, name, email, amount, cause=""):
    main_cause = str(main_cause)
    sub_cause = str(sub_cause)

    if main_cause == "1":
        docref = Tech.objects(cause=sub_cause).first()
        cause = mainCauseList[1]
    elif main_cause == "2":
        docref = Cult.objects(cause=sub_cause).first()
        cause = mainCauseList[2]
    elif main_cause == "3":
        docref = Avana.objects(cause=sub_cause).first()
        cause = mainCauseList[3]
    elif main_cause == "4":
        docref = Events.objects(cause=sub_cause).first()
        cause = mainCauseList[4]
    else:
        print("Unidentified cause: {0}".format(main_cause))
        return False

    donobj = Donation(name=name, email=email, amount=amount, cause=cause)
    docref.donations.append(donobj)
    docref.save()

    # save amount to aggreg doc
    aggregDoc = Aggregate.objects(cause=cause).first()
    aggregDoc.totald = aggregDoc.totald + amount
    aggregDoc.save()

    print("Donation Saved!!")
    return True


def getAggregate():
    doclist = Aggregate.objects
    result = []
    for docs in doclist:
        result.append({
            "cause":docs.cause,
            "totald":docs.totald
        })

    return json.dumps(result)


def getAggregEvents():
    doclist = Events.objects
    result = []
    for docs in doclist:
        thisCause = 0.0
        for donations in docs.donations:
            thisCause = thisCause + donations.amount

        result.append({"title": docs.title, "totald": thisCause})

    return json.dumps(result)
