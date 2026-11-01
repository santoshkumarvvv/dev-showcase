import "package:dev_showcase/domain/entities/service_node_entity.dart";

/// Data transfer object with deterministic JSON serialization for ServiceNodeEntity.
class ServiceNodeModel extends ServiceNodeEntity {
  const ServiceNodeModel({
    required super.id,
    required super.serviceName,
    required super.region,
    required super.p95LatencyMs,
    super.uptimePercent,
    super.isHealthy,
  });

  factory ServiceNodeModel.fromJson(Map<String, dynamic> json) {
    return ServiceNodeModel(
      id: json["id"] as String,
      serviceName: json["serviceName"] as String,
      region: json["region"] as String,
      p95LatencyMs: (json["p95LatencyMs"] as num).toInt(),
      uptimePercent: (json["uptimePercent"] as num?)?.toDouble() ?? 99.95,
      isHealthy: json["isHealthy"] as bool? ?? true,
    );
  }

  factory ServiceNodeModel.fromEntity(ServiceNodeEntity entity) {
    return ServiceNodeModel(
      id: entity.id,
      serviceName: entity.serviceName,
      region: entity.region,
      p95LatencyMs: entity.p95LatencyMs,
      uptimePercent: entity.uptimePercent,
      isHealthy: entity.isHealthy,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "serviceName": serviceName,
        "region": region,
        "p95LatencyMs": p95LatencyMs,
        "uptimePercent": uptimePercent,
        "isHealthy": isHealthy,
      };
}
