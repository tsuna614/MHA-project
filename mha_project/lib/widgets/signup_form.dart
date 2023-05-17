import 'package:flutter/material.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key, required this.form});

  final GlobalKey<FormState> form;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Welcome aboard!',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(height: 30),
              Text('Let\'s help you meet up with your tasks'),
              const SizedBox(height: 30),
              Card(
                margin: const EdgeInsets.only(left: 36, right: 36),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(36),
                  child: Form(
                    key: form,
                    child: Column(),
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
