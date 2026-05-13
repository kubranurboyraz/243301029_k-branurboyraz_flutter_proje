import 'package:flutter/material.dart';
import 'database_helper.dart';

class AyarlarEkran extends StatelessWidget {
  final String kullaniciTelNo;

  const AyarlarEkran({super.key, required this.kullaniciTelNo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ayarlar"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              "Hesap Ayarları",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.lock_outline, color: Colors.pink),
            title: const Text("Şifremi Değiştir"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => sifreDegistir(context),
          ),
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: const Text(
              "Hesabımı Sil",
              style: TextStyle(color: Colors.red),
            ),
            onTap: () => hesapSilOnay(context),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              "Uygulama Bilgileri",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.verified_user_outlined, color: Colors.blue),
            title: Text("Uygulama Sürümü"),
            trailing: Text("1.1.2"),
          ),
        ],
      ),
    );
  }

  void sifreDegistir(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Yeni Şifre Belirle"),
        content: TextField(
          controller: controller,
          obscureText: true,
          decoration: const InputDecoration(hintText: "Yeni şifrenizi giriniz"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Vazgeç"),
          ),
          ElevatedButton(
            onPressed: () async {
              if (controller.text.isNotEmpty) {
                await DatabaseHelper().sifreUnutGuncelle(
                  kullaniciTelNo,
                  controller.text,
                );
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Şifreniz güncellendi.")),
                  );
                }
              }
            },
            child: const Text("Güncelle"),
          ),
        ],
      ),
    );
  }

  void hesapSilOnay(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Hesap Silme"),
        content: const Text(
          "Hesabınızı silmek istediğinize emin misiniz? Tüm randevu geçmişiniz silinecektir.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Hayır"),
          ),
          TextButton(
            onPressed: () async {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Hesap silme talebi alındı.")),
              );
              Navigator.pop(context);
            },
            child: const Text("Evet, Sil", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
