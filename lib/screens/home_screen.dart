import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
      .collection("users")
      .doc(user!.uid)
      .get()
      .then((value) {
          loggedInUser = UserModel.fromMap(value.data());
          setState(() {
            
          });
      });
  }

  Future<void> logout(BuildContext context) async {
    await  FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed('/');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                child: Image.asset(
                  'assets/lock.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${loggedInUser.firstName} ${loggedInUser.secondName}",
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${loggedInUser.email}',
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ActionChip(
                backgroundColor: Colors.deepPurpleAccent,
                  label: const Text('Logout'),
                  labelStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  onPressed: () {
                    logout(context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
