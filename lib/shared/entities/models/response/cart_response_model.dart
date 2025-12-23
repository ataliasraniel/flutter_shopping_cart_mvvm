class CartResponseModel {
  final bool success;
  final String message;
  final CartResponseData? data;

  CartResponseModel({required this.success, required this.message, this.data});

  factory CartResponseModel.fromJson(Map<String, dynamic> json) {
    return CartResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] != null ? CartResponseData.fromJson(json['data'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, if (data != null) 'data': data!.toJson()};
  }
}

class CartResponseData {
  final int? productId;
  final int? quantity;
  final int? newQuantity;
  final int? itemsCount;
  final CartItemData? item;

  CartResponseData({this.productId, this.quantity, this.newQuantity, this.itemsCount, this.item});

  factory CartResponseData.fromJson(Map<String, dynamic> json) {
    return CartResponseData(
      productId: json['productId'] as int?,
      quantity: json['quantity'] as int?,
      newQuantity: json['newQuantity'] as int?,
      itemsCount: json['itemsCount'] as int?,
      item: json['item'] != null ? CartItemData.fromJson(json['item'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (productId != null) 'productId': productId,
      if (quantity != null) 'quantity': quantity,
      if (newQuantity != null) 'newQuantity': newQuantity,
      if (itemsCount != null) 'itemsCount': itemsCount,
      if (item != null) 'item': item!.toJson(),
    };
  }
}

class CartItemData {
  final int productId;
  final int quantity;
  final ProductData product;

  CartItemData({required this.productId, required this.quantity, required this.product});

  factory CartItemData.fromJson(Map<String, dynamic> json) {
    return CartItemData(
      productId: json['productId'] as int,
      quantity: json['quantity'] as int,
      product: ProductData.fromJson(json['product'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {'productId': productId, 'quantity': quantity, 'product': product.toJson()};
  }
}

class ProductData {
  final int id;
  final String title;
  final double price;
  final String image;

  ProductData({required this.id, required this.title, required this.price, required this.image});

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      id: json['id'] as int,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'price': price, 'image': image};
  }
}
