import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../commons/app_text_styles.dart';
import '../../../configs/app_colors.dart';
import '../../../generated/l10n.dart';
import '../../../network/constants/constant_urls.dart';
import '../../components/app_button.dart';
import 'sign_up_cubit.dart';

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
  File? selectedImage;

  late SignUpCubit _cubit;

  @override
  void initState() {
    _cubit = context.read<SignUpCubit>();
    super.initState();

    _cubit.stream.listen((state) {
      if (state.signUpStatus == SignUpStatus.FAILURE) {
        _showMessage(S.of(context).sign_up_failure);
      } else if (state.signUpStatus == SignUpStatus.SUCCESS) {
        _showMessage(S.of(context).sign_up_success);
        Navigator.pop(context);
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
        BlocBuilder<SignUpCubit, SignUpState>(
          buildWhen: (prev, current) {
            return prev.pickImageStatus != current.pickImageStatus;
          },
          builder: (context, state) {
            return InkWell(
              onTap: () async {
                selectedImage = await _cubit.pickImage();
              },
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.15,
                backgroundImage: selectedImage != null
                    ? FileImage(selectedImage!)
                    : NetworkImage(ConstantUrls.placeholderImageUrl)
                        as ImageProvider,
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
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (prev, current) {
        return prev.signUpStatus != current.signUpStatus;
      },
      builder: (context, state) {
        final isLoading = state.signUpStatus == SignUpStatus.LOADING;
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: AppWhiteButton(
            title: S.of(context).sign_up,
            onPressed: isLoading ? null : _signUp,
            isLoading: isLoading,
          ),
        );
      },
    );
  }

  void _signUp() async {
    final fullName = _fullNameController.text;
    final username = _emailController.text;
    final password = _passwordController.text;
    if (username.isEmpty) {
      _showMessage(S.of(context).email_is_invalid);
      return;
    }
    if (password.isEmpty) {
      _showMessage(S.of(context).password_is_invalid);
      return;
    }
    await _cubit.signUp(
        file: selectedImage ?? null,
        fullName: fullName,
        email: username,
        password: password);
  }
}
