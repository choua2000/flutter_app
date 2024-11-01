// import 'package:flutter/material.dart';

// class WelcomeScreen extends StatelessWidget {
//   const WelcomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         padding: EdgeInsets.all(20.0),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.blueAccent, Colors.lightBlue],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Image.asset(
//               'images/1.png', // Add an image in your assets folder
//               height: 200,
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Welcome to MyApp!',
//               style: TextStyle(
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Your journey starts here.',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.white70,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 40),
//             ElevatedButton(
//               onPressed: () {
//                 // Navigate to another screen, such as HomeScreen
//                 // Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
//               },
//               style: ElevatedButton.styleFrom(
//                 padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                 backgroundColor: Colors.white,
//               ),
//               child: Text(
//                 'Get Started',
//                 style: TextStyle(
//                   color: Colors.blueAccent,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/authentication_bloc/authentication_bloc.dart';
import '../blocs/sigin_bloc/sign_in_bloc.dart';
import '../blocs/sign_up_bloc/sign_up_bloc.dart';
import 'sigin_in_screen.dart';
import 'sign_up_screen.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {
	late TabController tabController;

	@override
  void initState() {
    tabController = TabController(
			initialIndex: 0,
			length: 2, 
			vsync: this
		);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
			backgroundColor: Theme.of(context).colorScheme.background,
			body: SingleChildScrollView(
				child: SizedBox(
					height: MediaQuery.of(context).size.height,
					child: Stack(
						children: [
							Align(
								alignment: const AlignmentDirectional(20, -1.2),
								child: Container(
									height: MediaQuery.of(context).size.width,
									width: MediaQuery.of(context).size.width,
									decoration: BoxDecoration(
										shape: BoxShape.circle,
										color: Theme.of(context).colorScheme.tertiary
									),
								),
							),
							Align(
								alignment: const AlignmentDirectional(2.7, -1.2),
								child: Container(
									height: MediaQuery.of(context).size.width / 1.3,
									width: MediaQuery.of(context).size.width / 1.3,
									decoration: BoxDecoration(
										shape: BoxShape.circle,
										color: Theme.of(context).colorScheme.primary
									),
								),
							),
							BackdropFilter(
								filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
								child: Container(),
							),
							Align(
								alignment: Alignment.center,
								child: SizedBox(
									height: MediaQuery.of(context).size.height / 1.8,
									child: Column(
										children: [
											Padding(
												padding: const EdgeInsets.symmetric(horizontal: 50.0),
												child: TabBar(
													controller: tabController,
													unselectedLabelColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
													labelColor: Theme.of(context).colorScheme.onBackground,
													tabs: const [
														Padding(
															padding: EdgeInsets.all(12.0),
															child: Text(
																'Sign In',
																style: TextStyle(
																	fontSize: 18,
																),
															),
														),
														Padding(
															padding: EdgeInsets.all(12.0),
															child: Text(
																'Sign Up',
																style: TextStyle(
																	fontSize: 18,
																),
															),
														),
													],
												),
											),
											Expanded(
												child: TabBarView(
													controller: tabController,
													children: [
														BlocProvider<SignInBloc>(
															create: (context) => SignInBloc(
																context.read<AuthenticationBloc>().userRepository
															),
															child: const SignInScreen(),
														),
														BlocProvider<SignUpBloc>(
															create: (context) => SignUpBloc(
																context.read<AuthenticationBloc>().userRepository
															),
															child: const SignUpScreen(),
														),
													],
												)
											)
										],
									),
								),
							)
						],
					),
				),
			),
		);
  }
}