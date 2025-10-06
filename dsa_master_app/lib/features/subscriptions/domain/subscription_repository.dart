class SubscriptionPlan {
  final String id;
  final String name;
  final String pricePerMonth;
  final List<String> features;
  const SubscriptionPlan({
    required this.id,
    required this.name,
    required this.pricePerMonth,
    required this.features,
  });
}

abstract class SubscriptionRepository {
  Future<bool> isPremium();
  Future<List<SubscriptionPlan>> listPlans();
}