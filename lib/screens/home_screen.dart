

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
  void initState() {
    // TODO: implement initState
    super.initState();
    favoriteController.fetchUsers();
    Future.delayed(Duration(seconds: 2), () {
      favoriteController.loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [

          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 60),
            child: Row(
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
          ),

          Expanded(
            child: Obx(() {

              List<User> favoriteUsers = favoriteController.users
                  .where((user) => user.isFavorite.value)
                  .toList();


              if (favoriteController.favoriteUsers.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          "No items to show now.",
                          style: TextStyle(color: textHintColor, fontSize: 16)
                      ),
                      Text(
                          "Please add some favorite items to see here.",
                          style: TextStyle(color: textHintColor)
                      )
                    ],
                  ),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Text(
                        "Favourite Items",
                      style: TextStyle(
                          color: primaryTextColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),

                  Expanded(
                    child: ListView.builder(
                      itemCount: favoriteController.favoriteUsers.length,
                      itemBuilder: (context, index) {
                        final user = favoriteController.favoriteUsers[index];
                        return singleItemCard(user, favoriteController);
                      },
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
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
