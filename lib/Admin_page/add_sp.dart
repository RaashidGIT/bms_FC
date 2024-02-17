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

  final _busNameController = TextEditingController();
  List<String> busNameSuggestions = [];

  @override
  void initState() {
    super.initState();
    _fetchBusNames(); // Fetch bus names initially
  }

  _fetchBusNames() async {
    final busNamesSnapshot = await FirebaseFirestore.instance
        .collection('Bus')
        .orderBy('bus_name') // Order alphabetically
        .get();
    setState(() {
      busNameSuggestions = busNamesSnapshot.docs
          .map((doc) => doc.get('bus_name') as String)
          .toList();
    });
  }

  var _isLogin = false;
  var _enteredEmail = '';
  var _enteredPassword = '';
  File? _selectedImage;
  var _isAuthenticating = false;
  var _enteredBusname = '';
  var _enteredUsername = '';

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
            .child('user_images')
            .child('${userCredentials.user!.uid}.jpg');

        await storageRef.putFile(_selectedImage!);
        final imageUrl = await storageRef.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('SPusers')
            .doc(userCredentials.user!.uid)
            .set({
          'bus_name': _enteredBusname,
          'username': _enteredUsername,
          'email': _enteredEmail,
          'image_url': imageUrl,
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
        title: const Text('Sign up new users'),
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
                            Autocomplete<String>(
                fieldViewBuilder: (context, controller, focusNode, onEditingComplete) =>
                    TextFormField(
                      controller: controller,
                      decoration: const InputDecoration(labelText: 'Bus name'),
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
                optionsBuilder: (TextEditingValue text) async {
                  if (text.text.isEmpty) {
                    return [];
                  }
                  return busNameSuggestions
                      .where((name) =>
                          name.toLowerCase().startsWith(text.text.toLowerCase()))
                      .toList();
                },
                displayStringForOption: (suggestion) => suggestion,
                onSelected: (suggestion) {
                  _enteredBusname = suggestion;
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