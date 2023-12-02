import 'package:budget_buddy/resources/app_export.dart';
import 'package:budget_buddy/resources/widget/custom_elevated_button.dart';
import 'package:budget_buddy/resources/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key})
      : super(
          key: key,
        );

  @override
  SignUpViewState createState() => SignUpViewState();
}

class SignUpViewState extends State<SignUpView> {
  TextEditingController fullNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  bool isPasswordHiding = true;

  void changePasswordHidingState() {
    setState(() {
      isPasswordHiding = !isPasswordHiding;
    });
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(
            left: 30.h,
            right: 30.h,
            top: 50.v,
            bottom: 6.v
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  'assets/images/arrow.png',
                  height: 23.adaptSize,
                  width: 23.adaptSize,
                ),
              ),
              SizedBox(height: 22.v),
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 218.h,
                  child: Text(
                    "Create your \nnew account",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
              ),
              SizedBox(height: 42.v),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.h),
                child: CustomTextFormField(
                  controller: fullNameController,
                  hintText: "Full name",
                ),
              ),
              SizedBox(height: 32.v),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.h),
                child: CustomTextFormField(
                  controller: emailController,
                  hintText: "Email",
                  textInputType: TextInputType.emailAddress,
                ),
              ),
              SizedBox(height: 32.v),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.h),
                child: CustomTextFormField(
                  controller: passwordController,
                  hintText: "Password",
                  textInputType: TextInputType.visiblePassword,
                  suffix: Container(
                    margin: EdgeInsets.fromLTRB(30.h, 11.v, 16.h, 9.v),
                    child: Image.asset(
                      isPasswordHiding ? 'assets/images/hide.png' : 'assets/images/view.png',
                      height: 25.adaptSize,
                      width: 25.adaptSize,
                    ),
                  ),
                  suffixConstraints: BoxConstraints(
                    maxHeight: 45.v,
                  ),
                  obscureText: isPasswordHiding,
                  contentPadding: EdgeInsets.only(
                    left: 18.h,
                    top: 14.v,
                    bottom: 14.v,
                  ),
                ),
              ),
              SizedBox(height: 32.v),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.h),
                child: CustomTextFormField(
                  controller: confirmPasswordController,
                  hintText: "Confirm password",
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.visiblePassword,
                  obscureText: true,
                  contentPadding: EdgeInsets.only(
                    left: 18.h,
                    top: 14.v,
                    bottom: 14.v,
                  ),
                ),
              ),
              SizedBox(height: 45.v),
              CustomElevatedButton(
                text: "SIGN UP",
                margin: EdgeInsets.only(
                  left: 6.h,
                  right: 6.h,
                ),
              ),
              SizedBox(height: 40.v),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 9.v),
                      child: SizedBox(
                        width: 95.h,
                        child: const Divider(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12.h, right: 12.h),
                      child: Text(
                        "or",
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppTheme.grey400),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 9.v),
                      child: SizedBox(
                        width: 95.h,
                        child: const Divider(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 37.v),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 43.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 65.v,
                      width: 80.h,
                      padding: EdgeInsets.symmetric(
                        horizontal: 25.h,
                        vertical: 12.v,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppTheme.grey400),
                        borderRadius: BorderRadius.circular(15.h),
                      ),
                      child: Image.asset(
                        'assets/images/facebook.png',
                        height: 35.adaptSize,
                        width: 35.adaptSize,
                        alignment: Alignment.center,
                      ),
                    ),
                    SizedBox(width: 26.h),
                    Container(
                      height: 65.v,
                      width: 80.h,
                      padding: EdgeInsets.symmetric(
                        horizontal: 25.h,
                        vertical: 12.v,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppTheme.grey400),
                        borderRadius: BorderRadius.circular(15.h)
                      ),
                      child: Image.asset(
                        'assets/images/gmail.png',
                        height: 35.adaptSize,
                        width: 35.adaptSize,
                        alignment: Alignment.center,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 37.v),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Already have an account? ",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black),
                    ),
                    TextSpan(
                      text: "Sign in",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(color: AppTheme.green800),
                    ),
                  ],
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
  }
}
