class CheckoutResponseModel {
  final String message;
  final bool success;
  final int orderId;
  CheckoutResponseModel({this.message = 'Checkout realizado com sucesso!', this.success = true, this.orderId = 0});
}
