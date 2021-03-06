class ProductModel {
  final String nameProduct;
  final String descriptionProduct;
  final Map<String, dynamic> imageProduct;

  ProductModel({this.nameProduct, this.descriptionProduct, this.imageProduct});

  String getImageProd(productList, i) {
    String imageUrl;

    if (productList.elementAt(i)?.imageProduct?.containsKey('name') == true) {
      imageUrl = productList.elementAt(i).imageProduct['name'];
    } else {
      imageUrl = 'https://forestprod.org/global_graphics/default-store-350x350.jpg';
    }
    return imageUrl;
  }

  String getNameProd(productList, i) {
    String nameUrl = productList[i].nameProduct ?? 'NOMBRE DEL PRODUCTO';
    return nameUrl;
  }

  String getDescriptionProd(productList, i) {
    String descriptionUrl = productList[i].descriptionProduct ?? 'Description of product';
    return descriptionUrl;
  }
}
