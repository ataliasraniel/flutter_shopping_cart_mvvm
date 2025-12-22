mixin ApiErrorHandlerMixin {
  //!! Melhorar para suportar exceptions do dio, exceptions customizadas, etc.
  String handleApiError(Object e) {
    switch (e.toString()) {
      case 'Exception: Requisição inválida. Por favor, verifique os dados enviados.':
        return 'Requisição inválida. Por favor, verifique os dados enviados.';
      case 'Exception: Não autorizado. Por favor, faça login novamente.':
        return 'Não autorizado. Por favor, faça login novamente.';
      case 'Exception: Estamos enfrentando problemas técnicos =(':
        return 'Estamos enfrentando problemas técnicos =(';
      default:
        return 'Ocorreu um erro desconhecido.';
    }
  }
}
