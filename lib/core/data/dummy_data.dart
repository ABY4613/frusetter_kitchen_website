import '../../model/delivery.dart';

class DummyData {
  static final List<Delivery> deliveries = [
    Delivery(
      id: 'DEL-001',
      customerName: 'John Doe',
      address: '123 Main St, Springfield',
      scheduledTime: DateTime.now().add(Duration(hours: 1)),
      driverName: 'Mike Ross',
      status: DeliveryStatus.inProgress,
      items: ['Vegan Meal Plan', 'Green Juice'],
    ),
    Delivery(
      id: 'DEL-002',
      customerName: 'Jane Smith',
      address: '456 Elm St, Shelbyville',
      scheduledTime: DateTime.now().add(Duration(hours: 3)),
      driverName: 'Rachel Zane',
      status: DeliveryStatus.pending,
      items: ['Keto Meal Plan'],
    ),
    Delivery(
      id: 'DEL-003',
      customerName: 'Robert Brown',
      address: '789 Oak Ave, Capital City',
      scheduledTime: DateTime.now().subtract(Duration(hours: 2)),
      driverName: 'Louis Litt',
      status: DeliveryStatus.delivered,
      items: ['Standard Meal Plan', 'Protein Bar'],
    ),
  ];
}
