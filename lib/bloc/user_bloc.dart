import 'package:bloc/bloc.dart';
import 'package:pusat_bantuan/model/user_model.dart';

class UserBloc extends Bloc<String, UserModel> {
  @override
  UserModel get initialState => UninitializedUser();

  @override
  Stream<UserModel> mapEventToState(String uid) async* {
    try {
      UserModel user = await UserModel.getUserFromAuth(uid);
      yield user;
    } catch (e) {}
  }
}
