
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api_handler/api_call.dart';
import '../../model/UserResponse.dart';

class UserController extends GetxController{

  //late UserResponse userResponse;
  // String jsonData = '''{
  //     "page": 2,
  //     "per_page": 6,
  //     "total": 12,
  //     "total_pages": 2,
  //     "data": [
  //       {
  //         "id": 7,
  //         "email": "michael.lawson@reqres.in",
  //         "first_name": "Michael",
  //         "last_name": "Lawson",
  //         "avatar": "https://reqres.in/img/faces/7-image.jpg"
  //       },
  //       {
  //         "id": 8,
  //         "email": "lindsay.ferguson@reqres.in",
  //         "first_name": "Lindsay",
  //         "last_name": "Ferguson",
  //         "avatar": "https://reqres.in/img/faces/8-image.jpg"
  //       }
  //     ],
  //     "support": {
  //       "url": "https://contentcaddy.io?utm_source=reqres&utm_medium=json&utm_campaign=referral",
  //       "text": "Tired of writing endless social media content? Let Content Caddy generate it for you."
  //     }
  //   }''';
  // //userResponse = userResponseFromJson(jsonData);

  var users = <User>[].obs;
  var isLoading = false.obs;
  var page = 1.obs;
  var hasMoreData = true.obs;
  var searchQuery = "".obs;
  var favoriteUsers = <User>[].obs;

  @override
  void onInit() {
    fetchUsers();
    loadFavorites();
    super.onInit();
  }

  void toggleFavorite(User user) {
    user.isFavorite.value = !user.isFavorite.value;
    _saveFavoriteStatus();
  }

  Future<void> _saveFavoriteStatus() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> favoriteIds = filteredUsers
        .where((user) => user.isFavorite.value)
        .map((user) => user.email.toString())
        .toList();

    print("ids: "+favoriteIds.toString());

    await prefs.setStringList('favorite_users', favoriteIds);


    // Update favoriteUsers list immediately
    favoriteUsers.assignAll(users.where((user) => user.isFavorite.value));

  }




  Future<void> loadFavorites() async {

    fetchUsers();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteIds = prefs.getStringList('favorite_users');

    print("ids: $favoriteIds");
    print("ids: $users");

    if (favoriteIds != null) {

      for (var user in users) {
        if (favoriteIds.contains(user.email.toString())) {
          user.isFavorite.value = true;
          print("user :${user.email}");
        }
        favoriteUsers.assignAll(users.where((user) => user.isFavorite.value));
      }

    }

  }


  void fetchUsers() async {
    if (isLoading.value || !hasMoreData.value) return;

    isLoading(true);
    try {
      UserResponse userResponse = await UserService.fetchUsers(page.value);

      if (userResponse.data.isEmpty) {
        hasMoreData(false);
      } else {
        users.addAll(userResponse.data);
        page.value++; // Increment page
      }
    } catch (e) {
      print("Error fetching users: $e");
    }

    print("USER :"+users.value.first.email);
    isLoading(false);
  }


  List<User> get filteredUsers {
    if (searchQuery.value.isEmpty) {
      return users;
    } else {
      return users.where((user) {
        return user.firstName.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
            user.lastName.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
            user.email.toLowerCase().contains(searchQuery.value.toLowerCase());
      }).toList();
    }
  }


  void searchUsers(String query) {
    searchQuery.value = query;
  }

}