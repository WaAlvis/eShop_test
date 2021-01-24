class ProductModel {
  final String nameProduct;
  final String descriptionProduct;
  final String imageProduct;

  ProductModel({this.imageProduct, this.nameProduct, this.descriptionProduct});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    String imageUrl;
    Map<String, dynamic> imageJson = json['image'] as Map<String, dynamic>;

    if (imageJson != null) {
      imageUrl = imageJson['name'] as String;
    } else {
      imageUrl = 'https://bubbleerp.sysfosolutions.com/img/default-pro.jpg';
    }

    return ProductModel(
      imageProduct: imageUrl,
      nameProduct: json['name'] as String ?? 'Name not avalible',
      descriptionProduct: json['description'] as String ?? 'La descripcion de este producto no se encuentra temporalmente',
    );
  }
}