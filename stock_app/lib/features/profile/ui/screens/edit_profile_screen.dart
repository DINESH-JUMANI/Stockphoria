import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final username = TextEditingController();
  final phoneNumber = TextEditingController();
  final email = TextEditingController();
  final newPassword = TextEditingController();
  final oldPassword = TextEditingController();
  String password = '';
  final _formKey = GlobalKey<FormState>();
  File _selectedImage = File(
      'https://icons.veryicon.com/png/o/internet--web/55-common-web-icons/person-4.png');

  @override
  void initState() {
    setState(() {
      _getUser();
    });

    super.initState();
  }

  Future _pickImage() async {
    final chosenImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (chosenImage == null) return;
    setState(() {
      _selectedImage = File(chosenImage.path);
    });
  }

  Future _getUser() async {
    final user = FirebaseAuth.instance.currentUser!;
    final userData =
        await FirebaseFirestore.instance.collection('user').doc(user.uid).get();
    username.text = userData.data()!['username'];
    phoneNumber.text = userData.data()!['phone_number'];
    email.text = userData.data()!['email'];
    password = userData.data()!['password'];
  }

  void _saveChanges() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: FileImage(_selectedImage),
                    radius: 35,
                    backgroundColor: Colors.black,
                  ),
                  const SizedBox(width: 30),
                  ElevatedButton(
                    onPressed: () {
                      _pickImage();
                    },
                    child: const Text('Change'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 70,
                      width: 300,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(8)),
                      child: TextFormField(
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        controller: username,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          border: InputBorder.none,
                          hintText: 'Enter your name',
                          hintStyle: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().length == 0) {
                            return 'Enter your name';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 70,
                      width: 300,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(8)),
                      child: TextFormField(
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: InputBorder.none,
                          hintText: 'Enter your email',
                          hintStyle: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().length == 0) {
                            return 'Enter your email';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 70,
                      width: 300,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(8)),
                      child: TextFormField(
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        controller: phoneNumber,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Contact',
                          border: InputBorder.none,
                          hintText: 'Enter your phone number',
                          hintStyle: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().length == 0) {
                            return 'Enter your phone number';
                          } else if (value.length != 10) {
                            return 'Enter valid Phone nUmber';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 70,
                      width: 300,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(8)),
                      child: TextFormField(
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        controller: oldPassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Old Password',
                          border: InputBorder.none,
                          hintText: 'Enter your old password',
                          hintStyle: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.length == 0) {
                            return null;
                          } else if (value != password) {
                            return 'Enter valid password';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 70,
                      width: 300,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(8)),
                      child: TextFormField(
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        controller: newPassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'New Password',
                          border: InputBorder.none,
                          hintText: 'Enter your new password',
                          hintStyle: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _saveChanges,
                      child: Text('Save Changes'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
