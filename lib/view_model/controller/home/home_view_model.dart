import 'package:get/get.dart';
import 'package:getx_mvvm/data/response/status.dart';
import 'package:getx_mvvm/models/home/user_list_model.dart';
import 'package:getx_mvvm/repository/home_repository/home_repository.dart';

class HomeViewModel extends GetxController {
  final _api = HomeRepository();

  final rxRequestStatus=Status.LOADING.obs;
  final userList=UserListModel().obs;
  RxString error=''.obs;

  void setrxRequestStatus(Status _value)=>rxRequestStatus.value=_value;
  void setUserList(UserListModel _value)=>userList.value=_value;
  void setError(String _value)=>error.value=_value;

  void userListApi() {
    _api.userListApi().then((value) {
      setrxRequestStatus(Status.COMPLETED);
      setUserList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setrxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setrxRequestStatus(Status.LOADING);
    _api.userListApi().then((value) {
      setrxRequestStatus(Status.COMPLETED);
      setUserList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setrxRequestStatus(Status.ERROR);
    });
  }
}
