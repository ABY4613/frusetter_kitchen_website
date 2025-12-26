import '../../model/kitchen_meal.dart';

class KitchenDummyData {
  static DateTime get today => DateTime.now();
  static DateTime get tomorrow => DateTime.now().add(const Duration(days: 1));

  static List<KitchenMeal> get todaysMeals => [
    // BREAKFAST MEALS - Today
    KitchenMeal(
      id: 'KM-001',
      customerId: 'C-001',
      customerName: 'Sarah Johnson',
      customerPhone: '+1 (555) 123-4567',
      customerAddress: '1234 Oak Street, Apt 5B, Downtown',
      mealType: 'breakfast',
      planName: 'Keto Kickstart',
      mealName: 'Avocado Egg Bowl',
      preferences: ['No onions', 'Extra avocado'],
      allergies: ['Lactose'],
      specialInstructions: 'Please make the eggs over-easy, not scrambled.',
      scheduledTime: DateTime(today.year, today.month, today.day, 7, 30),
      status: 'preparing',
      quantity: 1,
      addOns: [
        AddOn(
          id: 'AO-001',
          name: 'Fresh Orange Juice',
          quantity: 1,
          price: 4.99,
        ),
        AddOn(id: 'AO-002', name: 'Extra Toast', quantity: 2, price: 2.50),
      ],
    ),
    KitchenMeal(
      id: 'KM-002',
      customerId: 'C-002',
      customerName: 'Michael Chen',
      customerPhone: '+1 (555) 234-5678',
      customerAddress: '567 Pine Avenue, Suite 12',
      mealType: 'breakfast',
      planName: 'Vegan Power',
      mealName: 'Acai Smoothie Bowl',
      preferences: ['Extra granola', 'No banana'],
      allergies: ['Nuts', 'Gluten'],
      specialInstructions:
          'Use almond milk alternative due to nut allergy - use oat milk instead.',
      scheduledTime: DateTime(today.year, today.month, today.day, 8, 0),
      status: 'pending',
      quantity: 1,
      addOns: [
        AddOn(id: 'AO-003', name: 'Green Smoothie', quantity: 1, price: 5.99),
      ],
    ),
    KitchenMeal(
      id: 'KM-003',
      customerId: 'C-003',
      customerName: 'Emily Rodriguez',
      customerPhone: '+1 (555) 345-6789',
      customerAddress: '890 Maple Court, Building C',
      mealType: 'breakfast',
      planName: 'Weight Loss Plan',
      mealName: 'Protein Pancakes',
      preferences: ['Sugar-free syrup'],
      allergies: [],
      specialInstructions: '',
      scheduledTime: DateTime(today.year, today.month, today.day, 7, 45),
      status: 'ready',
      quantity: 2,
      addOns: [
        AddOn(id: 'AO-004', name: 'Fruit Bowl', quantity: 1, price: 3.99),
        AddOn(id: 'AO-005', name: 'Black Coffee', quantity: 2, price: 2.99),
        AddOn(id: 'AO-006', name: 'Protein Bar', quantity: 1, price: 3.50),
      ],
    ),
    KitchenMeal(
      id: 'KM-004',
      customerId: 'C-004',
      customerName: 'James Wilson',
      customerPhone: '+1 (555) 456-7890',
      customerAddress: '321 Birch Lane, Unit 8A',
      mealType: 'breakfast',
      planName: 'Keto Kickstart',
      mealName: 'Bacon & Cheese Omelette',
      preferences: ['Extra cheese'],
      allergies: ['Shellfish'],
      specialInstructions: 'Well done please.',
      scheduledTime: DateTime(today.year, today.month, today.day, 8, 15),
      status: 'pending',
      quantity: 1,
    ),

    // LUNCH MEALS - Today
    KitchenMeal(
      id: 'KM-005',
      customerId: 'C-001',
      customerName: 'Sarah Johnson',
      customerPhone: '+1 (555) 123-4567',
      customerAddress: '1234 Oak Street, Apt 5B, Downtown',
      mealType: 'lunch',
      planName: 'Keto Kickstart',
      mealName: 'Grilled Chicken Salad',
      preferences: ['No croutons', 'Dressing on side'],
      allergies: ['Lactose'],
      specialInstructions: 'Please include extra lemon wedges.',
      scheduledTime: DateTime(today.year, today.month, today.day, 12, 30),
      status: 'pending',
      quantity: 1,
      addOns: [
        AddOn(id: 'AO-007', name: 'Sparkling Water', quantity: 2, price: 2.50),
        AddOn(id: 'AO-008', name: 'Garlic Bread', quantity: 1, price: 3.99),
      ],
    ),
    KitchenMeal(
      id: 'KM-006',
      customerId: 'C-005',
      customerName: 'Amanda Foster',
      customerPhone: '+1 (555) 567-8901',
      customerAddress: '456 Cedar Drive, House 15',
      mealType: 'lunch',
      planName: 'Mediterranean Diet',
      mealName: 'Quinoa Buddha Bowl',
      preferences: ['Extra hummus', 'No olives'],
      allergies: ['Soy', 'Peanuts'],
      specialInstructions: 'Make it spicy if possible.',
      scheduledTime: DateTime(today.year, today.month, today.day, 12, 0),
      status: 'pending',
      quantity: 1,
    ),
    KitchenMeal(
      id: 'KM-007',
      customerId: 'C-002',
      customerName: 'Michael Chen',
      customerPhone: '+1 (555) 234-5678',
      customerAddress: '567 Pine Avenue, Suite 12',
      mealType: 'lunch',
      planName: 'Vegan Power',
      mealName: 'Tofu Stir Fry',
      preferences: ['Extra vegetables'],
      allergies: ['Nuts', 'Gluten'],
      specialInstructions: 'Please use gluten-free soy sauce.',
      scheduledTime: DateTime(today.year, today.month, today.day, 13, 0),
      status: 'pending',
      quantity: 1,
    ),
    KitchenMeal(
      id: 'KM-008',
      customerId: 'C-006',
      customerName: 'David Kim',
      customerPhone: '+1 (555) 678-9012',
      customerAddress: '789 Willow Street, Apt 3C',
      mealType: 'lunch',
      planName: 'High Protein Plan',
      mealName: 'Salmon & Quinoa Bowl',
      preferences: ['No cucumber'],
      allergies: [],
      specialInstructions: 'Medium rare salmon please.',
      scheduledTime: DateTime(today.year, today.month, today.day, 12, 45),
      status: 'pending',
      quantity: 1,
    ),
    KitchenMeal(
      id: 'KM-009',
      customerId: 'C-007',
      customerName: 'Lisa Thompson',
      customerPhone: '+1 (555) 789-0123',
      customerAddress: '234 Spruce Road, Building B',
      mealType: 'lunch',
      planName: 'Weight Loss Plan',
      mealName: 'Grilled Chicken Wrap',
      preferences: ['Whole wheat wrap', 'No mayo'],
      allergies: ['Eggs'],
      specialInstructions: 'Cut in half please.',
      scheduledTime: DateTime(today.year, today.month, today.day, 12, 15),
      status: 'pending',
      quantity: 2,
    ),

    // DINNER MEALS - Today
    KitchenMeal(
      id: 'KM-010',
      customerId: 'C-001',
      customerName: 'Sarah Johnson',
      customerPhone: '+1 (555) 123-4567',
      customerAddress: '1234 Oak Street, Apt 5B, Downtown',
      mealType: 'dinner',
      planName: 'Keto Kickstart',
      mealName: 'Grilled Steak & Vegetables',
      preferences: ['Medium rare', 'Extra broccoli'],
      allergies: ['Lactose'],
      specialInstructions: 'Please include garlic butter on the side.',
      scheduledTime: DateTime(today.year, today.month, today.day, 19, 0),
      status: 'pending',
      quantity: 1,
    ),
    KitchenMeal(
      id: 'KM-011',
      customerId: 'C-003',
      customerName: 'Emily Rodriguez',
      customerPhone: '+1 (555) 345-6789',
      customerAddress: '890 Maple Court, Building C',
      mealType: 'dinner',
      planName: 'Weight Loss Plan',
      mealName: 'Baked Cod with Asparagus',
      preferences: ['Lemon squeeze'],
      allergies: [],
      specialInstructions: '',
      scheduledTime: DateTime(today.year, today.month, today.day, 18, 30),
      status: 'pending',
      quantity: 1,
    ),
    KitchenMeal(
      id: 'KM-012',
      customerId: 'C-008',
      customerName: 'Robert Martinez',
      customerPhone: '+1 (555) 890-1234',
      customerAddress: '567 Elm Boulevard, Apt 7D',
      mealType: 'dinner',
      planName: 'Mediterranean Diet',
      mealName: 'Lamb Kofta with Rice',
      preferences: ['Extra tzatziki'],
      allergies: ['Sesame'],
      specialInstructions: 'No sesame seeds on top.',
      scheduledTime: DateTime(today.year, today.month, today.day, 19, 30),
      status: 'pending',
      quantity: 1,
    ),
    KitchenMeal(
      id: 'KM-013',
      customerId: 'C-002',
      customerName: 'Michael Chen',
      customerPhone: '+1 (555) 234-5678',
      customerAddress: '567 Pine Avenue, Suite 12',
      mealType: 'dinner',
      planName: 'Vegan Power',
      mealName: 'Lentil Curry with Naan',
      preferences: ['Extra spicy', 'No cilantro'],
      allergies: ['Nuts', 'Gluten'],
      specialInstructions: 'Use gluten-free naan bread alternative.',
      scheduledTime: DateTime(today.year, today.month, today.day, 19, 15),
      status: 'pending',
      quantity: 1,
    ),
  ];

