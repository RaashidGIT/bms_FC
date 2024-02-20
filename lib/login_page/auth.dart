// If the details entered by the user is of admin, edit_bus.dart will be opened else my_bus.dart

import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:max_project_8/widgets/user_image_picker.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() {
    return _AuthScreenState();
  }
}

bool AdminEmail = false; // edit this soon, else admin can't stay logged in.
bool AdminPass = false;

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();

  var _isLogin = true;
  var _enteredEmail = '';
  var _enteredPassword = '';
  File? _selectedImage;
  var _isAuthenticating = false;
  // var _enteredRegno = '';
  // var _enteredBusname = '';

  void _submit() async {
    final isValid = _form.currentState!.validate();

    // if (!isValid) {
    //   return;
    // }

    if (!isValid || !_isLogin && _selectedImage == null) {
      // show error message ...
      return;
    }

    // if (!_isLogin && _selectedImage == null) {
    //   return;
    // }

    _form.currentState!.save();

    try {
      setState(() {
        _isAuthenticating = true;
      });
      if (_isLogin) {
        final userCredentials = await _firebase.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
      } else {
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);

        // final storageRef = FirebaseStorage.instance
        //     .ref()
        //     .child('user_images')
        //     .child('${userCredentials.user!.uid}.jpg');

        // await storageRef.putFile(_selectedImage!);
        // final imageUrl = await storageRef.getDownloadURL();

        // await FirebaseFirestore.instance
        //     .collection('users')
        //     .doc(userCredentials.user!.uid)
        //     .set({
        //   'username': _enteredUsername,
        //   //'busname': _enteredBusname,
        //   'email': _enteredEmail,
        //   'image_url': imageUrl,
        // });
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        // ...
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Authentication failed.'),
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log in'),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                width: 200,
                child: Image.asset('assets/images/login.webp'),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _form,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // if (!_isLogin)
                          //   UserImagePicker(
                          //     onPickImage: (pickedImage) {
                          //       _selectedImage = pickedImage;
                          //     },
                          //   ),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Email Address'),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Please enter a valid email address.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredEmail = value!;
                              if (value == 'FCfarooq@gmail.com') {
                                AdminEmail = true;
                              } else {
                                AdminEmail = false;
                              }
                            },
                          ),
                          // if (!_isLogin)
                          //   TextFormField(
                          //     decoration:
                          //         const InputDecoration(labelText: 'Bus name'),
                          //     enableSuggestions: false,
                          //     validator: (value) {
                          //       if (value == null ||
                          //           value.isEmpty ||
                          //           value.trim().length < 3) {
                          //         return 'Please enter at least 3 characters.';
                          //       }
                          //       return null;
                          //     },
                          //     onSaved: (value) {
                          //       _enteredUsername = value!;
                          //     },
                          //   ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Password'),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return 'Password must be at least 6 characters long';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredPassword = value!;
                              if (value == '0987654') {
                                AdminPass = true;
                              } else {
                                AdminPass = false;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          if (_isAuthenticating)
                            const CircularProgressIndicator(),
                          if (!_isAuthenticating)
                            ElevatedButton(
                              onPressed: _submit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                              ),
                              child: Text(_isLogin ? 'Log in' : 'Sign up'),
                            ),
                          // if (!_isAuthenticating)
                          //   TextButton(
                          //     onPressed: () {
                          //       setState(() {
                          //         _isLogin = !_isLogin;
                          //       });
                          //     },
                          //     child: Text(_isLogin
                          //         ? 'Create an account'
                          //         : 'I already have an account'),
                          //   ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
