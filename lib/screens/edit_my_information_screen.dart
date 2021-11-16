import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kwayes/localization/localization_constants.dart';

class EditMyInformationScreen extends StatefulWidget {
  @override
  _EditMyInformationScreenState createState() =>
      _EditMyInformationScreenState();
}

class _EditMyInformationScreenState extends State<EditMyInformationScreen> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User user;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  loadMyProfile(email) async {
    await _firestore
        .collection('users')
        .doc(email)
        .get()
        .then((DocumentSnapshot documentSnapshot) => {
              setState(() {
                nameController.text = documentSnapshot.data()['Name'];
                emailController.text = documentSnapshot.data()['Email'];
                firstNameController.text =
                    documentSnapshot.data()['First Name'] ?? '';
                lastNameController.text =
                    documentSnapshot.data()['Last Name'] ?? '';
              })
            });
  }

  @override
  void initState() {
    user = auth.currentUser;
    if (user != null) {
      loadMyProfile(user.email);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var lang = Localizations.localeOf(context).languageCode;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: ImageIcon(
                    AssetImage(lang == 'ar'
                        ? 'assets/images/icons/Back_button_ar.png'
                        : 'assets/images/icons/Back_button.png'),
                    size: 20,
                    color: Color(0xFF484451),
                  ),
                ),
                Text(
                  getTranslated(context, 'EditMyInformation'),
                  strutStyle: StrutStyle(
                    forceStrutHeight: lang == 'ar' ? true : false,
                  ),
                  style: TextStyle(
                      fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                      fontSize: 24,
                      color: Color(0xFF484451)),
                ),
                Container(
                  width: 20,
                ),
              ],
            ),
            SizedBox(
              height: 42,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  buildTextField(
                      getTranslated(context, 'UserName'), nameController,
                      (value) {
                    if (value == null ||
                        value.isEmpty ||
                        RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                            .hasMatch(value)) {
                      return getTranslated(context, 'UserNameError');
                    } else {
                      return null;
                    }
                  }, lang),
                  buildTextField(
                      getTranslated(context, 'FirstName'), firstNameController,
                      (value) {
                    if (value == null ||
                        value.isEmpty ||
                        RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                            .hasMatch(value)) {
                      return getTranslated(context, 'FirstNameError');
                    } else {
                      return null;
                    }
                  }, lang),
                  buildTextField(
                      getTranslated(context, 'LastName'), lastNameController,
                      (value) {
                    if (value == null ||
                        value.isEmpty ||
                        RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                            .hasMatch(value)) {
                      return getTranslated(context, 'LastNameError');
                    } else {
                      return null;
                    }
                  }, lang),
                  buildTextField(
                      getTranslated(context, 'EmailAddress'), emailController,
                      (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                      return getTranslated(context, 'EmailAddressError');
                    } else {
                      return null;
                    }
                  }, lang),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width - 100,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFF64D62F),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              )),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              await _firestore
                                  .collection('users')
                                  .doc(user.email)
                                  .update({
                                'Name': nameController.text,
                                'Email': emailController.text,
                                'First Name': firstNameController.text,
                                'Last Name': lastNameController.text,
                              });
                            }
                          },
                          child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Text(getTranslated(context, 'SaveBtn'),
                                  strutStyle: StrutStyle(
                                    forceStrutHeight:
                                        lang == 'ar' ? true : false,
                                  ),
                                  style: TextStyle(
                                      color: Color(0xFFFFF6F6),
                                      fontSize: 14,
                                      fontFamily:
                                          lang == 'ar' ? 'DIN' : 'Roboto',
                                      fontWeight: FontWeight.w500)))),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, TextEditingController controller,
      Function validate, String lang) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: TextFormField(
        validator: validate,
        style: TextStyle(
            color: Color(0xFF716B6B),
            fontSize: 16,
            fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
            fontWeight: FontWeight.w500),
        strutStyle: StrutStyle(
          forceStrutHeight: lang == 'ar' ? true : false,
        ),
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          labelStyle: TextStyle(
            color: Color(0xFF484451),
            fontSize: 14,
            fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }
}