  static List<KitchenMeal> get tomorrowsMeals => [
    // BREAKFAST - Tomorrow
    KitchenMeal(
      id: 'KM-T001',
      customerId: 'C-001',
      customerName: 'Sarah Johnson',
      customerPhone: '+1 (555) 123-4567',
      customerAddress: '1234 Oak Street, Apt 5B, Downtown',
      mealType: 'breakfast',
      planName: 'Keto Kickstart',
      mealName: 'Smoked Salmon Benedict',
      preferences: ['Extra hollandaise'],
      allergies: ['Lactose'],
      specialInstructions: 'Poached eggs please.',
      scheduledTime: DateTime(
        tomorrow.year,
        tomorrow.month,
        tomorrow.day,
        7,
        30,
      ),
      status: 'pending',
      quantity: 1,
    ),
    KitchenMeal(
      id: 'KM-T002',
      customerId: 'C-009',
      customerName: 'Jennifer White',
      customerPhone: '+1 (555) 901-2345',
      customerAddress: '123 Aspen Way, Unit 2',
      mealType: 'breakfast',
      planName: 'Weight Loss Plan',
      mealName: 'Greek Yogurt Parfait',
      preferences: ['Extra berries'],
      allergies: ['Nuts'],
      specialInstructions: 'No granola (contains nuts).',
      scheduledTime: DateTime(
        tomorrow.year,
        tomorrow.month,
        tomorrow.day,
        8,
        0,
      ),
      status: 'pending',
      quantity: 1,
    ),
    KitchenMeal(
      id: 'KM-T003',
      customerId: 'C-005',
      customerName: 'Amanda Foster',
      customerPhone: '+1 (555) 567-8901',
      customerAddress: '456 Cedar Drive, House 15',
      mealType: 'breakfast',
      planName: 'Mediterranean Diet',
      mealName: 'Shakshuka',
      preferences: ['Extra bread'],
      allergies: ['Soy', 'Peanuts'],
      specialInstructions: 'Medium spicy.',
      scheduledTime: DateTime(
        tomorrow.year,
        tomorrow.month,
        tomorrow.day,
        8,
        30,
      ),
      status: 'pending',
      quantity: 1,
    ),
    KitchenMeal(
      id: 'KM-T004',
      customerId: 'C-010',
      customerName: 'Thomas Brown',
      customerPhone: '+1 (555) 012-3456',
      customerAddress: '678 Redwood Lane, Apt 9E',
      mealType: 'breakfast',
      planName: 'High Protein Plan',
      mealName: 'Steak & Eggs',
      preferences: ['Well done steak'],
      allergies: [],
      specialInstructions: '',
      scheduledTime: DateTime(
        tomorrow.year,
        tomorrow.month,
        tomorrow.day,
        7,
        45,
      ),
      status: 'pending',
      quantity: 1,
    ),
    KitchenMeal(
      id: 'KM-T005',
      customerId: 'C-006',
      customerName: 'David Kim',
      customerPhone: '+1 (555) 678-9012',
      customerAddress: '789 Willow Street, Apt 3C',
      mealType: 'breakfast',
      planName: 'High Protein Plan',
      mealName: 'Protein Omelette',
      preferences: ['Add mushrooms', 'Extra cheese'],
      allergies: [],
      specialInstructions: 'Fluffy eggs please.',
      scheduledTime: DateTime(
        tomorrow.year,
        tomorrow.month,
        tomorrow.day,
        8,
        15,
      ),
      status: 'pending',
      quantity: 1,
    ),

    // LUNCH - Tomorrow
    KitchenMeal(
      id: 'KM-T006',
      customerId: 'C-001',
      customerName: 'Sarah Johnson',
      customerPhone: '+1 (555) 123-4567',
      customerAddress: '1234 Oak Street, Apt 5B, Downtown',
      mealType: 'lunch',
      planName: 'Keto Kickstart',
      mealName: 'Cobb Salad',
      preferences: ['Blue cheese dressing'],
      allergies: ['Lactose'],
      specialInstructions: 'Bacon crispy please.',
      scheduledTime: DateTime(
        tomorrow.year,
        tomorrow.month,
        tomorrow.day,
        12,
        30,
      ),
      status: 'pending',
      quantity: 1,
    ),
    KitchenMeal(
      id: 'KM-T007',
      customerId: 'C-007',
      customerName: 'Lisa Thompson',
      customerPhone: '+1 (555) 789-0123',
      customerAddress: '234 Spruce Road, Building B',
      mealType: 'lunch',
      planName: 'Weight Loss Plan',
      mealName: 'Turkey Lettuce Wraps',
      preferences: ['Extra vegetables'],
      allergies: ['Eggs'],
      specialInstructions: '',
      scheduledTime: DateTime(
        tomorrow.year,
        tomorrow.month,
        tomorrow.day,
        12,
        15,
      ),
      status: 'pending',
      quantity: 2,
    ),
    KitchenMeal(
      id: 'KM-T008',
      customerId: 'C-009',
      customerName: 'Jennifer White',
      customerPhone: '+1 (555) 901-2345',
      customerAddress: '123 Aspen Way, Unit 2',
      mealType: 'lunch',
      planName: 'Weight Loss Plan',
      mealName: 'Grilled Chicken Caesar',
      preferences: ['Light dressing'],
      allergies: ['Nuts'],
      specialInstructions: 'No parmesan crisps.',
      scheduledTime: DateTime(
        tomorrow.year,
        tomorrow.month,
        tomorrow.day,
        13,
        0,
      ),
      status: 'pending',
      quantity: 1,
    ),
    KitchenMeal(
      id: 'KM-T009',
      customerId: 'C-010',
      customerName: 'Thomas Brown',
      customerPhone: '+1 (555) 012-3456',
      customerAddress: '678 Redwood Lane, Apt 9E',
      mealType: 'lunch',
      planName: 'High Protein Plan',
      mealName: 'Chicken Breast & Sweet Potato',
      preferences: ['Extra protein'],
      allergies: [],
      specialInstructions: 'Grilled not fried.',
      scheduledTime: DateTime(
        tomorrow.year,
        tomorrow.month,
        tomorrow.day,
        12,
        45,
      ),
      status: 'pending',
      quantity: 1,
    ),

    // DINNER - Tomorrow
    KitchenMeal(
      id: 'KM-T010',
      customerId: 'C-005',
      customerName: 'Amanda Foster',
      customerPhone: '+1 (555) 567-8901',
      customerAddress: '456 Cedar Drive, House 15',
      mealType: 'dinner',
      planName: 'Mediterranean Diet',
      mealName: 'Grilled Sea Bass',
      preferences: ['Lemon butter sauce'],
      allergies: ['Soy', 'Peanuts'],
      specialInstructions: 'Skin crispy please.',
      scheduledTime: DateTime(
        tomorrow.year,
        tomorrow.month,
        tomorrow.day,
        19,
        0,
      ),
      status: 'pending',
      quantity: 1,
    ),
    KitchenMeal(
      id: 'KM-T011',
      customerId: 'C-006',
      customerName: 'David Kim',
      customerPhone: '+1 (555) 678-9012',
      customerAddress: '789 Willow Street, Apt 3C',
      mealType: 'dinner',
      planName: 'High Protein Plan',
      mealName: 'Ribeye Steak',
      preferences: ['Medium well', 'Mushroom sauce'],
      allergies: [],
      specialInstructions: 'Side of mashed potatoes.',
      scheduledTime: DateTime(
        tomorrow.year,
        tomorrow.month,
        tomorrow.day,
        19,
        30,
      ),
      status: 'pending',
      quantity: 1,
    ),
    KitchenMeal(
      id: 'KM-T012',
      customerId: 'C-008',
      customerName: 'Robert Martinez',
      customerPhone: '+1 (555) 890-1234',
      customerAddress: '567 Elm Boulevard, Apt 7D',
      mealType: 'dinner',
      planName: 'Mediterranean Diet',
      mealName: 'Chicken Shawarma Plate',
      preferences: ['Extra pickles'],
      allergies: ['Sesame'],
      specialInstructions: 'No tahini sauce.',
      scheduledTime: DateTime(
        tomorrow.year,
        tomorrow.month,
        tomorrow.day,
        18,
        45,
      ),
      status: 'pending',
      quantity: 1,
    ),
  ];

