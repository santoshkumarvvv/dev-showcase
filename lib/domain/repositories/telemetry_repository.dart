import "package:dev_showcase/core/error/failures.dart";
import "package:dev_showcase/domain/entities/service_node_entity.dart";

/// Domain repository contract for querying and updating edge cluster telemetry.
abstract class TelemetryRepository {
  Future<Result<List<ServiceNodeEntity>, Failure>> getClusterNodes({bool forceRefresh = false});
  Future<Result<ServiceNodeEntity, Failure>> getNodeById(String id);
  Future<Result<ServiceNodeEntity, Failure>> upsertNode(ServiceNodeEntity node);
}
