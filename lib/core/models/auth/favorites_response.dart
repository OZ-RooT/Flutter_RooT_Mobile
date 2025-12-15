class FavoritesResponse {
  final List<dynamic> products;
  final List<dynamic> garageSales;

  FavoritesResponse({
    required this.products,
    required this.garageSales,
  });

  factory FavoritesResponse.fromJson(Map<String, dynamic> json) {
    return FavoritesResponse(
      products: json['products'] ?? [],
      garageSales: json['garageSales'] ?? [],
    );
  }
}