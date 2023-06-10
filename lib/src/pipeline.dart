class FuncTools {
  static O2 Function(T1)
      combine<T1, T2, T3, O1 extends MetaState<T2>, O2 extends MetaState<T3>>(
          O1 Function(T1) f1, O2 Function(T2) f2) {
    extractor(x) => x.extract();
    return (T1 x) => f2(extractor(f1(x)));
  }
}

abstract interface class IMonadic<T> {
  T extract();
  MetaState<T> apply(T Function(T) func);
  MetaState<T> id();
}

abstract class MetaState<T> implements IMonadic<T> {}

class Value<T> extends MetaState<T> {
  late final T _value;

  Value(this._value);

  // Apply function to the value inside Value
  @override
  Value<T> apply(T Function(T) func) => Value<T>(func(_value));

  @override
  T extract() => _value;

  @override
  Value<T> id() => Value(_value);

  static Value<T> wrap<T>(x) => Value(x);
}

class Error<String> extends MetaState<String> {
  late final String _value;

  Error(this._value);

  @override
  Error<String> apply(String Function(String) func) =>
      Error<String>(func(_value));

  @override
  String extract() => _value;

  @override
  Error<String> id() => Error(_value);

  static Error<String> wrap<String>(x) => Error(x);
}

class Nothing extends MetaState {
  static MetaState wrap(x) => Nothing();

  @override
  Nothing apply(Function(dynamic) func) => this;

  @override
  extract() => this;

  @override
  Nothing id() => Nothing();
}

class StateR<T extends MetaState> extends MetaState<T> {
  late final T _state;

  StateR(this._state);

  @override
  StateR<T> apply(dynamic func(dynamic)) => StateR(_state.apply(func) as T);

  @override
  T extract() => _state;

  @override
  StateR<T> id() => StateR(_state);

  static StateR<T> wrap<T extends MetaState>(T x) => StateR(x);
}

class Pipeline<S, T> {
  final MetaState<T> Function(S) pipeline;

  const Pipeline(this.pipeline);

  T2 extractor<T2>(MetaState<T2> x) => x.extract();

  Pipeline<S, R> bind<R>(MetaState<R> Function(T) f) =>
      Pipeline<S, R>((S s) => f(extractor(pipeline(s))));

  MetaState<T> produce(MetaState<S> s) => pipeline(s.extract());
}


class Pipeline2<S, T> {
  final Pipeline2<S,T> Function(S) pipeline;

  const Pipeline2(this.pipeline);

  T2 extractor<T2>(MetaState<T2> x) => x.extract();

  Pipeline2<S, R> bind<R>(MetaState<R> Function(T) f) =>
      Pipeline2<S, R>((S s) => f(extractor(pipeline(s))));

  MetaState<T> produce(MetaState<S> s) => pipeline(s.extract());

  static pure(T x) 
}

