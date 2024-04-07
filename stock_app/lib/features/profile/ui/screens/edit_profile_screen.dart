import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stock_app/common/screens/tabs.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _user = FirebaseAuth.instance.currentUser!;
  final _db = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;
  final username = TextEditingController();
  final phoneNumber = TextEditingController();
  final email = TextEditingController();
  final newPassword = TextEditingController();
  final oldPassword = TextEditingController();
  String imageUrl = "";
  String password = '';
  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;
  ImageProvider? _imageProvider;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  void dispose() {
    username.dispose();
    phoneNumber.dispose();
    email.dispose();
    newPassword.dispose();
    oldPassword.dispose();
    super.dispose();
  }

  showImagePickMenu() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Pick Image from'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    _pickImage(ImageSource.camera);
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.camera_alt),
                  title: Text('Camera'),
                ),
                ListTile(
                  onTap: () {
                    _pickImage(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.image),
                  title: Text('Gallery'),
                ),
              ],
            ),
          );
        });
  }

  Future _pickImage(ImageSource source) async {
    final chosenImage = await ImagePicker().pickImage(source: source);
    if (chosenImage == null) return;
    setState(() {
      _selectedImage = File(chosenImage.path);
      _imageProvider = FileImage(_selectedImage!);
    });
  }

  Future _getUser() async {
    await _user.reload();
    final userData = await _db.collection('user').doc(_user.uid).get();
    username.text = userData.data()!['username'];
    phoneNumber.text = userData.data()!['phone_number'];
    email.text = userData.data()!['email'];
    password = userData.data()!['password'];
    imageUrl = userData.data()!['profile_pic'];
    _imageProvider = NetworkImage(imageUrl);
    setState(() {});
  }

  void _saveChanges() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    if (newPassword.text.isNotEmpty && oldPassword.text.isNotEmpty) {
      if (oldPassword.text != password) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Old password does not match with existing password'),
          ),
        );
        return;
      }
    } else if (oldPassword.text.isEmpty && newPassword.text.isNotEmpty ||
        oldPassword.text.isNotEmpty && newPassword.text.isEmpty) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Enter the requireed password field'),
        ),
      );
      return;
    }
    if (_selectedImage != null) {
      try {
        UploadTask uploadTask = _storage
            .ref("Profile Pics")
            .child(email.text.toString())
            .putFile(_selectedImage!);
        TaskSnapshot taskSnapshot = await uploadTask;
        String url = await taskSnapshot.ref.getDownloadURL();
        _db.collection('user').doc(_user.uid).update({
          'profile_pic': url,
        });
      } on FirebaseAuthException catch (e) {
        log(e.toString());
      }
    }
    _db.collection('user').doc(_user.uid).update({
      'username': username.text,
      'phone_number': phoneNumber.text,
      'email': email.text,
      'password': newPassword.text,
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        content: Text('Changes Saved Successfully'),
      ),
    );

    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => Tabs(),
      ),
    );
    return;
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
                    backgroundImage: _imageProvider,
                    radius: 35,
                    backgroundColor: Colors.black,
                  ),
                  const SizedBox(width: 30),
                  ElevatedButton(
                    onPressed: () {
                      showImagePickMenu();
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
