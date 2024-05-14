import 'dart:ffi';

dynamic a;
Object b = "";

final str = 'hi world';
const str1 = 'hi world';

void testMain() {
  // var t = 'hi world';
  // t = 1000;

  dynamic t;
  Object x;
  t = 'hi world.';
  x = 'hello world';
  t = 1000;
  x = 1000;

  a = "";
  printLengths();

  // int i;
  // print(i * 8);

  //默认为不可空，必须在定义时初始化。
  // int i = 8;
  //定义为可空类型，对于可空变量，我们在使用前必须判空。
  // int? j;
  //如果我们预期变量不能为空，但在定义时不能确定其初始值，则可以加上late关键字，
  // 表示会稍后初始化，但是在正式使用它之前必须保证初始化过了，否则会报错
  // late int k;
  // k = 9;
}

void printLengths() {
  // print(a.length);
  // print(b.length);
}

int? i;
Function? fun;
say() {
  if (i != null) {
    //因为已经判过空，所以早到这i必不为null，如果没有显示申明，则IDE会报错
    print(i! * 8);
  }
  if (fun != null) {
    //同上
    fun!();
  }

  fun?.call(); //fun 不为空时则会调用
}

final numbers = <int?>[1, 2, 3, null];
final _nobleGases = List.of(numbers);

// typedef bool CALLBACK();

// //不指定返回类型，此时默认为dynamic，不是bool
// bool isNoble(int automicNumber) {
//   return _nobleGases[automicNumber] != null;
// }

// void test(CALLBACK cb) {
//   print(cb());
// }

// testCALLBACK() {
//   test(isNoble);
// }

var say1 = (str) {
  print(str);
};

void test2() {
  say1('hi world');
}

void excute(var callback) {
  callback();
}

void test3() {
  excute(() => print('xxx'));
}

String say3(String from, String msg, [String? device]) {
  var result = '$from says $msg';
  if (device != null) {
    result = '$result with a $device';
  }
  return result;
}

void test4() {
  say3('Bob', 'Howdy'); //结果是： Bob says Howdy

  say3('Boc', 'Howdy',
      'smoke signal'); //结果是： Bob says  Howdy with a smoke signal.
}

void enableFlags({bool? bold, bool? hidden}) {
  //
}

void test5() {
  enableFlags(bold: true, hidden: true);
}

class Person {
  say() {
    print('say');
  }
}

mixin Eat {
  eat() {
    print('eat');
  }
}

mixin Walk {
  walk() {
    print('walk');
  }
}

mixin Code {
  code() {
    print('key');
  }
}

class Dog with Eat, Walk {}

class Man extends Person with Eat, Walk, Code {}

void test6() {
  Future.delayed(Duration(seconds: 2), () {
    return 'hi world';
  }).then((data) {
    print(data);
  });

  Future.delayed(Duration(seconds: 2), () {
    throw AssertionError("Error");
  }).then((value) {
    //执行成功会走到这里
    print('success');
  }).catchError((e) {
    //执行失败会走到这里
    print(e);
  });

  Future.delayed(Duration(seconds: 2), () {
    throw AssertionError('error');
  }).then((value) {
    print('success');
  }, onError: (e) {
    print(e);
  });

  Future.delayed(Duration(seconds: 2), () {
    throw AssertionError('error');
  }).then((value) {
    print(value);
  }).catchError((e) {
    print(e);
  }).whenComplete(() {
    //无论成功或失败都会走到这里
  });
}
