import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mha_project/widgets/signup_form.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();
  var _isLogin = true;
  var _isLoading = false;

  var _enteredEmail = '';
  var _enteredPassword = '';
  var _enteredConfirmPassword = '';

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }

    _form.currentState!.save();

    if (!_isLogin && _enteredPassword != _enteredConfirmPassword) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please re-enter confirm password.'),
        ),
      );
      return;
    }

    try {
      setState(() {
        _isLoading = true;
      });
      if (_isLogin) {
        // log user in
        final userCredentials = await _firebase.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
        print(userCredentials);
      } else {
        // create new user
        final userCredential = await _firebase.createUserWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
        print(userCredential);
      }
    } on FirebaseAuthException catch (error) {
      _isLoading = false;

      if (error.code == 'email-already-in-use') {
        return;
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Authentication failed.'),
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _switchToSignUp() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SignUpForm(
          form: _form,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                    top: 30, bottom: 20, left: 20, right: 20),
                width: 150,
                child: Image.asset(
                  'assets/images/logo.png',
                ),
              ),
              const SizedBox(height: 36),
              Card(
                margin: const EdgeInsets.only(left: 36, right: 36),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(36),
                  child: Form(
                      key: _form,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Email Address'),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              _enteredEmail = newValue!;
                            },
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Password'),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return 'Please enter a valid password';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              _enteredPassword = newValue!;
                            },
                          ),
                          // if (!_isLogin)
                          //   TextFormField(
                          //     decoration: const InputDecoration(
                          //         labelText: 'Confirm password'),
                          //     obscureText: true,
                          //     validator: (value) {
                          //       if (value == null || value.trim().length < 6) {
                          //         return 'Please enter a valid password';
                          //       }
                          //       return null;
                          //     },
                          //     onSaved: (newValue) {
                          //       _enteredConfirmPassword = newValue!;
                          //     },
                          //   ),
                          const SizedBox(height: 20),
                          if (_isLoading) const CircularProgressIndicator(),
                          if (!_isLoading)
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(40),
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary),
                                onPressed: _submit,
                                child: const Text(
                                  'Log in',
                                  style: TextStyle(fontSize: 16),
                                )),
                          if (!_isLoading)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                                _switchToSignUp();
                              },
                              child: const Text(
                                  'Haven\'t got an account? Sign up.'),
                            ),
                        ],
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
