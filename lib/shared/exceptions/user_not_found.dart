class UserNotFoundException implements Exception {
  String message() => "Usuário não encontrado ou desativado";
}
