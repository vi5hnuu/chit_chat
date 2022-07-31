import 'dart:io';

import 'package:chit_chat/widgets/picker/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(
      {required String email,
      required String pass,
      String? username,
      required bool isLogin,File? pickedImage}) submitFn;

  final bool isLoading;
  AuthForm({required this.submitFn, required this.isLoading});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  File? _pickedImage;
  var _isLogin = true;
  String? _userEmail;
  String? _userName;
  String? _userPassword;
  void _trySubmit() {
    FocusScope.of(context).unfocus();
    final isValid = _formKey.currentState?.validate();
    if (isValid == null || !isValid) {
      return;
    }
    if (!_isLogin && _pickedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please choose profile image'),
        ),
      );
      return;
    }
    _formKey.currentState!.save();
    widget.submitFn(
        email: _userEmail!.trim(),
        pass: _userPassword!.trim(),
        isLogin: _isLogin,
        username: _userName?.trim(),
        pickedImage: _pickedImage
    );
  }

  void _getPickedImage(File? imageFile) {
    _pickedImage = imageFile;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
          child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
          if (!_isLogin) UserImagePicker(imagerPickFn: _getPickedImage),
          Card(
            color: Colors.blueGrey.withOpacity(0.8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      key: ValueKey<String>('email'),
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email address',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: 'xyz@gmail.com',
                        // enabled: false,
                      ),
                      textAlign: TextAlign.center,
                      validator: (email) {
                        if (email == null ||
                            email.trim().isEmpty ||
                            !email.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      onSaved: (email) {
                        _userEmail = email;
                      },
                    ),
                    if (!_isLogin)
                      SizedBox(
                        height: 20,
                      ),
                    if (!_isLogin)
                      TextFormField(
                        key: ValueKey<String>('UserName'),
                        keyboardType: TextInputType.name,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'UserName',
                          prefixIcon:
                              Icon(Icons.supervised_user_circle_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          hintText: 'xyz999',
                          // enabled: false,
                        ),
                        textAlign: TextAlign.center,
                        validator: (userName) {
                          if (userName == null || userName.trim().length < 4) {
                            return 'Username must be atleast 4 characters long';
                          }
                          return null;
                        },
                        onSaved: (userName) {
                          _userName = userName;
                        },
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      key: ValueKey<String>('password'),
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.password),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: '🔑',
                        // enabled: false,
                      ),
                      obscureText: true,
                      textAlign: TextAlign.center,
                      validator: (password) {
                        if (password == null || password.trim().length < 7) {
                          return 'Password mush be atleast 7 characters long.';
                        }
                        return null;
                      },
                      onSaved: (password) {
                        _userPassword = password;
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    widget.isLoading
                        ? CircularProgressIndicator()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                onPressed: _trySubmit,
                                icon: Icon(_isLogin
                                    ? Icons.done
                                    : Icons.account_circle_rounded),
                                label: Text(_isLogin ? 'Login' : 'SignUp'),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.blue.withOpacity(0.9)),
                                  fixedSize: MaterialStateProperty.all(
                                    Size(120, 45),
                                  ),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(15)),
                                    ),
                                  ),
                                ),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    _isLogin = !_isLogin;
                                  });
                                  //ivalidate the picked image
                                  _pickedImage=null;
                                },
                                icon: Icon(_isLogin
                                    ? Icons.account_circle_rounded
                                    : Icons.done),
                                label: Text(_isLogin ? 'SignUp' : 'Login'),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.blue.withOpacity(0.1),
                                  ),
                                  fixedSize:
                                      MaterialStateProperty.all(Size(120, 45)),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.horizontal(
                                          right: Radius.circular(15)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                  ],
                ),
              ),
            ),
          ),
      ],
    ),
        ));
  }
}
