import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'database_helper.dart';
import 'ana_kisim.dart';

class KayitOlScreen extends StatefulWidget {
  const KayitOlScreen({super.key});

  @override
  State<KayitOlScreen> createState() => _KayitOlScreenState();
}

class _KayitOlScreenState extends State<KayitOlScreen> {
  final kullaniciAdControl = TextEditingController();
  final telNoControl = TextEditingController();
  final emailControl = TextEditingController();
  final sifreControl = TextEditingController();
  bool _sifreGizli = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Yeni Kayıt")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Icon(
              Icons.person_add,
              size: 75,
              color: Color.fromARGB(255, 221, 147, 172),
            ),
            const SizedBox(height: 18),

            TextField(
              controller: kullaniciAdControl,
              decoration: const InputDecoration(
                labelText: "Ad Soyad",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 18),

            TextField(
              controller: telNoControl,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              decoration: const InputDecoration(
                labelText: "Telefon (5xxxxxxxxx)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 18),

            TextField(
              controller: emailControl,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "E-posta",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 18),

            TextField(
              controller: sifreControl,
              obscureText: _sifreGizli,
              decoration: InputDecoration(
                labelText: "Şifre",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _sifreGizli ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () => setState(() => _sifreGizli = !_sifreGizli),
                ),
              ),
            ),
            const SizedBox(height: 18),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () async {
                if (kullaniciAdControl.text.isEmpty ||
                    sifreControl.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Lütfen boş alan bırakmayın!"),
                    ),
                  );
                  return;
                }

                var db = DatabaseHelper();
                Map<String, dynamic> yeniKullanici = {
                  'kullaniciAdi': kullaniciAdControl.text,
                  'telefonNo': telNoControl.text,
                  'ePosta': emailControl.text,
                  'sifre': sifreControl.text,
                  'rol': 'müşteri',
                };

                int sonuc = await db.kullaniciyiKaydet(yeniKullanici);

                if (sonuc > 0) {
                  await db.logKaydet("Yeni Kayıt Yapıldı", emailControl.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Kayıt Başarılı! Giriş yapabilirsiniz."),
                    ),
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const AnaKisim(kullaniciRolu: 'müşteri'),
                    ),
                  );
                }
              },
              child: const Text("Kaydı Tamamla"),
            ),
          ],
        ),
      ),
    );
  }
}
