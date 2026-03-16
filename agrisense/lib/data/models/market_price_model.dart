class MarketPriceModel {
  final String crop;
  final String price;
  final String demand;
  final String demandType;

  const MarketPriceModel({
    required this.crop,
    required this.price,
    required this.demand,
    required this.demandType,
  });

  factory MarketPriceModel.fromJson(Map<String, dynamic> json) {
    return MarketPriceModel(
      crop: json['crop'],
      price: json['price'],
      demand: json['demand'],
      demandType: json['demand_type'],
    );
  }
}
