import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login/login_screen.dart';
import 'package:flutter_application_1/pages/register/cubit/register_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(title: Text("Register Screen")),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  TextFormField(decoration: InputDecoration(labelText: "Email")),
                  SizedBox(height: 16),
                  TextFormField(decoration: InputDecoration(labelText: "Password")),
                  SizedBox(height: 16),
                  OutlinedButton(onPressed: () {}, child: Text('Register')),
                  SizedBox(height: 64),
                  Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                    },
                    child: Text("Login"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
