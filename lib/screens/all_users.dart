import 'package:flutter/material.dart';
import 'package:flutter_example/screens/widgets/user_single_item.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../utils/colors.dart';
import 'widgets/input_decoration_searchbar.dart';
import 'controllers/user_controller.dart';

class AllUsers extends StatefulWidget {
  const AllUsers({super.key});

  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {

  final UserController userController = Get.put(UserController());
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        userController.fetchUsers();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0, // Removes shadow
        leading: IconButton(
          icon: Image.asset(
            "assets/icons/arrow.png",
            width: 20,
            height: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Search",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: primaryTextColor,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true, // Aligns title to the left
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 1,
            color: textHintColor.withOpacity(0.3),
          ),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              onChanged: userController.searchUsers,
              decoration: searchInputDecoration(
                borderColor: Colors.grey,
                hintColor: Colors.grey[400],
              ),
            ),
          ),

          SizedBox(height: 20),

          // User List with Pagination
          Expanded(
            child: Obx(() {
              if (userController.isLoading.value && userController.users.isEmpty) {
                return Center(child: CircularProgressIndicator()); // Initial loading
              }

              if (userController.filteredUsers.isEmpty) {
                return Center(child: Text("No users found.", style: TextStyle(color: textHintColor)));
              }

              return ListView.builder(
                controller: scrollController,
                itemCount: userController.filteredUsers.length + (userController.hasMoreData.value ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == userController.filteredUsers.length) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final user = userController.filteredUsers[index];
                  return singleItemCard(user, userController);

                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
