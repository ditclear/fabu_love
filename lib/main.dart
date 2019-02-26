// This example shows a [Scaffold] with an [AppBar], a [BottomAppBar] and a
// [FloatingActionButton]. The [body] is a [Text] placed in a [Center] in order
// to center the text within the [Scaffold] and the [FloatingActionButton] is
// centered and docked within the [BottomAppBar] using
// [FloatingActionButtonLocation.centerDocked]. The [FloatingActionButton] is
// connected to a callback that increments a counter.

import 'package:fabu_love/di/module.dart';
import 'package:fabu_love/helper/widget_utils.dart';
import 'package:fabu_love/model/model.dart';
import 'package:fabu_love/model/repo.dart';
import 'package:fabu_love/viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:rxdart/rxdart.dart';

import 'components/dialog.dart';
import 'di/module.dart';
import 'view/auth/welcome.dart';
import 'view/home/home.dart';

void main() {
  init();
  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  Widget _dispatch() {
    return WelcomeWidget();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Code Sample for material.Scaffold',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //注册路由表
      routes: {'login': (_) => MyStatefulWidget()},
      home: _dispatch(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() =>
      _MyStatefulWidgetState(AuthViewModel(provideAuthRepo()));
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final AuthViewModel _viewModel;
  final loading = LoadingDialog();

//  final Dialog _loading;
  _MyStatefulWidgetState(this._viewModel) {
    providers.provide(Provider<AuthViewModel>.value(_viewModel));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
    _compositeSubscription.dispose();
    _viewModel.dispose();
  }

  CompositeSubscription _compositeSubscription = CompositeSubscription();

  _login(BuildContext context) {
    var s = _viewModel
        .login()
        .doOnListen(() => showLoading(context, loading))
        .doOnResume(() {
      print("doOnResume");
    }).doOnDone(() {
      print("onDone");
    }).listen((data) {
      print("成功了");
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BackdropDemo(), fullscreenDialog: true),
      );
    }, onError: ((e) {
      Navigator.pop(context);
      dispatchFailure(context, e);
    }));
    _compositeSubscription.add(s);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('fabu.love'),
      ),
      body: Container(
          padding: const EdgeInsets.all(30.0),
          child: Provide<AuthViewModel>(
            builder:
                (BuildContext context, Widget child, AuthViewModel value) =>
                    Column(
                      children: <Widget>[
                        TextField(
                          controller: TextEditingController.fromValue(
                              TextEditingValue(
                                  text: _viewModel.username,
                                  selection: TextSelection.collapsed(
                                      offset: _viewModel.username.length))),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            icon: Icon(Icons.person),
                            labelText: '账号',
                          ),
                          autofocus: false,
                          onChanged: (str) => _viewModel.username = str,
                        ),
                        TextField(
                          controller: TextEditingController.fromValue(
                              TextEditingValue(
                                  text: _viewModel.password,
                                  selection: TextSelection.collapsed(
                                      offset: _viewModel.password.length))),
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            icon: Icon(Icons.lock),
                            labelText: '密码',
                          ),
                          autofocus: false,
                          onChanged: (str) => _viewModel.password = str,
                        ),
                        Provide<CountViewModel>(
                          builder: (BuildContext context, Widget child,
                                  CountViewModel value) =>
                              Text("count:" + value.count.value.toString()),
                        ),
                      ],
                    ),
          )),
      floatingActionButton: Builder(builder: (BuildContext context) {
        return Padding(
            padding: const EdgeInsets.all(16.0),
            child: FloatingActionButton(
              onPressed: () => _login(context),
              tooltip: 'login',
              child: Icon(Icons.person_pin),
            ));
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class AuthViewModel extends BaseViewModel {
  final _username = ValueNotifier<String>("");
  final _password = ValueNotifier<String>("");
  final AuthRepo _repo;

  AuthViewModel(this._repo);

  get username => _username.value;

  get password => _password.value;

  set username(value) {
    _username.value = value;
  }

  set password(value) {
    _password.value = value;
  }

  Observable<DataBean> login() =>
      _repo.login({"username": "$username", "password": "$password"});
}
