import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());


  String fullName = '';
  String email = '';
  String password = '';



  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());

    try {
      // Firebase eklenecek


      await Future.delayed(const Duration(seconds: 2)); 

      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(errorMessage: e.toString()));
    }
  }

}
