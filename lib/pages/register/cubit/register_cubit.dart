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
    fullName = value;
    emit(RegisterSetString());
  }
    void setPassword(String value) {
    fullName = value;
    emit(RegisterSetString());
  }

  Future<void> register(  email, ) async {
    emit(RegisterLoading());
    try {
      if (email.isEmpty || password.isEmpty || fullName.isEmpty) {
        throw Exception("Please fill all required fields");
      }



      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterError("An error occured: ${e.toString()}"));
    }




  }

  

  
}
