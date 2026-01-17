class Order {
  final String id;
  final String date;
  final String shopName;
  final String shopLogo;
  final double totalAmount;
  final String status;
  final String deliveryStatus;
  final int itemCount;
  final String firstItemName;
  final int otherItemsCount;

  Order({
    required this.id,
    required this.date,
    required this.shopName,
    required this.shopLogo,
    required this.totalAmount,
    required this.status,
    required this.deliveryStatus,
    required this.itemCount,
    required this.firstItemName,
    required this.otherItemsCount,
  });
}
