/// Pure domain entity representing a distributed edge service node.
class ServiceNodeEntity {
  final String id;
  final String serviceName;
  final String region;
  final int p95LatencyMs;
  final double uptimePercent;
  final bool isHealthy;

  const ServiceNodeEntity({
    required this.id,
    required this.serviceName,
    required this.region,
    required this.p95LatencyMs,
    this.uptimePercent = 99.95,
    this.isHealthy = true,
  });

  /// Returns true when node meets strict production SLA (< 100ms P95 & >= 99.9% uptime).
  bool get isSlaCompliant => isHealthy && p95LatencyMs < 100 && uptimePercent >= 99.9;

  ServiceNodeEntity copyWith({
    String? id,
    String? serviceName,
    String? region,
    int? p95LatencyMs,
    double? uptimePercent,
    bool? isHealthy,
  }) {
    return ServiceNodeEntity(
      id: id ?? this.id,
      serviceName: serviceName ?? this.serviceName,
      region: region ?? this.region,
      p95LatencyMs: p95LatencyMs ?? this.p95LatencyMs,
      uptimePercent: uptimePercent ?? this.uptimePercent,
      isHealthy: isHealthy ?? this.isHealthy,
    );
  }
}
