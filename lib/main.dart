import 'package:flutter/material.dart';
import 'package:flutter_kuafor/database_helper.dart';
import 'ana_kisim.dart';
import 'kayit_ol.dart';

void main() {
  runApp(const KuaforrApp());
}

class KuaforrApp extends StatelessWidget {
  const KuaforrApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 184, 95, 125),
        brightness: Brightness.light,
      ),

      home: const LoginScreen(),
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
  final TextEditingController girisBilgiControl = TextEditingController();
  final TextEditingController sifreControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 229, 123, 158),
        title: const Text("Kübra Kuaför Salonuna Hoşgeldiniz"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 25),
              const Icon(
                Icons.face_retouching_natural,
                size: 80,
                color: Colors.pink,
              ),
              const SizedBox(height: 25),
              TextField(
                controller: girisBilgiControl,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "E-posta veya Telefon Numarası",
                  hintText: "Örn: 5xx... veya ornek@gmail.com",
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: sifreControl,
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
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () async {
                  String girilenDeger = girisBilgiControl.text;
                  String sifre = sifreControl.text;
                  debugPrint(
                    "Giriş denemesi -> Yazilan: $girilenDeger, Şifre: $sifre",
                  );
                  var db = DatabaseHelper();
                  var kullanicilar = await db.verileriGetir('kullanicilar');

                  bool buldunMu = false;
                  String? kullaniciRolu;

                  for (var x in kullanicilar) {
                    if ((x['ePosta'] == girilenDeger ||
                            x['telefonNo'] == girilenDeger) &&
                        x['sifre'] == sifre) {
                      buldunMu = true;
                      kullaniciRolu = x['rol'];
                      break;
                    }
                  }
                  if (buldunMu) {
                    var db = DatabaseHelper();
                    await db.logKaydet("başarılı giriş", girilenDeger);
                    debugPrint("[LOG] Giriş başarılı Rol: $kullaniciRolu");
                    if (!mounted) return;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AnaKisim(kullaniciRolu: kullaniciRolu ?? 'müşteri'),
                      ),
                    );
                  } else {
                    debugPrint("[LOG] kullanıcı yok veya şifre hatalı!");
                  }
                },
                child: const Text("Giriş Yap"),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Şifremi Unuttum",
                    style: TextStyle(color: Colors.blue, fontSize: 13),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const KayitOlScreen(),
                    ),
                  );
                },
                child: const Text("Hesabınız yok mu? Üye Olun."),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
