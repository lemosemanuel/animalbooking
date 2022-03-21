import 'package:animal_booking/providers/login_form_provider.dart';
import 'package:animal_booking/services/services.dart';
import 'package:animal_booking/ux_ui/text_style.dart';
import 'package:animal_booking/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:animal_booking/ux_ui/input_decorations/input_decorations.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
   
  const LoginScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              
              const SizedBox(height: 250,),
              // build a Card with a Login Form
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 10,),
                    Text("Login",style: TextStyle(fontSize: 33,fontWeight: FontWeight.bold,color: Colors.black45),),

                    const SizedBox(height: 30,),

                    ChangeNotifierProvider(
                      create: (context)=>LoginFormProvider(),
                      child: const _LoginForm(),
                      ),

                  ],
                ) ,
              )
            ],
          ),
        )
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginForm= Provider.of<LoginFormProvider>(context);
    return Container(
      
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [

            // email form
            _emailForm(loginForm),

            SizedBox(height: 30,),

            // password form
            _passwordForm(loginForm),

            SizedBox(height: 30,),

            _buttonLogin(context,loginForm),
            SizedBox(height: 30,),

            TextButton(
              onPressed: ()=>Navigator.pushReplacementNamed(context, 'registerone'), 
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(StadiumBorder())
                ),
              child: const Text('Crear una nueva cuenta',style: TextStyle(fontSize: 18,color: Colors.black38),))

          ],
        )
      ),
    );
  }

  MaterialButton _buttonLogin(BuildContext context,LoginFormProvider loginForm) {
    return MaterialButton(
            onPressed: loginForm.isLoading? null: () async{

            // rome the keyboard when clicked
            FocusScope.of(context).unfocus();
            final authService= Provider.of<AuthService>(context,listen: false);

            if (!loginForm.isValidForm())return;
            loginForm.isLoading=true;

            final String? resp= await authService.login(loginForm.email, loginForm.password);
            if(resp == null){
              Navigator.pushReplacementNamed(context, 'home');
            }else{
              print(resp);
              NotificationsService.showSnackbar(resp);
              loginForm.isLoading=false;
            }
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.amber,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80,vertical: 15),
              child: Text(loginForm.isLoading?'Espere':'Ingresar',style: const TextStyle(color: Colors.white),),
            ),
          );
  }

  TextFormField _passwordForm(LoginFormProvider loginForm) {
    return TextFormField(
            style: const TextStyle(
                  color: Colors.black
                ),
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(hinText: '*******',labelText: 'Password',prefixIcon: Icons.lock_outline),
            onChanged: (value) => loginForm.password=value,
            validator: (value) {
              // retorno null... osea pasa la validacion solo si es mayor a 6
              return (value !=null && value.length>=6)
                ? null
                : 'La Password debe tener mas de 6 caracteres';
            },
          );
  }

  TextFormField _emailForm(LoginFormProvider loginForm) {
    return TextFormField(
            style: const TextStyle(
                        color: Colors.black
                      ),
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(hinText: 'tuEmail@gmail.com',labelText: 'Correo Electronico',prefixIcon: Icons.alternate_email_sharp),
            onChanged: (value)=>loginForm.email=value,
            validator: (value) {
              String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp  = new RegExp(pattern);
              return regExp.hasMatch(value ?? '')
                    ? null
                    : 'Escriba un Email real';
            },
          );
  }
}