abstract class AppStateA {}

class MyAppInitial extends AppStateA {}

class LoadingState extends AppStateA {}

class ErrorState extends AppStateA {}

class DoneState extends AppStateA {}

class PickImagesState extends AppStateA {}


class GetSum extends AppStateA {}

// for login
class LoginLoadingState extends AppStateA {}

class LoginErrorState extends AppStateA {
  final String error;
  LoginErrorState(this.error);
}

class LoginDoneState extends AppStateA {}

// for create acc
class CreateAccLoadingState extends AppStateA {}

class CreateAccErrorState extends AppStateA {
  final String error;
  CreateAccErrorState(this.error);
}

class CreateAccDoneState extends AppStateA {}


// for get user data
class GetDatDoneState extends AppStateA {}

class GetDatLoadingState extends AppStateA {}

class GetDatErrorState extends AppStateA {
  final String error;
  GetDatErrorState(this.error);

}
// for upload image
class UploadDoneState extends AppStateA {}

class UploadLoadingState extends AppStateA {}

class UploadErrorState extends AppStateA {
  final String error;
  UploadErrorState(this.error);
}
