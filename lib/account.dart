import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_more/1.dart';
import 'package:flutter_application_more/profile.dart';
import 'package:flutter_application_more/register.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class newacc extends StatefulWidget {
  const newacc({Key? key}) : super(key: key);

  @override
  _newaccState createState() => _newaccState();
}

class _newaccState extends State<newacc> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile(email: '', password: '');
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New User", style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        color: Colors.green[50],
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                    colors: [Colors.yellow.shade100, Colors.green.shade100])),
            margin: EdgeInsets.all(32),
            padding: EdgeInsets.all(24),
            child: FutureBuilder(
                future: firebase,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Scaffold(
                      body: Center(
                        child: Text("${snapshot.error}"),
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Scaffold(
                      body: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                            key: formKey,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("E-mail",
                                      style: TextStyle(fontSize: 20)),
                                  TextFormField(
                                    validator: MultiValidator([
                                      EmailValidator(
                                          errorText:
                                              "กรุณาป้อนอีเมล์ที่ถูกต้อง"),
                                      RequiredValidator(
                                          errorText: "กรุณาป้อนอีเมล์"),
                                    ]),
                                    keyboardType: TextInputType.emailAddress,
                                    onSaved: (String? email) {
                                      profile.email = email!;
                                    },
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text("password",
                                      style: TextStyle(fontSize: 20)),
                                  TextFormField(
                                    validator: RequiredValidator(
                                        errorText: "กรุณาป้อนรหัสผ่าน"),
                                    obscureText: true,
                                    onSaved: (String? password) {
                                      profile.password = password!;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    constraints:
                                        BoxConstraints.expand(height: 50),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.blue[200]),
                                    child: FlatButton(
                                        child: Text("Submit",
                                            style: TextStyle(fontSize: 20)),
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            formKey.currentState!.save();
                                            try {
                                              FirebaseAuth.instance
                                                  .createUserWithEmailAndPassword(
                                                      email: profile.email,
                                                      password:
                                                          profile.password)
                                                  .then((value) {
                                                formKey.currentState!.reset();
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "สร้างบัญชีผู้ใช้เรียบร้อยแล้ว",
                                                    gravity: ToastGravity.TOP);
                                              });

                                              Navigator.pushReplacement(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return login();
                                              }));
                                            } on FirebaseAuthException catch (e) {
                                              Fluttertoast.showToast(
                                                  msg: "${e.message}",
                                                  gravity: ToastGravity.TOP);
                                            }
                                          }
                                        }),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
