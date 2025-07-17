import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/pages/login/cubit/login_cubit.dart';
//import 'cubit/register_state.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    return BlocProvider(

      create: (context)=>LoginCubit(),
      child:SafeArea(
        top:false,
        child: Scaffold(
          appBar: AppBar(title:const Text("Login")),
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
                    final email=_emailController.text.trim();
                    final password= _passwordController.text.trim();
                  
                  print('Login with: $email, $password');

                  }, child: const Text('Login'),
                  
                  



                ),

                //),


                
                




            ],)

          )



        )
      
      
      
      )




    );
  }
}