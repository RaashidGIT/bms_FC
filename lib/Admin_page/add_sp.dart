import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bms_sample/Admin_page/sp_image_picker.dart';

final _firebase = FirebaseAuth.instance;

class AdminAuthScreen extends StatefulWidget {
  const AdminAuthScreen({super.key});

  @override
  State<AdminAuthScreen> createState() {
    return _AdminAuthScreenState();
  }
}

class _AdminAuthScreenState extends State<AdminAuthScreen> {
  final _form = GlobalKey<FormState>();


  var _isLogin = false;
  var _enteredEmail = '';
  var _enteredPassword = '';
  File? _selectedImage;
  var _isAuthenticating = false;
  var _enteredBusname = '';
  var _enteredUsername = '';
  var _enteredRegno = '';
  var _enteredRouteA = '';
  var _enteredRouteB = '';

  void _submit() async {
    final isValid = _form.currentState!.validate();

    void showErrorMessage() {
    showDialog(
      context: context,
      barrierDismissible: false, // prevent user from dismissing by tapping outside
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: const Text('Please fill in all required fields and select an image.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

    if (!isValid || !_isLogin && _selectedImage == null) {
      showErrorMessage();
      // shows error message ...
      return;
    }

    _form.currentState!.save();

    try {
      setState(() {
        _isAuthenticating = true;
      });

      if (!_isLogin) {
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);

        final storageRef = FirebaseStorage.instance
            .ref()
            .child('bus_images')
            .child('${userCredentials.user!.uid}.jpg');

        await storageRef.putFile(_selectedImage!);
        final imageUrl = await storageRef.getDownloadURL();

        // Store reference to the Bus document
      final busRef = FirebaseFirestore.instance.collection('Bus').doc(_enteredBusname);

      await FirebaseFirestore.instance
        .collection('SPusers')
        .doc(userCredentials.user!.uid)
        .set({
          'bus_ref': busRef, // Store the reference
          'bus_name':_enteredBusname,
          'username': _enteredUsername,
          'email': _enteredEmail,
          'image_url': imageUrl,
          'RouteA' : _enteredRouteA,
          'RouteB' : _enteredRouteB,
          'Regno' : _enteredRegno,
        });

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
        title: const Text('Sign up new bus'),
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
                child: Image.asset('assets/images/signup.webp'),
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
                          if (!_isLogin)
                            SpImagePicker(
                              onPickImage: (pickedImage) {
                                _selectedImage = pickedImage;
                              },
                            ),
                            if (!_isLogin)
                            TextFormField(
                              decoration:
                                  const InputDecoration(labelText: 'Bus name'),
                              enableSuggestions: false,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.trim().length < 3) {
                                  return 'Please enter at least 3 characters.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredBusname = value!;
                              },
                            ),
                            if (!_isLogin)
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Registration no.'),
                              enableSuggestions: false,
                              validator: (value) {
                                if (value == null || value.trim().length<4) {
                                  return 'Please enter atleast 4 characters.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredRegno = value!;
                              },
                            ),
                            if (!_isLogin)
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Username'),
                              enableSuggestions: false,
                              validator: (value) {
                                if (value == null || value.trim().length<4) {
                                  return 'Please enter atleast 4 characters.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredUsername = value!;
                              },
                            ),
                          if (!_isLogin)
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
                              },
                            ),
                          if (!_isLogin)
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
                              },
                            ),
                            if (!_isLogin)
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Route A'),
                              enableSuggestions: false,
                              validator: (value) {
                                if (value == null || value.trim().length<2) {
                                  return 'Please enter atleast 4 characters.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredRouteA = value!;
                              },
                            ),
                            if (!_isLogin)
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Route B'),
                              enableSuggestions: false,
                              validator: (value) {
                                if (value == null || value.trim().length<2) {
                                  return 'Please enter atleast 4 characters.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredRouteB = value!;
                              },
                            ),
                            // TextFormField(
                            //   decoration: InputDecoration(labelText: 'Time'),
                            //   enableSuggestions: false,
                            //   validator: (value) {
                            //     if (value == null || value.trim().length<4) {
                            //       return 'Please enter atleast 4 characters.';
                            //     }
                            //     return null;
                            //   },
                            //   onSaved: (value) {
                            //     _enteredUsername = value!;
                            //   },
                            // ),
                            // Add a 24 hour timePicker here
                          const SizedBox(
                            height: 12,
                          ),
                          if (_isAuthenticating)
                            const CircularProgressIndicator(),
                            // Non stop spinning but the thing works.
                          if (!_isAuthenticating)
                            ElevatedButton(
                              onPressed: _submit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                              ),
                              child: const Text('Sign up'),
                            ),
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
