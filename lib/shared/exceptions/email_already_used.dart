class EmailAlreadyUsedException implements Exception {
  String message() => "O email já está sendo usado";
}
