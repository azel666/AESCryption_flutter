import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sistem_kriptografi/resources/auth_method.dart';
import 'package:sistem_kriptografi/screens/auth/login_screen.dart';
import 'package:sistem_kriptografi/utils/my_color.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController userNameCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  TextEditingController noTelpCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();
  bool? _isLoading;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    userNameCon.dispose();
    emailCon.dispose();
    noTelpCon.dispose();
    passwordCon.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Center(child: content()),
      ),
    );
  }

  Widget content() {
    return Container(
      height: 650,
      child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Text(
                  "Pendaftaran",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                child: TextFormField(
                  controller: userNameCon,
                  decoration: InputDecoration(
                    label: Text('Nama akun',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                        )),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "masukkan nama akun";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Container(
                child: TextFormField(
                  controller: emailCon,
                  decoration: InputDecoration(
                    label: Text('Email',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                        )),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "masukkan email";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Container(
                child: TextFormField(
                  controller: noTelpCon,
                  keyboardType: TextInputType.numberWithOptions(),
                  maxLength: 13,
                  decoration: InputDecoration(
                    label: Text('Nomor Telepon',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                        )),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[0-9]{13}$').hasMatch(value)) {
                      return "masukkan nomor telepon yang benar";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Container(
                child: TextFormField(
                  controller: passwordCon,
                  obscureText: true,
                  decoration: InputDecoration(
                      label: Text('Password',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                          )),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                  validator: _requeiredConfirmValidator,
                ),
              ),
              Container(
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      label: Text('Verifikasi Password',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                          )),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                  validator: _requeiredConfirmValidator,
                ),
              ),
              Container(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF2E4053)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ))),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      registerUser();
                    }
                  },
                  child: Text('Register',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Sudah punya akun? ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                        )),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: "#99A3A4".toColor(), fontFamily: 'Poppins'),
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }

  void registerUser() async {
    final auth = FirebaseAuth.instance;

    var uName = userNameCon.text;
    var uEmail = emailCon.text.trim();
    var uNoTelp = noTelpCon.text.trim();
    var uPass = passwordCon.text.trim();

    final List<String> loginMethod =
        await auth.fetchSignInMethodsForEmail(uEmail);
    if (loginMethod.isEmpty) {
      await AuthMethod().register(
          username: uName, email: uEmail, password: uPass, noTelp: uNoTelp);
      showSignUpSuccessDialog();
    } else {
      showEmailErr();
    }
  }

  String? _requeiredConfirmValidator(String? confirmPasswordText) {
    if (confirmPasswordText == null || confirmPasswordText.trim().isEmpty) {
      return 'Form ini dibutuhkan !';
    }
    if (passwordCon.text != confirmPasswordText) {
      return 'Password tidak sama';
    } else {
      return null;
    }
  }

  void showEmailErr() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'register',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Email sudah terdaftar',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF2E4053)),
              ),
              child: Text(
                'OK',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

  void showSignUpSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'register',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'pendaftaran behasil',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF2E4053)),
              ),
              child: Text(
                'OK',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Get.offAll(const Login());
              },
            ),
          ],
        );
      },
    );
  }
}
