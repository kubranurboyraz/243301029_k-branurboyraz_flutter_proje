import 'package:flutter/material.dart';
import 'package:flutter_kuafor/sifreUnutEkran.dart';
import 'ana_kisim.dart';
import 'kayit_ol.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'database_helper.dart';

String? sonGirenRol;
String? sonGirenTel;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const KuaforrApp());
}

class KuaforrApp extends StatelessWidget {
  const KuaforrApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 205, 96, 132),
        brightness: Brightness.light,
      ),
      home: const AuthWrapper(),
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
                  hintText: "Örn: 05xx... veya ornek@gmail.com",
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
                  String girilenDeger = girisBilgiControl.text.trim();
                  String sifre = sifreControl.text.trim();

                  if (girilenDeger.isEmpty || sifre.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Lütfen tüm alanları doldurun!"),
                      ),
                    );
                    return;
                  }

                  try {
                    var db = DatabaseHelper();

                    var kullaniciVerisi = await db.kullaniciGirisBilgisiGetir(
                      girilenDeger,
                    );

                    if (kullaniciVerisi == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Kullanıcı bulunamadı!")),
                      );
                      return;
                    }

                    if (kullaniciVerisi['sifre'] != sifre) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Şifre yanlış!")),
                      );
                      return;
                    }

                    String rol = kullaniciVerisi['rol'] ?? 'müşteri';
                    String telNo =
                        kullaniciVerisi['telefonNo'] ?? 'Telefon Yok';

                    String gercekEmail = kullaniciVerisi['ePosta'] ?? '';

                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: gercekEmail,
                        password: sifre,
                      );
                    } catch (firebaseHata) {
                      print("Firebase giriş hatası: $firebaseHata");
                    }

                    await db.logKaydet("başarılı giriş", girilenDeger);

                    sonGirenRol = rol;
                    sonGirenTel = telNo;

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AnaKisim(kullaniciRolu: rol, kullaniciTelNo: telNo),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Hata oluştu: $e")));
                  }
                },
                child: const Text("Giriş Yap"),
              ),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SifremiUnuttumEkran(),
                      ),
                    );
                  },
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

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator(color: Colors.pink)),
          );
        }
        if (snapshot.hasData && snapshot.data != null) {
          final firebaseUser = snapshot.data!;

          return FutureBuilder<Map<String, dynamic>?>(
            future: DatabaseHelper().kullaniciGirisBilgisiGetir(
              firebaseUser.email,
            ),

            builder: (context, dbSnapshot) {
              if (dbSnapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(color: Colors.pink),
                  ),
                );
              }
              final kullanici = dbSnapshot.data;

              if (kullanici == null) {
                FirebaseAuth.instance.signOut();

                return const LoginScreen();
              }

              String rol = kullanici['rol'] ?? 'müşteri';

              String telNo = kullanici['telefonNo'] ?? '';

              return AnaKisim(kullaniciRolu: rol, kullaniciTelNo: telNo);
            },
          );
        }

        return const LoginScreen();
      },
    );
  }
}
