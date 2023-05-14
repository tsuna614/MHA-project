import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, required this.activateToken});

  final void Function() activateToken;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();
  var _isLogin = true;
  var _enteredEmail = '';
  var _enteredPassword = '';
  var _enteredConfirmPassword = '';

  void _submit() {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('test@gmail.com - 123456')));
      return;
    }

    _form.currentState!.save();

    if (_isLogin) {
      print(_enteredEmail);
      print(_enteredPassword);
      if (_enteredEmail == 'test@gmail.com' && _enteredPassword == '123456') {
        widget.activateToken();
      }
    }
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
                  'assets/images/logo.jpg',
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
                          if (!_isLogin)
                            TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Confirm password'),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.trim().length < 6) {
                                  return 'Please enter a valid password';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                _enteredConfirmPassword = newValue!;
                              },
                            ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size.fromHeight(40),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary),
                              onPressed: _submit,
                              child: Text(
                                _isLogin ? 'Log in' : 'Sign up',
                                style: const TextStyle(fontSize: 16),
                              )),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            },
                            child: Text(_isLogin
                                ? 'Haven\'t got an account? Sign up.'
                                : 'Already have an account? Log in.'),
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
