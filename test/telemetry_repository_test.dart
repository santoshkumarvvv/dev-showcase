import "package:flutter_test/flutter_test.dart";
import "package:dev_showcase/data/datasources/local_cache.dart";
import "package:dev_showcase/data/models/service_node_model.dart";
import "package:dev_showcase/data/repositories/telemetry_repository_impl.dart";
import "package:dev_showcase/domain/entities/service_node_entity.dart";

void main() {
  group("ServiceNodeEntity & ServiceNodeModel", () {
    test("evaluates SLA compliance accurately based on P95 latency and uptime", () {
      const healthyNode = ServiceNodeEntity(
        id: "node-1",
        serviceName: "Edge Router",
        region: "ap-south-1",
        p95LatencyMs: 32,
        uptimePercent: 99.98,
      );
      expect(healthyNode.isSlaCompliant, isTrue);

      final degradedNode = healthyNode.copyWith(p95LatencyMs: 145);
      expect(degradedNode.isSlaCompliant, isFalse);
    });

    test("serializes and deserializes ServiceNodeModel deterministically", () {
      const model = ServiceNodeModel(
        id: "node-2",
        serviceName: "BM25 Worker",
        region: "eu-central-1",
        p95LatencyMs: 41,
        uptimePercent: 99.95,
        isHealthy: true,
      );
      final json = model.toJson();
      final hydrated = ServiceNodeModel.fromJson(json);
      expect(hydrated.id, model.id);
      expect(hydrated.serviceName, model.serviceName);
      expect(hydrated.p95LatencyMs, 41);
      expect(hydrated.isSlaCompliant, isTrue);
    });
  });

  group("TelemetryRepositoryImpl", () {
    test("returns seeded production nodes and populates LocalCacheDataSource", () async {
      final cache = LocalCacheDataSource();
      final repo = TelemetryRepositoryImpl(cache: cache);

      final res = await repo.getClusterNodes();
      expect(res.isSuccess, isTrue);
      expect(res.value.length, 3);
      expect(cache.activeEntriesCount, 1);
    });

    test("getNodeById returns Result.success for known ID and Result.failure for unknown ID", () async {
      final repo = TelemetryRepositoryImpl();

      final found = await repo.getNodeById("edge-ap-south-1");
      expect(found.isSuccess, isTrue);
      expect(found.value.region, contains("Mumbai"));

      final missing = await repo.getNodeById("unknown-node");
      expect(missing.isFailure, isTrue);
      expect(missing.failure.statusCode, 404);
    });

    test("upsertNode updates repository and invalidates stale cluster cache", () async {
      final cache = LocalCacheDataSource();
      final repo = TelemetryRepositoryImpl(cache: cache);
      await repo.getClusterNodes();
      expect(cache.activeEntriesCount, 1);

      const newNode = ServiceNodeEntity(
        id: "edge-ap-northeast-1",
        serviceName: "Tokyo Replica",
        region: "ap-northeast-1",
        p95LatencyMs: 19,
      );
      final saved = await repo.upsertNode(newNode);
      expect(saved.isSuccess, isTrue);
      expect(cache.activeEntriesCount, 0);

      final refreshed = await repo.getClusterNodes();
      expect(refreshed.value.length, 4);
    });
  });
}
