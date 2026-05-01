import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(List<String> args) {
  runApp(KuaforrApp());
}

class KuaforrApp extends StatelessWidget {
  const KuaforrApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _girilenSifre = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 190, 118, 174),
        title: Text("Kübra Kuaför Salonuna Hoşgeldiniz"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "E-posta veya Telefon Numarası",
                hintText: "Örn: 5xx... veya ornek@gmail.com",
                prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 15),

            TextField(
              obscureText: _girilenSifre,
              decoration: InputDecoration(
                labelText: "Şifre",

                suffixIcon: IconButton(
                  icon: Icon(
                    _girilenSifre ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _girilenSifre = !_girilenSifre;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 25),

            ElevatedButton(
              onPressed: () {
                String girilenDeger = "kubra@mail.com";
                if (girilenDeger.contains('@')) {
                  print("E-posta ile giriş yapılıyor:$girilenDeger");
                } else if (girilenDeger.length >= 10 &&
                    double.tryParse(girilenDeger) != null) {
                  print("Telefon ile giriş yapılıyor: +90$girilenDeger");
                } else {
                  print(
                    "Lütfen geçerli bir e-posta veya telefon numarası girin!",
                  );
                }
              },
              child: Text("Giriş Yap"),
            ),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Şifremi Unuttum",
                  style: TextStyle(color: Colors.blue, fontSize: 13),
                ),
              ),
            ),

            SizedBox(height: 10),

            TextButton(
              onPressed: () {},
              child: Text("Hesabınız yok mu? Üye Olun."),
            ),
          ],
        ),
      ),
    );
  }
}
