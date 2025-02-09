

import 'package:flutter/material.dart';
import 'package:flutter_example/model/UserResponse.dart';
import 'package:flutter_example/screens/controllers/user_controller.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../utils/colors.dart';

Container singleItemCard(User user, UserController userController){

  return Container(

    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0), // Radius for rounded corners
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1), // Shadow color with opacity
          blurRadius: 4.0, // Blur radius
          offset: Offset(0, 1), // Offset for the shadow
        ),
      ],
    ),
    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          // Image on the left
          CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(user.avatar),
          ),
          SizedBox(width: 16.0), // Space between image and text
          // Information on the right
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name in the first line
                Text(
                  "Name:",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                    color: textHintColor,
                  ),
                ),
                Text(
                  "${user.firstName} ${user.lastName}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: primaryTextColor,
                  ),
                ),
                SizedBox(height: 4.0), // Space between name and email
                // Email in the next line
                Text(
                  "Email Address:",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                    color: textHintColor,
                  ),
                ),
                Text(
                  user.email,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: textHintColor,
                  ),
                ),
              ],
            ),
          ),
          // Image asset on the right
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            // child: Image.asset(
            //   'assets/images/fav.png', // Replace with your image path
            //   height: 40.0, // Adjust height as needed
            //   width: 40.0, // Adjust width as needed
            // ),
            child: Obx(() {
              return IconButton(
                icon: Icon(
                  user.isFavorite.value ? Icons.favorite : Icons.favorite_border,
                  color: user.isFavorite.value ? Colors.red : null,
                ),
                onPressed: () {
                  userController.toggleFavorite(user);
                },
              );
            }),
          ),
        ],
      ),
    ),
  );

}