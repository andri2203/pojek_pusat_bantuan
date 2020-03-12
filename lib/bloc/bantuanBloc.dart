import 'package:bloc/bloc.dart';
import 'package:pusat_bantuan/model/bantuan.dart';

class BantuanBloc extends Bloc<String, Bantuan> {
  @override
  Bantuan get initialState => Unselected();

  @override
  Stream<Bantuan> mapEventToState(String event) async* {
    try {
      Bantuan bantuan = Bantuan.setPilihan(event);
      yield bantuan;
    } catch (e) {}
  }
}
