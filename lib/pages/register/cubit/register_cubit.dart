import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  String fullName = '';
  String email = '';
  String password = '';

  void setFullName(String value) {
    fullName = value;
    emit(RegisterSetString());
  }

  void setEmail(String value) {
    email = value;
    emit(RegisterSetString());
  }

  void setPassword(String value) {
    password = value;
    emit(RegisterSetString());
  }

  void register(String fullName, String email, String password) {}
}
