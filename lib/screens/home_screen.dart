

import 'package:flutter/material.dart';
import 'package:flutter_example/screens/all_users.dart';
import 'package:flutter_example/screens/widgets/user_single_item.dart';
import 'package:flutter_example/utils/colors.dart';
import 'package:flutter_example/utils/tools.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../model/UserResponse.dart';
import 'controllers/user_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final UserController favoriteController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 60),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "Hello, Welcome Back",
                  style: TextStyle(
                    color: primaryTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                  ),
                ),
                Image.asset(
                  "assets/images/hello.png",
                  width: 30,
                  height: 30,
                ),
              ],
            ),

            Obx(() {

              List<User> favoriteUsers = favoriteController.users
                  .where((user) => user.isFavorite.value)
                  .toList();

              if (favoriteUsers.isEmpty) {
                return Center(
                  child: Text("No favorite users yet.", style: TextStyle(color: textHintColor)),
                );
              }

              return ListView.builder(
                itemCount: favoriteUsers.length,
                itemBuilder: (context, index) {
                  final user = favoriteUsers[index];
                  return singleItemCard(user, favoriteController);
                },
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: (){
          navigateTo(context, AllUsers());
        },
        child: Card(
          margin: EdgeInsets.only(left: 15, right: 15, bottom: 30),
          color: primaryTextColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Add Favourite Item",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
        ),
      )
    );
  }
}
