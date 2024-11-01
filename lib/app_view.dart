import 'package:flutter/material.dart';
import 'package:flutter_app_basic/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/auth/views/welcome_screen.dart';
import 'screens/home/views/home_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      debugShowCheckedModeBanner: false,  
      theme:ThemeData(
        colorScheme: ColorScheme.light(
          primary: Colors.blue,
          
        )
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if(state.status == AuthenticationStatus.authenticated){
             return HomeScreen();
          } else{
            return  WelcomeScreen();
          }
        },
      ),
    );
  }
}