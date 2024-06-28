import 'package:bloc/bloc.dart';
import 'package:bloc_project/features/auth/data/model/user_model.dart';
import 'package:bloc_project/features/auth/data/model/user_response.dart';
import 'package:bloc_project/features/auth/domain/usecases/auth_sign_up_usecase.dart';
import 'package:bloc_project/features/auth/domain/usecases/user_login_usecase.dart';
import 'package:bloc_project/features/auth/presentation/bloc/auth_event.dart';
import 'package:bloc_project/features/auth/presentation/bloc/auth_state.dart';
import 'package:bloc_project/features/auth/presentation/widgets/error_code.dart';
import 'package:bloc_project/features/doctor/data/remote_datasource/doctor_remote_data_source.dart';
import 'package:bloc_project/utils/validation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUseCase register;
  final LoginUseCase login;
  final RemoteDataSource remoteDataSource;
  final Function(String) navigate;

  AuthBloc(
      {required this.remoteDataSource,
      required this.register,
      required this.navigate,
      required this.login})
      : super(AuthInitial()) {
    registerEventHandlers();
  }

  void registerEventHandlers() {
    on<RegisterRequested>(_onRegisterRequested);
    on<LoginUser>(_onLoginRequested);
    on<RememberMeChanged>(_onRememberMeChanged);
    on<AuthNameChanged>(_onNameChanged);
    on<AuthEmailChanged>(_onEmailChanged);
    on<AuthPasswordChanged>(_onPasswordChanged);
    on<AuthPhoneNumberChanged>(_onPhoneNumberChanged);
    on<AuthConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<AuthRoleChanged>(_onRoleChanged);
  }

  void _onRegisterRequested(
      RegisterRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final userRegister = event.userRegister;

    if (!_isValidRegistration(userRegister)) {
      emit(const AuthFailure(
        message: 'Invalid registration form inputs',
        errorCode: AuthErrorCode.registrationError,
      ));
      return;
    }

    try {
      final result = await register.registerUser(userRegister);

      result.fold(
        (failureMessage) => emit(AuthFailure(
            errorCode: AuthErrorCode.registrationError,
            message: failureMessage)),
        (userModel) {
          final role = userModel.role.toShortString();
          final uid = userModel.uId ?? '';
          emit(AuthSuccess(
            uid: uid,
            role: role,
          ));
        },
      );
    } catch (e) {
      emit(AuthFailure(
        errorCode: AuthErrorCode.registrationError,
        message: 'Failed to register user: $e',
      ));
    }
  }

  void _onLoginRequested(LoginUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final result = await login.loginUser(event.login);
      result.fold(
          (failure) => emit(const AuthFailure(
              message: 'invalid Data',
              errorCode: AuthErrorCode.loginError)), (userData) {
        final role = userData['role'] as String;
        final uid = userData['uId'];
        DateTime selectedDate = DateTime.now();
        String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

        emit(AuthSuccess(
          uid: uid,
          role: role,
        ));

        Future.microtask(() {
          if (role == 'doctor') {
            event.context.go('/doctor/$uid/$formattedDate');
          } else if (role == 'patient') {
            event.context.go('/patient/$uid');
          }
        });
      });
    } catch (e) {
      emit(AuthFailure(
        errorCode: AuthErrorCode.loginError,
        message: 'Failed to login user: $e',
      ));
    }
  }

  void _onRememberMeChanged(
      RememberMeChanged event, Emitter<AuthState> emit) async {
    if (state is AuthSuccess) {
      final currentState = state as AuthSuccess;
      final updatedState = currentState.copyWith(rememberMe: event.value);
      emit(updatedState);
    }
  }

  bool _isValidRegistration(UserModel userRegister) {
    return userRegister.email.isValidEmail() &&
        userRegister.password.isValidPassword() &&
        userRegister.name.isValidName() &&
        userRegister.mobileNumber.isValidPhone() &&
        userRegister.password == userRegister.confirmpassword &&
        (userRegister.role == UserRole.doctor ||
            userRegister.role == UserRole.patient);
  }

  void _onEmailChanged(AuthEmailChanged event, Emitter<AuthState> emit) {
    final currentState =
        state is AuthFormState ? state as AuthFormState : AuthFormState();
    emit(currentState.copyWith(isEmailValid: event.email.isValidEmail()));
  }

  void _onPasswordChanged(AuthPasswordChanged event, Emitter<AuthState> emit) {
    final currentState =
        state is AuthFormState ? state as AuthFormState : AuthFormState();
    emit(currentState.copyWith(
        isPasswordValid: event.password.isValidPassword()));
  }

  void _onNameChanged(AuthNameChanged event, Emitter<AuthState> emit) {
    final currentState =
        state is AuthFormState ? state as AuthFormState : AuthFormState();
    emit(currentState.copyWith(isNameValid: event.name.isValidName()));
  }

  void _onPhoneNumberChanged(
      AuthPhoneNumberChanged event, Emitter<AuthState> emit) {
    final currentState =
        state is AuthFormState ? state as AuthFormState : AuthFormState();
    emit(currentState.copyWith(
        isPhoneNumberValid: event.phoneNumber.isValidPhone()));
  }

  void _onConfirmPasswordChanged(
      AuthConfirmPasswordChanged event, Emitter<AuthState> emit) {
    final currentState =
        state is AuthFormState ? state as AuthFormState : AuthFormState();
    emit(currentState.copyWith(
      isConfirmPasswordValid: event.confirmPassword.isValidPassword() &&
          event.confirmPassword == event.password,
    ));
  }

  void _onRoleChanged(AuthRoleChanged event, Emitter<AuthState> emit) {
    final currentState =
        state is AuthFormState ? state as AuthFormState : AuthFormState();
    final newRole = event.role == 'doctor' ? UserRole.doctor : UserRole.patient;
    emit(currentState.copyWith(role: newRole));
  }
}
