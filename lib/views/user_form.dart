import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/user_controller.dart';
import '../models/user_model.dart';

class UserForm extends StatefulWidget {
  final User? user;
  final int? index;

  UserForm({this.user, this.index});

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _accountSidController = TextEditingController();
  final TextEditingController _authTokenController = TextEditingController();
  final TextEditingController _fromNumberController = TextEditingController();
  final TextEditingController _toNumberController = TextEditingController();
  final UserController _userController = UserController();

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _usernameController.text = widget.user!.username;
      _accountSidController.text = widget.user!.accountSid;
      _authTokenController.text = widget.user!.authToken;
      _fromNumberController.text = widget.user!.fromNumber;
      _toNumberController.text = widget.user!.toNumber;
    }
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', _usernameController.text);
      await prefs.setString('account_sid', _accountSidController.text);
      await prefs.setString('auth_token', _authTokenController.text);
      await prefs.setString('from_number', _fromNumberController.text);
      await prefs.setString('to_number', _toNumberController.text);

      final user = User(
        username: _usernameController.text,
        accountSid: _accountSidController.text,
        authToken: _authTokenController.text,
        fromNumber: _fromNumberController.text,
        toNumber: _toNumberController.text,
      );

      try {
        if (widget.user == null) {
          await _userController.addUser(user);
        } else {
          await _userController.updateUser(widget.index!, user);
        }
        Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save user: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user == null ? 'Add User' : 'Edit User'),
        backgroundColor: Color(0xff223cbf),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  icon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _accountSidController,
                decoration: InputDecoration(
                  labelText: 'Account SID',
                  icon: Icon(Icons.account_circle),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an Account SID';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _authTokenController,
                decoration: InputDecoration(
                  labelText: 'Auth Token',
                  icon: Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an Auth Token';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _fromNumberController,
                decoration: InputDecoration(
                  labelText: 'From Number',
                  icon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a From Number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _toNumberController,
                decoration: InputDecoration(
                  labelText: 'To Number',
                  icon: Icon(Icons.phone_iphone),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a To Number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text(widget.user == null ? 'Add User' : 'Update User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
