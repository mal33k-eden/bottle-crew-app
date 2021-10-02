import 'package:bottle_crew/services/auth.dart';
import 'package:bottle_crew/shared/loader.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleAuthView;
  const SignIn({required this.toggleAuthView, Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _sigininFormKey = GlobalKey<FormState>();
  final emailFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();
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
        ? const Loader()
        : Scaffold(
            backgroundColor: Colors.amber[100],
            appBar: AppBar(
              backgroundColor: Colors.amber[400],
              elevation: 0.0,
              title: const Text('Sign in to Palmy Crew'),
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Column(
                children: [
                  Form(
                    key: _sigininFormKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.brown),
                              ),
                              border: OutlineInputBorder(),
                              label: Text('E-mail'),
                              hintText: 'enter valid email'),
                          // The validator receives the text that the user has entered.
                          validator: validateTextFied,
                          controller: emailFieldController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField(
                          items: <String>['A', 'B', 'C', 'D'].map((t) {
                            return DropdownMenuItem(value: t, child: Text(t));
                          }).toList(),
                          onChanged: (_) {},
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.brown),
                              ),
                              border: OutlineInputBorder(),
                              label: Text('Password'),
                              // icon: Icon(Icons.lock),
                              hintText: 'enter your password'),
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
                            if (_sigininFormKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')));
                              siginInWithENP();
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
                          const Text('Don\'t have an account? '),
                          TextButton.icon(
                              onPressed: () {
                                print('xli');
                                widget.toggleAuthView();
                              },
                              icon: Icon(Icons.app_registration),
                              label: Text('Register'))
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

  void siginInWithENP() async {
    setState(() {
      loading = true;
    });
    dynamic result = await _auth.signinWithEmailAndPassword(
        email: emailFieldController.text,
        password: passwordFieldController.text);
    if (result == null) {
      setState(() {
        loading = false;
        var errorMsgs = 'username or password incorrect';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            errorMsgs,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
        ));
      });
    }
  }
}
