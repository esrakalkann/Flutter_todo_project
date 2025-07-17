import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login/login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/pages/register/cubit/register_cubit.dart';
//import 'cubit/register_state.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    return BlocProvider(

      create: (context)=>RegisterCubit(),
      child:SafeArea(
        top:false,
        child: Scaffold(
          appBar: AppBar(title:const Text("Register")),
          body: SingleChildScrollView(
            padding:const EdgeInsets.symmetric(horizontal:16),
            child: Column(
              children: [
                const SizedBox(height:24),
                TextFormField(
                  controller:_emailController,
                  decoration: const InputDecoration(labelText: "Email"),


                ),
                TextFormField(
                  controller:_passwordController,
                  decoration: const InputDecoration(labelText: "Password"),
                  obscureText: true,

                ),
                const SizedBox(height: 24),
                OutlinedButton(
                  onPressed: () {
                
                  },
                  child: const Text('Register'),



                ),

                //),


                
                




            ],)

          )



        )
      
      
      
      )




    );
  }
}