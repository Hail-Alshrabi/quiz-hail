
class FormValidator{


  static String? passwordValidator(String? value) {
    if(value == null || value.isEmpty){
      return 'الرجاء إدخال كلمة المرور';
    }
    return null;
  }

  static String? fieldValidator(String? value) {
    if(value == null || value.isEmpty){
      return 'الحقل فارغ';
    }
    return null;
  }
}