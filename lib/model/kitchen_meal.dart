/// Model for add-on food items
class AddOn {
  final String id;
  final String name;
  final int quantity;
  final double price;

  AddOn({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
  });

  factory AddOn.fromJson(Map<String, dynamic> json) {
    return AddOn(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      quantity: json['quantity'] ?? 1,
      price: (json['price'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'quantity': quantity, 'price': price};
  }
}

/// Model for scheduled meals in the Kitchen Dashboard
class KitchenMeal {
  final String id;
  final String customerId;
  final String customerName;
  final String customerPhone;
  final String customerAddress;
  final String mealType; // breakfast, lunch, dinner
  final String planName;
  final String mealName;
  final List<String> preferences;
  final List<String> allergies;
  final String specialInstructions;
  final DateTime scheduledTime;
  final String status; // pending, preparing, ready, delivered
  final int quantity;
  final String? avatarUrl;
  final List<AddOn> addOns; // Add-on food items

  KitchenMeal({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress,
    required this.mealType,
    required this.planName,
    required this.mealName,
    required this.preferences,
    required this.allergies,
    required this.specialInstructions,
    required this.scheduledTime,
    required this.status,
    required this.quantity,
    this.avatarUrl,
    this.addOns = const [],
  });

  factory KitchenMeal.fromJson(Map<String, dynamic> json) {
    return KitchenMeal(
      id: json['id'] ?? '',
      customerId: json['customerId'] ?? '',
      customerName: json['customerName'] ?? '',
      customerPhone: json['customerPhone'] ?? '',
      customerAddress: json['customerAddress'] ?? '',
      mealType: json['mealType'] ?? '',
      planName: json['planName'] ?? '',
      mealName: json['mealName'] ?? '',
      preferences: List<String>.from(json['preferences'] ?? []),
      allergies: List<String>.from(json['allergies'] ?? []),
      specialInstructions: json['specialInstructions'] ?? '',
      scheduledTime: DateTime.parse(
        json['scheduledTime'] ?? DateTime.now().toIso8601String(),
      ),
      status: json['status'] ?? 'pending',
      quantity: json['quantity'] ?? 1,
      avatarUrl: json['avatarUrl'],
      addOns:
          (json['addOns'] as List<dynamic>?)
              ?.map((e) => AddOn.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerId': customerId,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'customerAddress': customerAddress,
      'mealType': mealType,
      'planName': planName,
      'mealName': mealName,
      'preferences': preferences,
      'allergies': allergies,
      'specialInstructions': specialInstructions,
      'scheduledTime': scheduledTime.toIso8601String(),
      'status': status,
      'quantity': quantity,
      'avatarUrl': avatarUrl,
      'addOns': addOns.map((e) => e.toJson()).toList(),
    };
  }
}

/// Summary of meals for a specific day
class MealDaySummary {
  final DateTime date;
  final int totalMeals;
  final int breakfastCount;
  final int lunchCount;
  final int dinnerCount;
  final int pendingCount;
  final int preparingCount;
  final int readyCount;
  final List<String> topAllergies;
  final List<KitchenMeal> meals;

  MealDaySummary({
    required this.date,
    required this.totalMeals,
    required this.breakfastCount,
    required this.lunchCount,
    required this.dinnerCount,
    required this.pendingCount,
    required this.preparingCount,
    required this.readyCount,
    required this.topAllergies,
    required this.meals,
  });
}

/// Preparation summary for kitchen planning
class PreparationSummary {
  final String mealName;
  final int totalQuantity;
  final String mealType;
  final List<String> commonAllergies;
  final int customersCount;

  PreparationSummary({
    required this.mealName,
    required this.totalQuantity,
    required this.mealType,
    required this.commonAllergies,
    required this.customersCount,
  });
}
