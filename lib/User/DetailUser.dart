import 'package:flutter/material.dart';
import 'package:pbl_project/User/UserModel.dart';


class DetailUser extends StatelessWidget {
  const DetailUser({super.key, required this.usermodel});
  final UserModel usermodel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 0),
              child: Text(
                "Detail Data User",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('ID User:'), Text('${usermodel.id}')],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Nama :'), Text('${usermodel.name}')],
            ),
            const SizedBox(
              height: 10,
            ),
           
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Email:'), Text('${usermodel.email}')],
            ),
            const SizedBox(
              height: 10,
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Roles:'), Text('${usermodel.roles}')],
            ),
           
          ],
        ),
      ),
    );
  }
}
