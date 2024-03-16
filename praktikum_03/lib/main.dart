import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praktikum_03/bloc/contact_cubit.dart';
import 'package:praktikum_03/views/home_screen.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('Aplikasi Pertemuan 3')),
//         body: Container(
//           margin: EdgeInsets.only(top: 100, left: 50),
//           color: Colors.amber,
//           child: Text(
//             'Hello World!',
//             style: TextStyle(
//               color: Colors.lightBlueAccent,
//               fontSize: 50,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ContactCubit()
        ),
      ],
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}