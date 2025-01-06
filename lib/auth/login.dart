import 'package:coficabproject/dashbord/PageAcceuil.dart';
import 'package:flutter/material.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  TextEditingController logincontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  Color _loginLabelColor = Colors.grey;
  Color _passwordLabelColor = Colors.grey;
  final _formKey = GlobalKey<FormState>();
  // Variable to toggle password visibility
  bool _isPasswordVisible = false;

  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();

    _usernameFocusNode.addListener(() {
      setState(() {
        _loginLabelColor = _usernameFocusNode.hasFocus
            ? Color.fromARGB(255, 228, 228, 228)
            : Colors.grey;
      });
    });

    _passwordFocusNode.addListener(() {
      setState(() {
        _passwordLabelColor = _passwordFocusNode.hasFocus
            ? Color.fromARGB(255, 228, 228, 228)
            : Colors.grey;
      });
    });
  }

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset('assets/images/aradom.png'),
                  const SizedBox(
                    height: 60,
                  ),
                  Container(
                    padding: const EdgeInsets.all(18.0),
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color.fromARGB(255, 255, 255, 255),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text('Welcome to the Digital Era 4.0 with ARAMES',
                            style: TextStyle(
                              fontSize: 14,
                            )),
                        const SizedBox(height: 20),
                        TextField(
                          controller: logincontroller,
                          decoration: InputDecoration(
                            labelText: 'Identifier ',
                            labelStyle: TextStyle(color: _loginLabelColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 228, 228, 228),
                                  width: 2),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextField(
                          controller: passwordcontroller,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(color: _passwordLabelColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 228, 228, 228),
                                  width: 2),
                            ),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                )),
                          ),
                          obscureText: !_isPasswordVisible, // hidepassword
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PageAcceuil()),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32.0, vertical: 12.0), // Padding
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFFE4956),
                                    Color(0xFFF9B1B8),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: const Center(
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Color.fromARGB(
                                        255, 255, 255, 255), // Text color
                                    fontSize: 20.0, // Text size
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
