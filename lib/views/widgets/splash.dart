// import 'package:flutter/material.dart';

// class Splash extends StatefulWidget {
//   @override
//   State<Splash> createState() => _SplashState();
// }

// class _SplashState extends State<Splash> {
//   @override
//   Widget build(BuildContext context) {
//     return Builder(builder: (context) {
//       Future loading() async {
//         await Future.delayed(const Duration(seconds: 2), () {
//           Navigator.pushReplacementNamed(context, '/home');
//         });
//       }

//       return Scaffold(
//         body: Container(
//           padding: const EdgeInsets.all(10.0),
//           width: MediaQuery.of(context).size.width,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               FutureBuilder(
//                 future: loading(),
//                 builder: (BuildContext context, AsyncSnapshot snapshot) {
//                   if (snapshot.data == null) {
//                     return SizedBox(
//                       child: ,
//                     );
//                   }
//                   return Container();
//                 },
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }
