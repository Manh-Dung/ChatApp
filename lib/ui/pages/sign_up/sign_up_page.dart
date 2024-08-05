import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinhcine/main.dart';
import 'package:vinhcine/ui/pages/sign_in/cubit/auth_cubit.dart';
import 'package:vinhcine/ui/pages/sign_up/cubit/image_cubit.dart';

import '../../../commons/app_text_styles.dart';
import '../../../configs/app_colors.dart';
import '../../../configs/di.dart';
import '../../../generated/l10n.dart';
import '../../../network/constants/constant_urls.dart';
import '../../components/app_button.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpPageState();
  }
}

class _SignUpPageState extends State<SignUpPage> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // late AuthCubit _cubit;

  @override
  void initState() {
    // _cubit = context.read<AuthCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: _buildBodyWidget(),
    );
  }

  void _showMessage(String message) {
    var snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _buildBodyWidget() {
    return Column(
      children: [
        const SizedBox(height: 150),
        BlocBuilder<ImageCubit, ImageState>(
          bloc: context.read<ImageCubit>(),
          builder: (context, state) {
            return InkWell(
              onTap: () async {
                context.read<ImageCubit>().pickImage();
              },
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.15,
                backgroundImage: state.whenOrNull(
                    success: (image) => FileImage(image),
                    failure: (message) =>
                        NetworkImage(ConstantUrls.placeholderImageUrl)),
              ),
            );
          },
        ),
        const SizedBox(height: 48),
        Container(
          height: 48,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            controller: _fullNameController,
            decoration: InputDecoration(
              hintText: S.of(context).full_name,
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
        const SizedBox(height: 12),
        Container(
          height: 48,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Email',
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
        const SizedBox(height: 12),
        Container(
          height: 48,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            controller: _passwordController,
            keyboardType: TextInputType.emailAddress,
            obscureText: true,
            decoration: InputDecoration(
              hintText: S.of(context).password,
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
        const SizedBox(height: 24),
        _buildSignUpButton(),
        Spacer(),
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text(S.of(context).already_have_an_account,
              style: AppTextStyle.poppins14Medium
                  .copyWith(color: AppColors.white)),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSignUpButton() {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.authStatus == AuthStatus.failure) {
          hideLoading();
          _showMessage(S.of(context).sign_up_failure);
        } else if (state.authStatus == AuthStatus.success) {
          hideLoading();
          _showMessage(S.of(context).sign_up_success);
          Navigator.pop(context);
        } else if (state.authStatus == AuthStatus.loading) {
          showLoading();
        }
      },
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: AppWhiteButton(
            title: S.of(context).sign_up,
            onPressed: _signUp,
            isLoading: state.authStatus == AuthStatus.loading,
          ),
        );
      },
    );
  }

  void _signUp() async {
    final fullName = _fullNameController.text;
    final username = _emailController.text;
    final password = _passwordController.text;

    final image = context.read<ImageCubit>().state;

    if (username.isEmpty) {
      _showMessage(S.of(context).email_is_invalid);
      return;
    }
    if (password.isEmpty) {
      _showMessage(S.of(context).password_is_invalid);
      return;
    }
    await getIt<AuthCubit>().signUp(
        file: image.whenOrNull(success: (file) => file) ?? null,
        fullName: fullName,
        email: username,
        password: password);
  }
}
