import 'package:f_state/f_state.dart';
import 'package:kinder/kinder.dart';

/* 
example:

String => Option[String] //stringToNonEmptyString
          String => Option[Int] //stringToNumber

*/

// simple function
int increment(int value) => value + 1;
String toStr(int value) => value.toString();

// monad function
Pipeline2 monadicIncrement(num x) {
  try {
    return Pipeline2(Value(x + 1));
  } catch (e) {
    return Pipeline2(Nothing());
  }
}

Pipeline2 monadicInverse(num x) {
  if (x == 0) {
    return Pipeline2(Nothing());
  } else {
    return Pipeline2(Value(1 / x));
  }
}

// monad function
MetaState monadicToStr(num x) {
  try {
    return Value('$x');
  } catch (e) {
    return Nothing();
  }
}

/* 
MetaFunc monadicInverse(num value) {
  if (num == 0) {
    return (_) => Nothing();
  }
  return (value) => Value(1 / value);
} */

void main() {
  Value<int> value = Value(10);
  //Pipeline pipeline = Pipeline(initial: Value.id);
  /* pipeline
      .bind(monadicIncrement)
      .bind(monadicIncrement)
      .bind(monadicInverse)
      .bind(monadicToStr)
      .bind(monadicIncrement); // Error bind !!! */

  /* pipeline
      .bind(monadicIncrement)
      .bind(monadicIncrement)
      .bind(badMonadicIncrement); // Error bind !!! */

  /* pipeline
      .bind(monadicIncrement)
      .bind(monadicToStr)
      .bind(monadicIncrement); // Error bind !!! */

/*   var p = Combinator.combine(
      (int x) => Value<int>(x + 5), (int x) => Value<String>('$x'));

  var p2 = Combinator.combine(p, (int x) => Value<String>('$x')); */

/*   var comb = Combinator2();

  comb
      .bind((int x) => Value<int>(x + 5))
      .bind((int x) => Value<String>('$x'))
      .bind((int x) => Value<String>('$x')); */

/*   var p = Pipeline((int x) => Value<int>(x))
      .bind((int x) => Value<int>(x + 5))
      .bind((int x) => Value<String>('$x')); // error */

  var p = Pipeline2(monadicIncrement)
      .bind(monadicIncrement)
      .bind(monadicInverse); // error

  var r = StateR(Value<int>(10));

  //var result = Pipeline(monadicIncrement);
  var result = r.apply((int x) => x + 10);

  print(result.extract());

/*   var p = Pipeline.create((int x) => Value<int>(x + 5))
      .bind((int x) => Value<String>('$x')); */

/*   var badP = Pipeline()
      .bind((int x) => Value<String>(x.toString()))
      .bind((String x) => Value<bool>(x.length > 5))
      .bind((int x) => Value<String>(x.toString())); */

  //var result = p.produce(value);
  //print(result.extract()); // Output: false

  //print(pipeline.produce(value).extract());
}
