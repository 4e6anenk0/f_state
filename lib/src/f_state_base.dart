/* 
MetaStateState - це монада та комонада, як загальна сутність
Value -> Nothing, Value - монада для значень огорнутих у контекст
State - це комонада для монад Value, яка реалізує зберігання контексту обчислень стану,
а також трансформатор для комбінації змін стейту через інші монади або комонади
StateTransformer - це клас, 
який реалізує можливості трансформації значень між різними контекстами

# bind:
a -> m(b) <bind> b -> m(c) >> a -> m(c)
bind: a -> m(b) - is MetaStateicFunc

# map:
a -> b <map> m(a) >> m(b)

# apply:
m(a -> b) -> m(a) >> m(b)

apply + return = map

*/

/// Functions:

T2 identity<T1, T2>(T1 x) => x as T2;

/* T extractor<T>(MetaState<T> stateValue) => stateValue.extract(); */

class Pipeline<T1, T2> {
  MetaState<T2> Function(T1) _storedFunc;

  Pipeline({MetaState<T2> Function(T1)? func}) : _storedFunc = func ?? identity;

  Pipeline bind(MetaState<T2> Function(T1) f) {
    MetaState<T2> Function(T1) bindOutputFunc =
        MetaState.bind(wrapedFunc: _storedFunc, wraperFunc: f);
    _storedFunc = bindOutputFunc;
    return this;
  }

  MetaState<T2> produce(state) {
    return _storedFunc(state);
  }
}

abstract class MetaState<T> {
  static T extractor<T>(MetaState<T> x) => x.extract();

  T extract();

  static MetaState<T2> Function(T1) bind<T1, T2>(
      {required MetaState<T2> Function(T1) wraperFunc,
      required MetaState<T2> Function(T1) wrapedFunc}) {
    return (T1 x) => wraperFunc(extractor(wrapedFunc(x) as MetaState<T1>));
  }
}

class FState<T> extends MetaState<T> {
  @override
  T extract() {
    // TODO: implement extract
    throw UnimplementedError();
  }

  @override
  B match<B>(B Function() f1, B Function(T t) f2) {
    // TODO: implement match
    throw UnimplementedError();
  }
}

class Value<T> extends MetaState<T> {
  late final T _value;
  //Function func = (x) => Value(x);

  Value(this._value);

  //Value.withFunction(this._value, this.func);

  Value run(Function f) => f(_value);

  /* Value bind(Function f) {
    extractor(Value a) => a.extract();
    return Value.withFunction(_value, (x) => f(extractor(func(x))));
  } */

  @override
  T extract() => _value;

  @override
  B match<B>(B Function() f1, B Function(T t) f2) {
    // TODO: implement match
    throw UnimplementedError();
  }
}

/* class Nothing<Null> extends MetaState {
  final _value = null;
  Nothing get value => identity(this);

  @override
  extract() => identity(_value);
} */



/* abstract class IMetaState<T> {
  MetaStateicFunc<A> bind<A>(MetaStateicFunc<A> f);
  MetaStateicFunc<A> bindCompose<A, B>(MetaStateicFunc<A> f, MetaStateicFunc<B> f2);
  fmap<T2>(T2 Function(T) f);
  //static T run(MetaStateicFunc f);
}

class Value<T> extends Identity implements IMetaState {
  final T _value;

  Function(T) get value => identity(this._value);

  Value(this._value);

  @override
  fmap<B>(B Function(T) f) {
    throw UnimplementedError();
  }

  @override
  MetaStateicFunc<A> bind<A>(MetaStateicFunc<A> f) {
    throw UnimplementedError();
  }

  static Value<T> wrap<T>(T value) {
    return Value(value);
  }

  @override
  IMetaState bindCompose<A, B>(MetaStateicFunc<A> f1, MetaStateicFunc<B> f2) {
    return Value((A a) => f2(run(f1(a) as IMetaState) as B));
    //return (A a) => f2(run(f1(a) as IMetaState) as B);
  }

  T run(MetaStateicFunc f) {
    return identity(f(value));
  }
}

class Nothing implements IMetaState {
  Nothing value(_) => Nothing();

  @override
  fmap<B>(Function f) => Nothing();

  @override
  MetaStateicFunc<A> bindCompose<A, B>(MetaStateicFunc<A> f, MetaStateicFunc<B> f2) {
    // TODO: implement bindCompose
    throw UnimplementedError();
  }

  @override
  IMetaState wrap<A, B>(IMetaState<A> MetaState) {
    // TODO: implement wrap
    throw UnimplementedError();
  }

  @override
  MetaStateicFunc<A> bind<A>(MetaStateicFunc<A> f) {
    // TODO: implement bind
    throw UnimplementedError();
  }
}

/// MetaStateState - монада, що описує базовий стейт
abstract class MetaStateState<T extends IMetaState> {
  /// put value in the state
  MetaStateState<IMetaState> put(IMetaState value);
} */

/// Container - це обгортка (монада) яка транспортує стан між прошарками застосунку
/// цю обгортку можна також інтерпретувати як монаду Maybe
//class Container extends MetaStateState {}

/// Трансформатор
/* class StateTransformer<V> extends MetaStateState {}

class State<V, V2> extends StateTransformer<V> {
  V2 Function(V) _value;

  get value => _value;

  set valueInit(value) {
    _value = (value) => value as V2;
  }

  set value(value) {
    _value = value;
  }

  State({required value}) {
    this.value = value;
  }

  /* State.init({required value}) {
    this.valueInit = value;
  } */

  static State<V> init<V>(V value) {
    return State(value: (value) => value);
  }

  State<V2> bind<V2>(Function func) {
    Function newStateFunction = func(value);
    return State(value: newStateFunction);
  }

  V run() {
    return this.value();
  }
}
 */
