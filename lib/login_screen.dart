import 'package:flutter/material.dart';

class MyLoginPage extends StatefulWidget {
  bool isLoggedIn;
  Function? setLoggedIn;
  MyLoginPage({Key? key, this.isLoggedIn = false, this.setLoggedIn})
      : super(key: key);

  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final _emailEditingController = TextEditingController();
  final _passwordEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final email = 'siyahulhaq124@gmail.com';
  final password = 'Admin124';

  login() {
    var valid = _formKey.currentState!.validate();
    // print(valid);
    if (valid) {
      final email = _emailEditingController.text;
      final password = _passwordEditingController.text;

      if (email == this.email && password == this.password) {
        widget.setLoggedIn!(true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.primaries[0],
            behavior: SnackBarBehavior.floating,
            padding: const EdgeInsets.all(10),
            content: const Text('Login Failed'),
          ),
        );
      }
    }
    /* Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const MyHomePage())); */
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF151026);
    const inPrimaryColor = Color(0xFF151030);

    Widget input(
        {String hint = "",
        TextEditingController? controller,
        TextInputType? keyboardType,
        String? Function(String?)? validator,
        bool obscureText = false}) {
      return Container(
        margin: const EdgeInsets.all(10),
        child: TextFormField(
          validator: validator,
          obscureText: obscureText,
          textInputAction: TextInputAction.done,
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 20,
            ),
          ),
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      );
    }

    var addContainer = Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: inPrimaryColor),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: const Text(
                  "Login Page",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              input(
                hint: "Email",
                controller: _emailEditingController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => (value == null || value.isEmpty)
                    ? "Email is required"
                    : null,
              ),
              input(
                hint: "Password",
                controller: _passwordEditingController,
                keyboardType: TextInputType.text,
                obscureText: true,
                validator: (value) => (value == null || value.isEmpty)
                    ? "Password is required"
                    : null,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: login,
                  child: const Text('Login'),
                ),
              ),
            ],
          ),
        ));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: (Container(
        color: primaryColor,
        alignment: Alignment.center,
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: inPrimaryColor,
                  ),
                  child: addContainer)
            ],
          ),
        ),
      )),
    );
  }
}
