import 'package:flutter/material.dart';
import 'package:flutter_phone_mama/providers/auth.dart';
import 'package:provider/provider.dart';
import 'dart:math';

enum AuthMode { Signup, Singin }

class AuthScreen extends StatelessWidget {
  static const String routeName = "/auth-screen";

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(251, 117, 255, 1).withOpacity(0.5),
                    Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0, 1]),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              width: deviceSize.width,
              height: deviceSize.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20),
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 94.0),
                      transform: Matrix4.rotationZ(-8 * pi / 180)
                        ..translate(10.0),
                      decoration: BoxDecoration(
                          color: Colors.deepOrange.shade900,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 8,
                                color: Colors.black26,
                                offset: Offset(0, 2))
                          ]),
                      child: Text(
                        "MyShop",
                        style: TextStyle(
                            color:
                                Theme.of(context).accentTextTheme.title.color,
                            fontSize: 50,
                            fontFamily: 'Anton',
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Singin;
  Map<String, String> _authData = {"email": "", "password": ""};
  var _isLoading = false;
  var _obscureText = true;
  var _conObscureText = true;
  final passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  void _toggleAuthMode() {
    setState(() {
      if (_authMode == AuthMode.Singin) {
        _authMode = AuthMode.Signup;
      } else if (_authMode == AuthMode.Signup) {
        _authMode = AuthMode.Singin;
      }
    });
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });

    if (_authMode == AuthMode.Singin) {
      print("email: ${_authData['email']}, password: ${_authData['password']}");
      Future.delayed(Duration(seconds: 5), () {
        setState(() {
          _isLoading = false;
        });
      });
    } else if (_authMode == AuthMode.Signup) {
      try {
        await Provider.of<Auth>(context, listen: false)
            .signup(_authData['email'], _authData['password']);
        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Error"),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 8,
      child: Container(
        height: _authMode == AuthMode.Singin ? 320 : 260,
        width: deviceSize.width * 0.75,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 320 : 260),
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  maxLines: 1,
                  decoration: const InputDecoration(
                      labelText: "E-Mail", hintText: "Enter Your Email"),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_passwordFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return "E-Mail Can't Be Empty!";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['email'] = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Enter Your Password",
                      suffixIcon: IconButton(
                        icon: Icon((_obscureText)
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      )),
                  textInputAction: (_authMode == AuthMode.Singin)
                      ? TextInputAction.done
                      : TextInputAction.next,
                  obscureText: _obscureText,
                  maxLines: 1,
                  controller: passwordController,
                  focusNode: _passwordFocusNode,
                  onFieldSubmitted: (_) {
                    if (_authMode == AuthMode.Signup) {
                      FocusScope.of(context)
                          .requestFocus(_confirmPasswordFocusNode);
                    }
                  },
                  onSaved: (value) {
                    _authData['password'] = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Empty Password!";
                    }
                    if (value.length <= 6) {
                      return "Password Short!";
                    }
                    return null;
                  },
                ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Confirm Password",
                        hintText: "Check Password",
                        suffixIcon: IconButton(
                          icon: Icon((_conObscureText)
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _conObscureText = !_conObscureText;
                            });
                          },
                        )),
                    obscureText: _conObscureText,
                    focusNode: _confirmPasswordFocusNode,
                    enabled: _authMode == AuthMode.Signup,
                    maxLines: 1,
                    validator: (_authMode == AuthMode.Signup)
                        ? (value) {
                            if (value.isEmpty) {
                              return "Password Empty!";
                            }
                            if (value.length <= 6) {
                              return "Password Short!";
                            }
                            if (value != passwordController.text) {
                              return "Password Don't Match";
                            }
                            return null;
                          }
                        : null,
                  ),
                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  RaisedButton(
                    child: Text(
                        (_authMode == AuthMode.Singin) ? "Sign in" : "Sign up"),
                    onPressed: () {
                      _submitForm();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).primaryTextTheme.button.color,
                  ),
                FlatButton(
                  child: Text(
                      "${_authMode == AuthMode.Singin ? "SIGNUP" : "SIGNIN"} INSTEAD!"),
                  onPressed: () {
                    _toggleAuthMode();
                  },
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Theme.of(context).primaryColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
