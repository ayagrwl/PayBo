import 'package:flutter/material.dart';
import 'RazorpayScreen.dart';

class FormScreen extends StatefulWidget {
  final String description;
  final int cid, subid;
  FormScreen(this.description, this.cid, this.subid);
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  GlobalKey<FormState> _formKey;

  TextEditingController _nameController,
      _emailController,
      _numberController,
      _amountController;

  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _nameController = new TextEditingController();
    _emailController = new TextEditingController();
    _numberController = new TextEditingController();
    _amountController = new TextEditingController();
  }

  bool isValidEmail(String string) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(string);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'PayBo',
          style: TextStyle(fontSize: 25.0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.82,
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(30.0)),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
              child: Column(
                children: [
                  Text(
                    'Enter your details',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 25.0,
                    ),
                  ),
                  SizedBox(
                    height: 60.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      border: Border.all(color: Colors.white70, width: 0.5),
                      color: Colors.black.withOpacity(0.5),
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter your name";
                        }
                        return null;
                      },
                      textCapitalization: TextCapitalization.words,
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Enter your name',
                        hintStyle: TextStyle(
                          color: Colors.white38,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
                      ),
                      keyboardType: TextInputType.name,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      border: Border.all(color: Colors.white70, width: 0.5),
                      color: Colors.black.withOpacity(0.5),
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter your email";
                        } else if (!isValidEmail(value)) {
                          return "Invalid email";
                        }
                        return null;
                      },
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(
                          color: Colors.white38,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      border: Border.all(color: Colors.white70, width: 0.5),
                      color: Colors.black.withOpacity(0.5),
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter your Contact Number";
                        } else if (value.length != 10) {
                          return "Invalid Contact Number";
                        }
                        return null;
                      },
                      controller: _numberController,
                      decoration: InputDecoration(
                        hintText: 'Enter your Contact Number',
                        hintStyle: TextStyle(
                          color: Colors.white38,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      border: Border.all(color: Colors.white70, width: 0.5),
                      color: Colors.black.withOpacity(0.5),
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter some amount";
                        }
                        return null;
                      },
                      controller: _amountController,
                      decoration: InputDecoration(
                        hintText: 'Enter the amount (in INR)',
                        hintStyle: TextStyle(
                          color: Colors.white38,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RaisedButton(
                          elevation: 10.0,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              String name = _nameController.text;
                              String email = _emailController.text;
                              String number = _numberController.text;
                              String amount = _amountController.text;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RazorpayScreen(
                                          name, email, number, amount, widget.cid, widget.subid, widget.description)));
                              _nameController.text = "";
                              _emailController.text = "";
                              _numberController.text = "";
                              _amountController.text = "";
                            }
                          },
                          color: Colors.white.withOpacity(0.25),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              'Contribute for ' + widget.description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white54, fontSize: 18.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