  static MealDaySummary getTodaySummary() {
    final meals = todaysMeals;
    final breakfastMeals = meals
        .where((m) => m.mealType == 'breakfast')
        .toList();
    final lunchMeals = meals.where((m) => m.mealType == 'lunch').toList();
    final dinnerMeals = meals.where((m) => m.mealType == 'dinner').toList();

    // Get all allergies
    final allAllergies = <String>[];
    for (var meal in meals) {
      allAllergies.addAll(meal.allergies);
    }
    final allergyCount = <String, int>{};
    for (var allergy in allAllergies) {
      allergyCount[allergy] = (allergyCount[allergy] ?? 0) + 1;
    }
    final sortedAllergies = allergyCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final topAllergies = sortedAllergies.take(5).map((e) => e.key).toList();

    return MealDaySummary(
      date: today,
      totalMeals: meals.fold(0, (sum, m) => sum + m.quantity),
      breakfastCount: breakfastMeals.fold(0, (sum, m) => sum + m.quantity),
      lunchCount: lunchMeals.fold(0, (sum, m) => sum + m.quantity),
      dinnerCount: dinnerMeals.fold(0, (sum, m) => sum + m.quantity),
      pendingCount: meals.where((m) => m.status == 'pending').length,
      preparingCount: meals.where((m) => m.status == 'preparing').length,
      readyCount: meals.where((m) => m.status == 'ready').length,
      topAllergies: topAllergies,
      meals: meals,
    );
  }

