import 'package:bottle_crew/services/auth.dart';
import 'package:bottle_crew/shared/loader.dart';
import 'package:bottle_crew/shared/textFieldDecorator.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleAuthView;
  const Register({required this.toggleAuthView, Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _registerFormKey = GlobalKey<FormState>();
  final emailFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();
  late String errorMsgs;
  bool loading = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    emailFieldController.dispose();
    passwordFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle btnStyle = ElevatedButton.styleFrom(
        primary: Colors.brown,
        textStyle: const TextStyle(fontSize: 25),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20));
    return loading
        ? Loader()
        : Scaffold(
            backgroundColor: Colors.amber[100],
            appBar: AppBar(
              backgroundColor: Colors.amber[400],
              elevation: 0.0,
              title: const Text('Register to Palmy Crew'),
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Column(
                children: [
                  Form(
                    key: _registerFormKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: textFieldDecorator.copyWith(
                              label: const Text('E-mail'),
                              hintText: 'Enter a valid email'),
                          // The validator receives the text that the user has entered.
                          validator: validateTextFied,
                          controller: emailFieldController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: textFieldDecorator.copyWith(
                              label: const Text('Password'),
                              hintText: 'Enter your password'),
                          validator: validatePassField,
                          controller: passwordFieldController,
                          obscureText: true,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: btnStyle,
                          onPressed: () async {
                            if (_registerFormKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')));

                              registerUser();
                            }
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Row(
                        children: [
                          const Text('Already have an account? '),
                          TextButton.icon(
                              onPressed: () {
                                widget.toggleAuthView();
                              },
                              icon: Icon(Icons.login),
                              label: Text('Sign In'))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }

  String? validateTextFied(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  String? validatePassField(String? value) {
    if (value!.length < 8) {
      return 'Password too weak';
    }
    return null;
  }

  void registerUser() async {
    setState(() {
      loading = true;
    });
    dynamic result = await _auth.registerWithEmailAndPassword(
        email: emailFieldController.text,
        password: passwordFieldController.text);
    if (result == null) {
      setState(() {
        loading = false;
        errorMsgs = 'Please supply a valid email';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMsgs),
          backgroundColor: Colors.red,
        ));
      });
    }
  }
}
