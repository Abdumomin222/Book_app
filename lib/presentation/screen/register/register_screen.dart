import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_bloc.dart';
import 'register_event.dart';
import 'register_state.dart';
import '../login/login_screen.dart';
import '../login/login_bloc.dart';
import '../../../data/repository/repository.dart'; // Adjust path as needed

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          } else if (state is RegisterSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider<LoginBloc>(
                  create: (context) => LoginBloc(AppRepository()),
                  child: const LoginScreen(),
                ),
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                height: 310,
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/images/img_splash1.png",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 310,
                    ),
                    Positioned(
                      top: 45,
                      left: 45,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: const [
                            Icon(Icons.arrow_back, color: Color(0xff787878)),
                            SizedBox(width: 8),
                            Text(
                              "Go Back",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff787878),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 105,
                      left: 40,
                      child: Image.asset(
                        "assets/images/img_headphone.png",
                        width: 108,
                        height: 100,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Create an Account",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Register to continue",
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      onChanged: (value) => context.read<RegisterBloc>().add(
                        RegisterUsernameChanged(value),
                      ),
                      decoration: const InputDecoration(
                        labelText: "Email Address",
                        labelStyle: TextStyle(color: Color(0xff787878)),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff787878)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      obscureText: true,
                      onChanged: (value) => context.read<RegisterBloc>().add(
                        RegisterPasswordChanged(value),
                      ),
                      decoration: const InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(color: Color(0xff787878)),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff787878)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      obscureText: true,
                      onChanged: (value) => context.read<RegisterBloc>().add(
                        RegisterConfirmPasswordChanged(value),
                      ),
                      decoration: const InputDecoration(
                        labelText: "Retype password",
                        labelStyle: TextStyle(color: Color(0xff787878)),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff787878)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: BlocBuilder<RegisterBloc, RegisterState>(
                        builder: (context, state) {
                          return SizedBox(
                            width: 204,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: state is RegisterLoading
                                  ? null
                                  : () => context.read<RegisterBloc>().add(
                                RegisterSubmitted(),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xffF26B6C),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              child: state is RegisterLoading
                                  ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor:
                                  AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                                  : const Text(
                                "REGISTER",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Center(
                      child: Text(
                        "or register using",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/ic_google.png",
                          width: 40,
                          height: 40,
                        ),
                        const SizedBox(width: 20),
                        Image.asset(
                          "assets/images/ic_facebook.png",
                          width: 40,
                          height: 40,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider<LoginBloc>(
                                  create: (context) => LoginBloc(AppRepository()),
                                  child: const LoginScreen(),
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}