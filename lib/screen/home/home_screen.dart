import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm/data/response/status.dart';
import 'package:getx_mvvm/res/components/general_exception_widget.dart';
import 'package:getx_mvvm/res/components/internet_exception_widget.dart';
import 'package:getx_mvvm/res/routes/routes_name.dart';
import 'package:getx_mvvm/view_model/controller/home/home_view_model.dart';
import 'package:getx_mvvm/view_model/controller/user_preference/user_preferences_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel homeViewModel = HomeViewModel();
  UserPreferences userpreferences = UserPreferences();

  @override
  void initState() {
    homeViewModel.userListApi();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              userpreferences.removeUser().then((value) {
                Get.toNamed(RoutesName.loginScreen);
              }).onError((error, stackTrace) {});
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Obx(() {
        switch (homeViewModel.rxRequestStatus.value) {
          case Status.LOADING:
            return Center(
              child: CircularProgressIndicator(),
            );
          case Status.ERROR:
            if (homeViewModel.error.toString() == 'No intenet') {
              return InternetExceptionWidget(
                onPress: () {
                  homeViewModel.userListApi();
                },
              );
            } else {
              return GeneralExceptionWidget(onPress: (){
                homeViewModel.refreshApi();
              });
            }
          case Status.COMPLETED:
            return ListView.builder(
                itemCount: homeViewModel.userList.value.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(homeViewModel
                            .userList.value.data![index].avatar
                            .toString()),
                      ),
                      title: Text(homeViewModel
                          .userList.value.data![index].firstName
                          .toString()),
                      subtitle: Text(homeViewModel
                          .userList.value.data![index].email
                          .toString()),
                    ),
                  );
                });
        }

        return SizedBox();
      }),
    );
  }
}
