// import 'package:flutter/material.dart';

// class SignUpForm extends StatelessWidget {
//   const SignUpForm({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.only(left: 36, right: 36),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: SingleChildScrollView(
//         padding: const EdgeInsets.all(36),
//         child: Form(
//             key: _form,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextFormField(
//                   decoration: const InputDecoration(labelText: 'Email Address'),
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (value) {
//                     if (value == null ||
//                         value.trim().isEmpty ||
//                         !value.contains('@')) {
//                       return 'Please enter a valid email';
//                     }
//                     return null;
//                   },
//                   onSaved: (newValue) {
//                     _enteredEmail = newValue!;
//                   },
//                 ),
//                 TextFormField(
//                   decoration: const InputDecoration(labelText: 'Password'),
//                   obscureText: true,
//                   validator: (value) {
//                     if (value == null || value.trim().length < 6) {
//                       return 'Please enter a valid password';
//                     }
//                     return null;
//                   },
//                   onSaved: (newValue) {
//                     _enteredPassword = newValue!;
//                   },
//                 ),
//                 if (!_isLogin)
//                   TextFormField(
//                     decoration:
//                         const InputDecoration(labelText: 'Confirm password'),
//                     obscureText: true,
//                     validator: (value) {
//                       if (value == null || value.trim().length < 6) {
//                         return 'Please enter a valid password';
//                       }
//                       return null;
//                     },
//                     onSaved: (newValue) {
//                       _enteredConfirmPassword = newValue!;
//                     },
//                   ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         minimumSize: const Size.fromHeight(40),
//                         backgroundColor: Theme.of(context).colorScheme.primary),
//                     onPressed: _submit,
//                     child: Text(
//                       _isLogin ? 'Log in' : 'Sign up',
//                       style: const TextStyle(fontSize: 16),
//                     )),
//                 TextButton(
//                   onPressed: () {
//                     setState(() {
//                       _isLogin = !_isLogin;
//                     });
//                   },
//                   child: Text(_isLogin
//                       ? 'Haven\'t got an account? Sign up.'
//                       : 'Already have an account? Log in.'),
//                 ),
//               ],
//             )),
//       ),
//     );
//   }
// }
