from mongoengine import *
import datetime
import json
import eml as mailer

mongo_Url = "mongodb+srv://pbuser:3K0BnCn9u6nblF77@impulz.w6t9o.mongodb.net/paybo?retryWrites=true&w=majority"
# mongo_Url = "mongodb://127.0.0.1:27017/paybo"

try:
    connect(host=mongo_Url)
    print("Database Connected")
except Exception as err:
    print("Database Connection error\n")
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
    tstamp = DateTimeField(default=datetime.datetime.now())


class Avana(Document):
    cause = IntField(required=True, unique=True,
                     choices=CauseList["Avana"].keys())
    donations = ListField(EmbeddedDocumentField(Donation))
    meta = {"allow_inheritance": True}


class Tech(Document):
    cause = IntField(required=True, unique=True,
                     choices=CauseList["Technicals"].keys())
    donations = ListField(EmbeddedDocumentField(Donation))
    meta = {"allow_inheritance": True}


class Cult(Document):
    cause = IntField(required=True, unique=True,
                     choices=CauseList["Culturals"].keys())
    donations = ListField(EmbeddedDocumentField(Donation))
    meta = {"allow_inheritance": True}


class Contacts(Document):
    name = StringField(required=True)
    email = StringField(required=True, unique=True)
    phone = StringField(required=True)


class Events(Document):
    title = StringField(unique=True, required=True, max_length=40)
    descrep = StringField()
    createdAt = DateTimeField(default=datetime.datetime.now())
    donations = ListField(EmbeddedDocumentField(Donation))
    contact = ReferenceField(Contacts)


class Aggregate(Document):
    cause = StringField(required=True, unique=True)
    totald = FloatField(required=True)


# This Function has done its job
def makeDummy():
    try:
        for name in CauseList["Avana"]:
            Avana(cause=name, donations=[]).save()
    except:
        print("Avana Done")

    try:
        for name in CauseList["Technicals"].keys():
            Tech(cause=name, donations=[]).save()
    except:
        print("Technicals Done")

    try:
        for name in CauseList["Culturals"].keys():
            Cult(cause=name, donations=[]).save()
    except:
        print("Cult done")

    try:
        Aggregate(cause="Technicals", totald=0).save()
        Aggregate(cause="Culturals", totald=0).save()
        Aggregate(cause="Avana", totald=0).save()
        Aggregate(cause="Events", totald=0).save()
    except:
        print("Aggregate Done")

    try:
        plancon = Contacts(
            name="Shreyas Nakshataram",
            email="shreyas@gmail.com",
            phone="1234567890",
        ).save()
        enigcon = Contacts(
            name="Kartik Garg",
            email="kartik@gmail.com",
            phone="2345678901",
        ).save()
        tvsmcon = Contacts(
            name="Aadish Godha",
            email="aadish@gmail.com",
            phone="3456789012",
        ).save()
    except Exception as err:
        print("contacts done")

    try:
        plantation = Events(
            title="Plantation Drive",
            descrep="The Avana Club will be organizing a plantation Drive in the city in collaboration with few other social organizations of city. Please give your valuable contribution by donating for the good cause.",
            contact=plancon, donations=[]).save()

        enigmaQuiz = Events(
            title="Enigma Quiz",
            descrep="Enigma Quiz, one of its own kind will be organized by the Quiz Club of IIT Indore. Expected to receive 200+ participants from several institutes around the country. Contribute for award money or contact us for sponsorship.",
            contact=enigcon, donations=[]).save()

        tvsmInstrument = Events(
            title="T vs M Instrumental Competition",
            descrep="T vs M is the one of its own kind competition between IIT Indore and IIM Indore where both the premier institutes compete in various cultural competitions to receive the glory. Contribute for purchasing new instruments and contact us for sponsorship.",
            contact=tvsmcon, donations=[]).save()
    except Exception as err:
        print(err)


def insertEvent(title, description, name, email, phone):
    try:
        newContact = Contacts(name=name, email=email, phone=phone).save()
    except:
        newContact = Contacts.objects(email=email)
    result = Events(
        title=title,
        descrep=description,
        donations=[],
        contact=newContact
    ).save()
    print("{title} Event Added".format(title=title))


def getEvents():
    events = []
    for event in Events.objects:
        events.append(
            {
                "eventHeading": event.title,
                "eventDescription": event.descrep,
                "contact": {
                    "name": event.contact.name,
                    "email": event.contact.email,
                    "phone": event.contact.phone,
                }
            }
        )
    return json.dumps(events)


def donateEvent(title, name, email, amount):
    docref = Events.objects(title=title).first()

    donobj = Donation(name=name, email=email, amount=amount)
    docref.donations.append(donobj)
    docref.save()

    aggregDoc = Aggregate.objects(cause="Events").first()
    aggregDoc.totald = aggregDoc.totald + float(amount)
    aggregDoc.save()

    mailer.sendemail(name, email)

    return True


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


def donate(main_cause, sub_cause, name, email, amount):
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
    else:
        print("Unidentified cause: {0}".format(main_cause))
        return False

    donobj = Donation(name=name, email=email, amount=amount)
    docref.donations.append(donobj)
    docref.save()

    # save amount to aggreg doc
    aggregDoc = Aggregate.objects(cause=cause).first()
    aggregDoc.totald = aggregDoc.totald + float(amount)
    aggregDoc.save()

    print("Donation Saved!!")
    mailer.sendemail(name, email)
    return True


def getAggregate():
    doclist = Aggregate.objects
    result = []
    for docs in doclist:
        result.append({
            "cause": docs.cause,
            "totald": docs.totald
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
