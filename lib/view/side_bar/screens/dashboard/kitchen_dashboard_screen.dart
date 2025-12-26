import 'package:flutter/material.dart';
import 'package:frusette_kitchen_web_dashboard/core/data/kitchen_dummy_data.dart';
import 'package:frusette_kitchen_web_dashboard/core/theme/app_colors.dart';
import 'package:frusette_kitchen_web_dashboard/model/kitchen_meal.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class KitchenDashboardScreen extends StatefulWidget {
  const KitchenDashboardScreen({Key? key}) : super(key: key);

  @override
  State<KitchenDashboardScreen> createState() => _KitchenDashboardScreenState();
}

class _KitchenDashboardScreenState extends State<KitchenDashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _showTomorrow = false;
  String _selectedMealType = 'breakfast'; // Default to breakfast

  // Track completed meals
  final Set<String> _doneMealIds = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _showTomorrow = _tabController.index == 1;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  MealDaySummary get _currentSummary => _showTomorrow
      ? KitchenDummyData.getTomorrowSummary()
      : KitchenDummyData.getTodaySummary();

  List<KitchenMeal> get _filteredMeals {
    var meals = _currentSummary.meals.toList();
    // Filter by selected meal type
    meals = meals.where((m) => m.mealType == _selectedMealType).toList();
    // Sort: pending meals first, done meals at the bottom
    meals.sort((a, b) {
      final aDone = _doneMealIds.contains(a.id);
      final bDone = _doneMealIds.contains(b.id);
      if (aDone && !bDone) return 1;
      if (!aDone && bDone) return -1;
      return 0;
    });
    return meals;
  }

  void _markMealDone(String mealId) {
    setState(() {
      _doneMealIds.add(mealId);
    });
  }

  bool _isMealDone(String mealId) {
    return _doneMealIds.contains(mealId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 1200;
          final isMedium = constraints.maxWidth > 800;

          return Column(
            children: [
              // Header Section
              _buildHeader(context),

              // Main Content
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(isMedium ? 32 : 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Stats Cards Row
                      _buildStatsRow(isWide, isMedium),
                      const SizedBox(height: 24),

                      // Meal Type Filter & Preparation Summary
                      if (isWide)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Meal Schedule List
                            Expanded(
                              flex: 2,
                              child: _buildMealScheduleSection(),
                            ),
                            const SizedBox(width: 24),
                            // Preparation Summary
                            Expanded(
                              flex: 1,
                              child: _buildPreparationSummary(),
                            ),
                          ],
                        )
                      else
                        Column(
                          children: [
                            _buildPreparationSummary(),
                            const SizedBox(height: 24),
                            _buildMealScheduleSection(),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final now = DateTime.now();
    final greeting = now.hour < 12
        ? 'Good Morning'
        : now.hour < 17
        ? 'Good Afternoon'
        : 'Good Evening';

    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 600;

        return Container(
          padding: EdgeInsets.fromLTRB(
            isSmallScreen ? 16 : 32,
            24,
            isSmallScreen ? 16 : 32,
            0,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row - Title and Date Toggle
              if (isSmallScreen)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$greeting, Chef! 👨‍🍳',
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Kitchen schedule for ${_showTomorrow ? 'tomorrow' : 'today'}',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Current Time Display
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryColor.withOpacity(0.1),
                            AppColors.accentGreen.withOpacity(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.primaryColor.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.access_time,
                            color: AppColors.primaryColor,
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            DateFormat('EEE, MMM d').format(DateTime.now()),
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$greeting, Chef! 👨‍🍳',
                            style: GoogleFonts.inter(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Here\'s your kitchen schedule for ${_showTomorrow ? 'tomorrow' : 'today'}',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Current Time Display
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryColor.withOpacity(0.1),
                            AppColors.accentGreen.withOpacity(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.primaryColor.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.access_time,
                            color: AppColors.primaryColor,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            DateFormat(
                              'EEEE, MMMM d, yyyy',
                            ).format(DateTime.now()),
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 20),

              // Tab Bar for Today/Tomorrow
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(4),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  labelColor: AppColors.black,
                  unselectedLabelColor: Colors.grey[600],
                  labelStyle: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.today, size: 18),
                          const SizedBox(width: 8),
                          Text("Today's Schedule"),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.event, size: 18),
                          const SizedBox(width: 8),
                          Text("Tomorrow's Schedule"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatsRow(bool isWide, bool isMedium) {
    final summary = _currentSummary;

    if (isWide) {
      return Row(
        children: [
          Expanded(
            child: _buildStatCard(
              'Total Meals',
              summary.totalMeals.toString(),
              Icons.restaurant_menu,
              const Color(0xFF6366F1),
              '+${summary.totalMeals > 10 ? '5' : '2'}% from yesterday',
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildMealTypeCard(
              'Breakfast',
              summary.breakfastCount.toString(),
              Icons.free_breakfast,
              const Color(0xFFF59E0B),
              '7:00 - 9:00 AM',
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildMealTypeCard(
              'Lunch',
              summary.lunchCount.toString(),
              Icons.lunch_dining,
              const Color(0xFF10B981),
              '12:00 - 2:00 PM',
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildMealTypeCard(
              'Dinner',
              summary.dinnerCount.toString(),
              Icons.dinner_dining,
              const Color(0xFF3B82F6),
              '6:00 - 9:00 PM',
            ),
          ),
          const SizedBox(width: 16),
          Expanded(child: _buildStatusCard(summary)),
        ],
      );
    } else if (isMedium) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Total Meals',
                  summary.totalMeals.toString(),
                  Icons.restaurant_menu,
                  const Color(0xFF6366F1),
                  '+${summary.totalMeals > 10 ? '5' : '2'}% from yesterday',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(child: _buildStatusCard(summary)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildMealTypeCard(
                  'Breakfast',
                  summary.breakfastCount.toString(),
                  Icons.free_breakfast,
                  const Color(0xFFF59E0B),
                  '7:00 - 9:00 AM',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildMealTypeCard(
                  'Lunch',
                  summary.lunchCount.toString(),
                  Icons.lunch_dining,
                  const Color(0xFF10B981),
                  '12:00 - 2:00 PM',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildMealTypeCard(
                  'Dinner',
                  summary.dinnerCount.toString(),
                  Icons.dinner_dining,
                  const Color(0xFF3B82F6),
                  '6:00 - 9:00 PM',
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return Column(
        children: [
          _buildStatCard(
            'Total Meals',
            summary.totalMeals.toString(),
            Icons.restaurant_menu,
            const Color(0xFF6366F1),
            '+${summary.totalMeals > 10 ? '5' : '2'}% from yesterday',
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(
                  width: 140,
                  child: _buildMealTypeCard(
                    'Breakfast',
                    summary.breakfastCount.toString(),
                    Icons.free_breakfast,
                    const Color(0xFFF59E0B),
                    '7-9 AM',
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 140,
                  child: _buildMealTypeCard(
                    'Lunch',
                    summary.lunchCount.toString(),
                    Icons.lunch_dining,
                    const Color(0xFF10B981),
                    '12-2 PM',
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 140,
                  child: _buildMealTypeCard(
                    'Dinner',
                    summary.dinnerCount.toString(),
                    Icons.dinner_dining,
                    const Color(0xFF3B82F6),
                    '6-9 PM',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _buildStatusCard(summary),
        ],
      );
    }
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
    String subtitle,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accentGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.trending_up,
                      size: 14,
                      color: AppColors.accentGreen,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.accentGreen,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealTypeCard(
    String title,
    String value,
    IconData icon,
    Color color,
    String time,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withOpacity(0.9), color],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.white, size: 22),
              ),
              Text(
                time,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard(MealDaySummary summary) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.pending_actions, color: Colors.grey[700], size: 20),
              const SizedBox(width: 8),
              Text(
                'Status Overview',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildStatusRow(
            'Pending',
            summary.pendingCount,
            const Color(0xFFF59E0B),
          ),
          const SizedBox(height: 12),
          _buildStatusRow(
            'Preparing',
            summary.preparingCount,
            const Color(0xFF3B82F6),
          ),
          const SizedBox(height: 12),
          _buildStatusRow('Ready', summary.readyCount, const Color(0xFF10B981)),
          if (summary.topAllergies.isNotEmpty) ...[
            const SizedBox(height: 16),
            Divider(color: Colors.grey[200]),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: AppColors.accentRed,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  'Common Allergies',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.accentRed,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: summary.topAllergies
                  .take(3)
                  .map(
                    (allergy) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.accentRed.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        allergy,
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.accentRed,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusRow(String label, int count, Color color) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[700]),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            count.toString(),
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPreparationSummary() {
    final prepSummary = KitchenDummyData.getPreparationSummary(_filteredMeals);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6366F1).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.kitchen,
                      color: Color(0xFF6366F1),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Preparation Summary',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${prepSummary.length} items',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Quick overview of meals to prepare',
            style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[600]),
          ),
          const SizedBox(height: 20),

          // Preparation Items
          ...prepSummary.take(8).map((item) => _buildPrepItem(item)).toList(),

          if (prepSummary.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    Icon(Icons.check_circle, size: 48, color: Colors.grey[300]),
                    const SizedBox(height: 12),
                    Text(
                      'All caught up!',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPrepItem(PreparationSummary item) {
    final mealColor = item.mealType == 'breakfast'
        ? const Color(0xFFF59E0B)
        : item.mealType == 'lunch'
        ? const Color(0xFF10B981)
        : const Color(0xFF3B82F6);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 50,
            decoration: BoxDecoration(
              color: mealColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.mealName,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: mealColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        item.mealType[0].toUpperCase() +
                            item.mealType.substring(1),
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: mealColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildPrepBadge(
                      Icons.restaurant,
                      '${item.totalQuantity} portions',
                      Colors.grey[700]!,
                    ),
                    const SizedBox(width: 12),
                    _buildPrepBadge(
                      Icons.people,
                      '${item.customersCount} customers',
                      Colors.grey[700]!,
                    ),
                  ],
                ),
                if (item.commonAllergies.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    children: item.commonAllergies
                        .take(2)
                        .map(
                          (allergy) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.accentRed.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.warning_amber,
                                  size: 12,
                                  color: AppColors.accentRed,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  allergy,
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.accentRed,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrepBadge(IconData icon, String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(text, style: GoogleFonts.inter(fontSize: 12, color: color)),
      ],
    );
  }

  Widget _buildMealScheduleSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 600;

        return Container(
          padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.schedule,
                      color: AppColors.primaryColor,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Scheduled Meals',
                          style: GoogleFonts.inter(
                            fontSize: isSmallScreen ? 16 : 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                        Text(
                          'Customer orders with details',
                          style: GoogleFonts.inter(
                            fontSize: isSmallScreen ? 12 : 13,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Filter Tabs - Breakfast, Lunch, Dinner
              if (isSmallScreen)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildFilterChip(
                            'Breakfast',
                            'breakfast',
                            const Color(0xFFF59E0B),
                          ),
                          const SizedBox(width: 8),
                          _buildFilterChip(
                            'Lunch',
                            'lunch',
                            const Color(0xFF10B981),
                          ),
                          const SizedBox(width: 8),
                          _buildFilterChip(
                            'Dinner',
                            'dinner',
                            const Color(0xFF3B82F6),
                          ),
                          const SizedBox(width: 12),
                          // Meal count badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${_filteredMeals.length} meals',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    _buildFilterChip(
                      'Breakfast',
                      'breakfast',
                      const Color(0xFFF59E0B),
                    ),
                    const SizedBox(width: 8),
                    _buildFilterChip('Lunch', 'lunch', const Color(0xFF10B981)),
                    const SizedBox(width: 8),
                    _buildFilterChip(
                      'Dinner',
                      'dinner',
                      const Color(0xFF3B82F6),
                    ),
                    const Spacer(),
                    // Meal count badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${_filteredMeals.length} meals',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 24),

              // Meal Cards
              ..._filteredMeals.map((meal) => _buildMealCard(meal)).toList(),

              if (_filteredMeals.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(48),
                    child: Column(
                      children: [
                        Icon(Icons.no_meals, size: 64, color: Colors.grey[300]),
                        const SizedBox(height: 16),
                        Text(
                          'No meals scheduled',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[400],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'There are no meals scheduled for this day',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterChip(String label, String value, Color color) {
    final isSelected = _selectedMealType == value;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => setState(() => _selectedMealType = value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? color : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: isSelected ? color : Colors.grey[300]!,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                value == 'breakfast'
                    ? Icons.free_breakfast
                    : value == 'lunch'
                    ? Icons.lunch_dining
                    : Icons.dinner_dining,
                size: 16,
                color: isSelected ? Colors.white : color,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMealCard(KitchenMeal meal) {
    final mealColor = meal.mealType == 'breakfast'
        ? const Color(0xFFF59E0B)
        : meal.mealType == 'lunch'
        ? const Color(0xFF10B981)
        : const Color(0xFF3B82F6);

    final statusColor = meal.status == 'pending'
        ? const Color(0xFFF59E0B)
        : meal.status == 'preparing'
        ? const Color(0xFF3B82F6)
        : const Color(0xFF10B981);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  mealColor.withOpacity(0.05),
                  mealColor.withOpacity(0.02),
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                // Customer Avatar
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [mealColor.withOpacity(0.8), mealColor],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      meal.customerName
                          .split(' ')
                          .map((n) => n[0])
                          .take(2)
                          .join(),
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // Customer Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              meal.customerName,
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: statusColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  meal.status[0].toUpperCase() +
                                      meal.status.substring(1),
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: statusColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.phone, size: 14, color: Colors.grey[500]),
                          const SizedBox(width: 6),
                          Text(
                            meal.customerPhone,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Icon(
                            Icons.location_on,
                            size: 14,
                            color: Colors.grey[500],
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              meal.customerAddress,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: Colors.grey[600],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Meal Details Section
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Meal Info Row
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: mealColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            meal.mealType == 'breakfast'
                                ? Icons.free_breakfast
                                : meal.mealType == 'lunch'
                                ? Icons.lunch_dining
                                : Icons.dinner_dining,
                            size: 16,
                            color: mealColor,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            meal.mealType[0].toUpperCase() +
                                meal.mealType.substring(1),
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: mealColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 16,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 6),
                          Text(
                            DateFormat('h:mm a').format(meal.scheduledTime),
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.restaurant,
                            size: 16,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'x${meal.quantity}',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6366F1).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        meal.planName,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF6366F1),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Meal Name
                Text(
                  meal.mealName,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 16),

                // Preferences & Allergies
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    // Preferences
                    if (meal.preferences.isNotEmpty)
                      _buildDetailChip(
                        'Preferences',
                        meal.preferences.join(', '),
                        Icons.tune,
                        const Color(0xFF10B981),
                      ),

                    // Allergies
                    if (meal.allergies.isNotEmpty)
                      _buildDetailChip(
                        'Allergies',
                        meal.allergies.join(', '),
                        Icons.warning_amber,
                        AppColors.accentRed,
                      ),
                  ],
                ),

                // Special Instructions
                if (meal.specialInstructions.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFFCD34D)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 20,
                          color: const Color(0xFFD97706),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Special Instructions',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFFD97706),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                meal.specialInstructions,
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: const Color(0xFF92400E),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                // Add-ons Section
                if (meal.addOns.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3E8FF),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFF8B5CF6).withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.add_shopping_cart,
                              size: 18,
                              color: const Color(0xFF7C3AED),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Add-ons (${meal.addOns.length})',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF7C3AED),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: meal.addOns
                              .map(
                                (addon) => Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: const Color(
                                        0xFF8B5CF6,
                                      ).withOpacity(0.4),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(
                                          0xFF8B5CF6,
                                        ).withOpacity(0.1),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: const Color(
                                            0xFF8B5CF6,
                                          ).withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                        child: Text(
                                          '${addon.quantity}x',
                                          style: GoogleFonts.inter(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF7C3AED),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        addon.name,
                                        style: GoogleFonts.inter(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF5B21B6),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 16),

                // Done Button
                _buildDoneButton(meal),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailChip(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDoneButton(KitchenMeal meal) {
    final isDone = _isMealDone(meal.id);

    return MouseRegion(
      cursor: isDone ? SystemMouseCursors.basic : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: isDone ? null : () => _markMealDone(meal.id),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isDone ? const Color(0xFF10B981) : AppColors.primaryColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isDone
                ? []
                : [
                    BoxShadow(
                      color: AppColors.primaryColor.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isDone ? Icons.check_circle : Icons.check,
                size: 20,
                color: Colors.white,
              ),
              const SizedBox(width: 8),
              Text(
                isDone ? 'Completed ✓' : 'Mark as Done',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
