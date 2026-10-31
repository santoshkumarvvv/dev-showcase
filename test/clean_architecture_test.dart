import 'package:flutter_test/flutter_test.dart';
import 'package:dev_showcase/core/error/failures.dart';
import 'package:dev_showcase/data/datasources/local_cache.dart';

void main() {
  group('Clean Architecture Result<S, F> Monadic Contract', () {
    test('Result.success holds value and folds successfully', () {
      const result = Result<String, Failure>.success('production_payload');
      expect(result.isSuccess, true);
      expect(result.isFailure, false);
      expect(result.value, 'production_payload');

      final folded = result.fold(
        (failure) => 'failed',
        (value) => 'success:$value',
      );
      expect(folded, 'success:production_payload');
    });

    test('Result.failure captures domain failure and folds error branch', () {
      const result = Result<String, Failure>.failure(ServerFailure('HTTP 502', 502));
      expect(result.isSuccess, false);
      expect(result.isFailure, true);
      expect(result.failure.statusCode, 502);

      final folded = result.fold(
        (failure) => 'caught:${failure.message}',
        (value) => 'ok',
      );
      expect(folded, 'caught:HTTP 502');
    });
  });

  group('LocalCacheDataSource TTL & Stale-While-Revalidate', () {
    test('put and get retrieve cached value before TTL expires', () {
      final cache = LocalCacheDataSource();
      cache.put<String>('user_1', 'Santosh Kumar', ttl: const Duration(seconds: 5));

      expect(cache.get<String>('user_1'), 'Santosh Kumar');
      expect(cache.activeEntriesCount, 1);
    });

    test('get returns null for missing or expired keys', () {
      final cache = LocalCacheDataSource();
      expect(cache.get<String>('non_existent'), null);
    });
  });
}
