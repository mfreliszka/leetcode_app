import '../domain/subscription_repository.dart';

class MockSubscriptionRepository implements SubscriptionRepository {
  const MockSubscriptionRepository();

  @override
  Future<bool> isPremium() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return false;
  }

  @override
  Future<List<SubscriptionPlan>> listPlans() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return const [
      SubscriptionPlan(
        id: 'monthly',
        name: 'Premium Monthly',
        pricePerMonth: '4.99',
        features: [
          'Unlock advanced problems',
          'Detailed approaches and hints',
          'Achievements and streak boosters',
        ],
      ),
      SubscriptionPlan(
        id: 'annual',
        name: 'Premium Annual',
        pricePerMonth: '2.99',
        features: [
          'All premium features',
          'Save 20% vs monthly',
          'Priority support',
        ],
      ),
    ];
  }
}