  static MealDaySummary getTomorrowSummary() {
    final meals = tomorrowsMeals;
    final breakfastMeals = meals
        .where((m) => m.mealType == 'breakfast')
        .toList();
    final lunchMeals = meals.where((m) => m.mealType == 'lunch').toList();
    final dinnerMeals = meals.where((m) => m.mealType == 'dinner').toList();

    final allAllergies = <String>[];
    for (var meal in meals) {
      allAllergies.addAll(meal.allergies);
    }
    final allergyCount = <String, int>{};
    for (var allergy in allAllergies) {
      allergyCount[allergy] = (allergyCount[allergy] ?? 0) + 1;
    }
    final sortedAllergies = allergyCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final topAllergies = sortedAllergies.take(5).map((e) => e.key).toList();

    return MealDaySummary(
      date: tomorrow,
      totalMeals: meals.fold(0, (sum, m) => sum + m.quantity),
      breakfastCount: breakfastMeals.fold(0, (sum, m) => sum + m.quantity),
      lunchCount: lunchMeals.fold(0, (sum, m) => sum + m.quantity),
      dinnerCount: dinnerMeals.fold(0, (sum, m) => sum + m.quantity),
      pendingCount: meals.where((m) => m.status == 'pending').length,
      preparingCount: meals.where((m) => m.status == 'preparing').length,
      readyCount: meals.where((m) => m.status == 'ready').length,
      topAllergies: topAllergies,
      meals: meals,
    );
  }

  static List<PreparationSummary> getPreparationSummary(
    List<KitchenMeal> meals,
  ) {
    final mealGroups = <String, List<KitchenMeal>>{};
    for (var meal in meals) {
      if (!mealGroups.containsKey(meal.mealName)) {
        mealGroups[meal.mealName] = [];
      }
      mealGroups[meal.mealName]!.add(meal);
    }

    return mealGroups.entries.map((entry) {
      final meals = entry.value;
      final allAllergies = <String>{};
      for (var meal in meals) {
        allAllergies.addAll(meal.allergies);
      }
      return PreparationSummary(
        mealName: entry.key,
        totalQuantity: meals.fold(0, (sum, m) => sum + m.quantity),
        mealType: meals.first.mealType,
        commonAllergies: allAllergies.toList(),
        customersCount: meals.length,
      );
    }).toList()..sort((a, b) => b.totalQuantity.compareTo(a.totalQuantity));
  }
}
