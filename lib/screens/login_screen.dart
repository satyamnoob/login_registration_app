import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../screens/home_screen.dart';
import '../screens/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Form Key --->
  final _formKey = GlobalKey<FormState>();

  //TextEditing Controllers --->
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //firebase
  final _auth = FirebaseAuth.instance;


  //login function
  void signIn(String email, String password) async {
    if(_formKey.currentState!.validate()) {
      await _auth.signInWithEmailAndPassword(email: email, password: password)
        .then((uid) {
          Fluttertoast.showToast(msg: "Login Successful");
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        }).catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
    }
  }
  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter Your Email.";
        }
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Password is required for login';
        }
        RegExp regex = RegExp(r'^.{6,}$');
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password(Min. 6 Character)");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    final loginButton = Material(
      elevation: 5,
      color: Colors.deepPurpleAccent,
      borderRadius: BorderRadius.circular(20),
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signIn(emailController.text, passwordController.text);
        },
        child: const Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                      child: Image.asset(
                        "assets/lock.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    emailField,
                    const SizedBox(
                      height: 20,
                    ),
                    passwordField,
                    const SizedBox(
                      height: 20,
                    ),
                    loginButton,
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('Dont have an account?'),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(RegistrationScreen.routeName);
                            },
                            child: const Text('SignUp'))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
