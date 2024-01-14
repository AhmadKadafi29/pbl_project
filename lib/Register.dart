// import 'package:flutter/material.dart';
// import 'login_page.dart';

// class RegisterPage extends StatefulWidget {
//   const RegisterPage({Key? key}) : super(key: key);

//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         margin: const EdgeInsets.all(25),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(
//                 height: 80,
//               ),
//               Center(
//                 child: Image.asset(
//                   'assets/logo.png',
//                 ),
//               ),
//               const SizedBox(
//                 height: 40,
//               ),
//               const Text(
//                 "Register",
//                 style: TextStyle(
//                   fontSize: 30,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const TextField(
//                 decoration: InputDecoration(
//                   hintText: "Full Name",
//                   prefixIcon: Icon(Icons.person),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               const TextField(
//                 decoration: InputDecoration(
//                   hintText: "Email",
//                   prefixIcon: Icon(Icons.email),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               const TextField(
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   hintText: "Password",
//                   prefixIcon: Icon(Icons.lock),
//                   suffixIcon: Icon(Icons.remove_red_eye),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               const TextField(
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   hintText: "Confirm Password",
//                   prefixIcon: Icon(Icons.lock),
//                   suffixIcon: Icon(Icons.remove_red_eye),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 25,
//               ),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Implement logic untuk registrasi di sini
//                   },
//                   child: const Text("Register"),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(builder: (context) => const LoginPage()),
//                   );
//                 },
//                 child:
//                     const Center(child: Text("Already have an account? Login")),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
