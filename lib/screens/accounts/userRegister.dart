
import 'package:flutter/material.dart';
import 'package:parties_hall_app/constants/string_constants.dart';
import 'package:parties_hall_app/widgets/toast.dart';
import 'package:provider/provider.dart';

import '../../constants/assets_path.dart';
import '../../constants/colors_constants.dart';
import '../../helper/common_helper.dart';
import '../../helper/form_validator.dart';
import '../../providers/AuthProvider.dart';
import '../../services/endpoint.dart';
import '../../utils/progressIndicatorDialog.dart';
import '../../utils/style.dart';
import '../../widgets/components.dart';
import '../../widgets/customButton.dart';
import '../../widgets/customTextForm.dart';
import '../../widgets/customTextFormPassword.dart';
import '../home.dart';
import '../homePage.dart';


class UserRegister extends StatefulWidget {
  const UserRegister({Key? key}) : super(key: key);

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final _formKey = GlobalKey<FormState>();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  void loginUser(BuildContext context, AuthProvider myProvider) async {

    bool myValid = _formKey.currentState!.validate();
    if (myValid) {
      if (await CommonHelper.checkInternetConnection()) {

        Map mapLogin = {
          'fullName': nameController.text.toString().trim(),
          'phoneNumber': phoneNumberController.text.toString().trim(),
          'password': passwordController.text.toString().trim(),
          'emailUser': emailController.text.toString().trim(),
          'address': addressController.text.toString().trim(),
        };

        ProgressIndicatorDialog().show(context, text: 'جاري إنشاء حساب...');

        await myProvider.getRegisterUser(context, mapLogin, EndPoint.userRegister);


        if (!myProvider.loading) {
          if (myProvider.registerUserModel != null) {
            if (myProvider.registerUserModel?.success == true) {
              myProvider.userId = myProvider.registerUserModel?.result?.userId ?? 0;
             
              myProvider.email = myProvider.loginUserModel?.result?.emailUser ?? '';
              // dismiss dialog
              Navigator.of(context).pop();
              navigationPush(context, Home());
            } else {
              Navigator.of(context).pop();

              showToast(message: myProvider.registerUserModel?.message ?? '', state: ToastStates.error);

            }
          }else{
            Navigator.of(context).pop();
          }

        }

      } else {
        showToast(message: txt_notInternet, state: ToastStates.error);

      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();

  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthProvider>(context);
    double _myHeight = CommonHelper.getScreenHeight(context) - CommonHelper.getSizePaddingTopScreen(context);
    double _myWidth = CommonHelper.getScreenWidth(context);
    return Scaffold(
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            color: Colors.white,
            height:_myHeight ,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: _myHeight * 0.05,
                    ),
                    SizedBox(
                      height: _myHeight * 0.15,
                      width: _myWidth * 0.25,
                      child: const Image(
                        fit: BoxFit.cover,
                        image: AssetImage(AssetsPath.icon_launcher),
                      ),
                    ),
                    SizedBox(
                      height: _myHeight * 0.01,
                    ),
                    Text('إنشاء حساب',style: TextStyle(color: AppColor.PrimaryColor,fontSize: 18,),),
                    SizedBox(
                      height: _myHeight * 0.01,
                    ),
                    CustomTextForm(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      hint: 'الإسم',
                      labelText: 'الإسم',
                      validator: FormValidator.fieldValidator,
                      hintColor: AppColor.GreyShade5,
                      textEditController: nameController,
                      actionKeyboard: TextInputAction.done,
                      borderColor: AppColor.PrimaryColor,
                      counterText: '',
                      maxLength: 50,
                      prefixIcon: Icon(
                        Icons.person,
                        color: AppColor.PrimaryColor,
                      ),
                      text_style: black16,
                      labelColor: AppColor.PrimaryColor,
                    ),
                    const SizedBox(height: 10,),
                    CustomTextForm(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      hint: 'إدخل رقم الهاتف',
                      labelText: 'رقم الهاتف',
                      validator: FormValidator.fieldValidator,
                      hintColor: AppColor.GreyShade5,
                      textEditController: phoneNumberController,
                      textInputType: TextInputType.phone,
                      actionKeyboard: TextInputAction.done,
                      borderColor: AppColor.PrimaryColor,
                      counterText: '',
                      maxLength: 9,
                      prefixIcon: Icon(
                        Icons.phone_android,
                        color: AppColor.PrimaryColor,
                      ),
                      text_style: black16,
                      labelColor: AppColor.PrimaryColor,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    CustomTextFormPassword(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      hint: 'إدخل كلمة المرور',
                      labelText: 'كلمة المرور',
                      validator: FormValidator.passwordValidator,
                      hintColor: AppColor.GreyShade5,
                      textEditController: passwordController,
                      textInputType: TextInputType.visiblePassword,
                      actionKeyboard: TextInputAction.done,
                      borderColor: AppColor.PrimaryColor,
                      counterText: '',
                      maxLength: 30,
                      prefixIcon: Icon(
                        Icons.lock,
                        color: AppColor.PrimaryColor,
                      ),
                      suffixIcon: Icon(
                        Icons.visibility_off,
                        color: Colors.white,
                      ),
                      text_style: black16,
                      labelColor: AppColor.PrimaryColor,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    CustomTextForm(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      hint: 'الايميل',
                      labelText: 'الايميل',
                      validator: FormValidator.fieldValidator,
                      hintColor: AppColor.GreyShade5,
                      textEditController: emailController,
                      actionKeyboard: TextInputAction.done,
                      borderColor: AppColor.PrimaryColor,
                      counterText: '',
                      maxLength: 100,
                      prefixIcon: Icon(
                        Icons.email,
                        color: AppColor.PrimaryColor,
                      ),
                      text_style: black16,
                      labelColor: AppColor.PrimaryColor,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    CustomTextForm(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      hint: 'العنوان',
                      labelText: 'العنوان',
                      validator: FormValidator.fieldValidator,
                      hintColor: AppColor.GreyShade5,
                      textEditController: addressController,
                      actionKeyboard: TextInputAction.done,
                      borderColor: AppColor.PrimaryColor,
                      counterText: '',
                      maxLength: 20,
                      prefixIcon: Icon(
                        Icons.location_pin,
                        color: AppColor.PrimaryColor,
                      ),
                      text_style: black16,
                      labelColor: AppColor.PrimaryColor,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    CustomButton(
                      onPressed: () {
                        loginUser(context, loginProvider);
                      },
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 8.0),
                      width: _myWidth,
                      bgColor: AppColor.PrimaryColor,
                      bgOverlayColor: Colors.white.withOpacity(0.8),
                      txtColor: Colors.white,
                      text: 'إنشاء حساب',
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


}
