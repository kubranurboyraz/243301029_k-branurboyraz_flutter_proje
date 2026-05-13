import 'package:flutter/material.dart';
import 'database_helper.dart';

class SifremiUnuttumEkran extends StatefulWidget {
  const SifremiUnuttumEkran({super.key});

  @override
  State<SifremiUnuttumEkran> createState() => _SifremiUnuttumEkranState();
}

class _SifremiUnuttumEkranState extends State<SifremiUnuttumEkran> {
  final _telController = TextEditingController();
  final _yeniSifreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Şifremi Unuttum")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text("Kayıtlı telefon numaranızı ve yeni şifrenizi giriniz."),
            const SizedBox(height: 18),
            TextField(
              controller: _telController,
              decoration: const InputDecoration(
                labelText: "Telefon Numarası",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _yeniSifreController,
              decoration: const InputDecoration(
                labelText: "Yeni Şifre",
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                var db = DatabaseHelper();

                var kullanici = await db.kullanicibulGetir(_telController.text);

                if (kullanici != null) {
                  await db.sifreUnutGuncelle(
                    _telController.text,
                    _yeniSifreController.text,
                  );
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Şifreniz başarıyla güncellendi!"),
                      ),
                    );
                    Navigator.pop(context);
                  }
                } else {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Bu numara sistemde kayıtlı değil!"),
                      ),
                    );
                  }
                }
              },
              child: const Text("Şifreyi Güncelle"),
            ),
          ],
        ),
      ),
    );
  }
}
