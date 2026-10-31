/// Domain failure hierarchy for Clean Architecture error propagation.
abstract class Failure {
  final String message;
  final int? statusCode;
  const Failure(this.message, [this.statusCode]);

  @override
  String toString() => '$runtimeType: $message (status: $statusCode)';
}

class ServerFailure extends Failure {
  const ServerFailure([String message = 'Upstream server error occurred', int? code])
      : super(message, code);
}

class CacheFailure extends Failure {
  const CacheFailure([String message = 'Local cache miss or corrupted storage'])
      : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure([String message = 'Host unreachable, offline fallback engaged'])
      : super(message);
}

/// Monadic Result Type: encapsulates either a success value or a domain failure.
class Result<S, F extends Failure> {
  final S? _value;
  final F? _failure;

  const Result.success(S value)
      : _value = value,
        _failure = null;

  const Result.failure(F failure)
      : _value = null,
        _failure = failure;

  bool get isSuccess => _failure == null;
  bool get isFailure => _failure != null;

  S get value {
    if (isFailure) throw StateError('Cannot retrieve value from a failed Result: $_failure');
    return _value as S;
  }

  F get failure {
    if (isSuccess) throw StateError('Cannot retrieve failure from a successful Result: $_value');
    return _failure as F;
  }

  T fold<T>(T Function(F failure) onFailure, T Function(S value) onSuccess) {
    if (isFailure) return onFailure(_failure as F);
    return onSuccess(_value as S);
  }
}
