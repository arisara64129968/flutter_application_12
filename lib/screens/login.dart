import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_12/models/config.dart';
import 'package:flutter_application_12/models/users.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class Login extends StatefulWidget {
  static const routeName = '/login';
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  Users user = Users();

  // String email = '';
  // String password = '';
  Future<void> login(Users user) async {
    var params = {'email': user.email, 'password': user.password};

    var url = Uri.http(Configure.server, 'users', params);
    var resp = await http.get(url);
    print(resp.body);
    List<Users> login_result = usersFromJson(resp.body);
    print(login_result.length);
    if (login_result.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('username or password invalid')));
    } else {
      Configure.login = login_result[0];
      Navigator.pushNamed(context, Home.routeName);
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        child: Form(
            key: _formkey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              textHeader(),
              emailInputField(),
              passwordInputField(),
              SizedBox(
                height: 10,
              ),
              Row(children: [
                submitButton(),
                SizedBox(
                  width: 10,
                ),
                backButton(),
                SizedBox(
                  width: 10,
                ),
                registerLink()
              ])
            ])),
      ),
    );
  }

  Widget textHeader() {
    return InkWell(
      child: Center(
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Widget fnameInputField() {
    return TextFormField(
      initialValue: "Arisara Jiamsakul",
      decoration:
          InputDecoration(labelText: 'Fullname', icon: Icon(Icons.person)),
      validator: (value) {
        if (value!.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
      onSaved: (newValue) => user.fullname = newValue,
    );
  }

  Widget emailInputField() {
    return TextFormField(
      initialValue: 'a@test.com',
      decoration: InputDecoration(
        labelText: 'Email:',
        hintText: 'input your email',
        icon: Icon(Icons.email),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'This field is required!';
        }
        if (!EmailValidator.validate(value)) {
          return 'It is not email format';
        }
        return null;
      },
      onSaved: (newValue) => user.email = newValue!,
    );
  }

  Widget passwordInputField() {
    return TextFormField(
      initialValue: '1q2w3e4r',
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password:',
        hintText: 'input your password',
        icon: Icon(Icons.lock),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
      onSaved: (newValue) => user.password = newValue!,
    );
  }

  Widget submitButton() {
    return ElevatedButton(
        onPressed: () {
          if (_formkey.currentState!.validate()) {
            _formkey.currentState!.save();
            print(user.toJson().toString());
            login(user);
          }
        },
        child: Text('Login'));
  }

  Widget backButton() {
    return ElevatedButton(onPressed: () {}, child: Text('Back'));
  }

  Widget registerLink() {
    return InkWell(
      child: const Text('Sign Up'),
      onTap: () {},
    );
  }
}
