import "package:dev_showcase/core/error/failures.dart";
import "package:dev_showcase/data/datasources/local_cache.dart";
import "package:dev_showcase/data/models/service_node_model.dart";
import "package:dev_showcase/domain/entities/service_node_entity.dart";
import "package:dev_showcase/domain/repositories/telemetry_repository.dart";

/// Production repository implementation with TTL caching and Result<S, Failure> guarantees.
class TelemetryRepositoryImpl implements TelemetryRepository {
  static const String _clusterCacheKey = "edge_cluster_nodes_v1";
  final LocalCacheDataSource _cache;

  final Map<String, ServiceNodeModel> _seedStore = {
    "edge-ap-south-1": const ServiceNodeModel(
      id: "edge-ap-south-1",
      serviceName: "Search Hub Federated Router",
      region: "ap-south-1 (Mumbai)",
      p95LatencyMs: 28,
      uptimePercent: 99.98,
      isHealthy: true,
    ),
    "edge-us-east-1": const ServiceNodeModel(
      id: "edge-us-east-1",
      serviceName: "BM25 Inverted Index Engine",
      region: "us-east-1 (N. Virginia)",
      p95LatencyMs: 36,
      uptimePercent: 99.96,
      isHealthy: true,
    ),
    "edge-eu-central-1": const ServiceNodeModel(
      id: "edge-eu-central-1",
      serviceName: "Scrypt API Key Gateway",
      region: "eu-central-1 (Frankfurt)",
      p95LatencyMs: 42,
      uptimePercent: 99.95,
      isHealthy: true,
    ),
  };

  TelemetryRepositoryImpl({LocalCacheDataSource? cache})
      : _cache = cache ?? LocalCacheDataSource();

  @override
  Future<Result<List<ServiceNodeEntity>, Failure>> getClusterNodes({bool forceRefresh = false}) async {
    if (!forceRefresh) {
      final cached = _cache.get<List<ServiceNodeEntity>>(_clusterCacheKey);
      if (cached != null && cached.isNotEmpty) {
        return Result.success(List<ServiceNodeEntity>.unmodifiable(cached));
      }
    }

    final nodes = _seedStore.values.toList(growable: false);
    _cache.put<List<ServiceNodeEntity>>(_clusterCacheKey, nodes);
    return Result.success(nodes);
  }

  @override
  Future<Result<ServiceNodeEntity, Failure>> getNodeById(String id) async {
    final trimmed = id.trim();
    if (trimmed.isEmpty) {
      return const Result.failure(CacheFailure("Node identifier cannot be empty"));
    }
    final node = _seedStore[trimmed];
    if (node == null) {
      return Result.failure(ServerFailure("Service node not found: $trimmed", 404));
    }
    return Result.success(node);
  }

  @override
  Future<Result<ServiceNodeEntity, Failure>> upsertNode(ServiceNodeEntity node) async {
    if (node.id.trim().isEmpty) {
      return const Result.failure(CacheFailure("Cannot persist node with empty ID"));
    }
    final model = ServiceNodeModel.fromEntity(node);
    _seedStore[node.id] = model;
    _cache.invalidate(_clusterCacheKey);
    return Result.success(model);
  }
}
