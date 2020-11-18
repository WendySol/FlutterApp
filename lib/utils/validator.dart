
class Validator{

  String validateName(String value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.isEmpty) {
      return "El nombre es necesario";
    } else if (!regExp.hasMatch(value)) {
      return "Intente ingresar valores permitidos";
    }
    return null;
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return "El correo es necesario";
    } else if (!regExp.hasMatch(value)) {
      return "Correo invalido";
    } else {
      return null;
    }
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return 'El campo passWord no debe estar vacio';
    } 
  }

 //String validatecel(String value) {
// //  String patttern = r'(^[0-9]*$)';
// //  RegExp regExp = RegExp(patttern);

//     if (value.length == 0) {
//       return "El telefono es necesariod";
//     } else if (value.length != 9) {
//       return "El numero debe tener 9 digitos";
//     }
//     return null;
//   }

}