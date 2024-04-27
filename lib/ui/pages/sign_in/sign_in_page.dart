import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinhcine/ui/components/app_button.dart';
import 'package:vinhcine/ui/pages/sign_in/sign_in_cubit.dart';

import '../../../commons/app_text_styles.dart';
import '../../../configs/app_colors.dart';
import '../../../router/routers.dart';

class SignInPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignInPageState();
  }
}

class _SignInPageState extends State<SignInPage> {
  final _usernameController = TextEditingController(text: "acc1@gmail.com");
  final _passwordController = TextEditingController(text: "123456");

  late SignInCubit _cubit;

  @override
  void initState() {
    _cubit = context.read<SignInCubit>();
    super.initState();
    _cubit.stream.listen((state) {
      if (state.signInStatus == SignInStatus.FAILURE) {
        _showMessage('Login failure');
      } else if (state.signInStatus == SignInStatus.SUCCESS) {
        // Navigator.pop(context);
        Navigator.pushReplacementNamed(context, Routers.home);
      } else if (state.signInStatus == SignInStatus.USERNAME_PASSWORD_INVALID) {
        _showMessage('Wrong Username or Password');
      }
    });
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: buildBodyWidget(),
    );
  }

  Widget buildBodyWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Sign In',
          style: TextStyle(
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 64),
        Container(
          height: 48,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            controller: _usernameController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Username',
              hintStyle: AppTextStyle.poppins16Medium
                  .copyWith(color: AppColors.textGray),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        SizedBox(height: 12),
        Container(
          height: 48,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            controller: _passwordController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Password',
              hintStyle: AppTextStyle.poppins16Medium
                  .copyWith(color: AppColors.textGray),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        SizedBox(height: 32),
        _buildSignButton(),
        const SizedBox(height: 16),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, Routers.signUp);
          },
          child: Text("Don't have an account? Sign up",
              style: AppTextStyle.poppins14Medium
                  .copyWith(color: AppColors.white)),
        ),
      ],
    );
  }

  Widget _buildSignButton() {
    return BlocBuilder<SignInCubit, SignInState>(
      buildWhen: (prev, current) {
        return prev.signInStatus != current.signInStatus;
      },
      builder: (context, state) {
        final isLoading = state.signInStatus == SignInStatus.LOADING;
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: AppWhiteButton(
            title: 'Sign In',
            onPressed: isLoading ? null : _signIn,
            isLoading: isLoading,
          ),
        );
      },
    );
  }

  void _signIn() {
    final username = _usernameController.text;
    final password = _passwordController.text;
    if (username.isEmpty) {
      _showMessage('Username is invalid');
      return;
    }
    if (password.isEmpty) {
      _showMessage('Password is invalid');
      return;
    }
    _cubit.signIn(username, password);
  }

  void _showMessage(String message) {
    var snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
