import 'package:flutter/material.dart';
import 'database_helper.dart';

class RandevularimEkran extends StatefulWidget {
  final String kullaniciTelNo;
  final String kullaniciRolu;

  const RandevularimEkran({
    super.key,
    required this.kullaniciTelNo,
    required this.kullaniciRolu,
  });

  @override
  State<RandevularimEkran> createState() => _RandevularimEkranState();
}

class _RandevularimEkranState extends State<RandevularimEkran> {
  Future<List<Map<String, dynamic>>> _verileriGetir() async {
    var db = DatabaseHelper();

    if (widget.kullaniciRolu == 'yönetici') {
      return await db.tumRandevulariGetir();
    } else {
      var kullanici = await db.kullanicibulGetir(widget.kullaniciTelNo);
      if (kullanici != null) {
        return await db.kullaniciRandevulariGetir(kullanici['id']);
      }
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    bool yoneticiMi = widget.kullaniciRolu == 'yönetici';

    return Scaffold(
      appBar: AppBar(
        title: Text(yoneticiMi ? "Tüm Randevular (Yönetici)" : "Randevularım"),
        backgroundColor: yoneticiMi ? Colors.blueGrey : Colors.pinkAccent,
        centerTitle: true,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _verileriGetir(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    yoneticiMi
                        ? "Sistemde henüz randevu yok."
                        : "Henüz bir randevunuz bulunmamaktadır.",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 203, 201, 201),
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var randevu = snapshot.data![index];
              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: yoneticiMi ? Colors.blueGrey.shade50 : Colors.white,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: yoneticiMi
                        ? Colors.blueGrey
                        : Colors.pinkAccent,
                    child: const Icon(
                      Icons.event_available,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    randevu['secilenHizmet'] ?? "Hizmet Belirsiz",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      "📅 ${randevu['tarih']} \n⏰ ${randevu['saat']}",
                      style: const TextStyle(height: 1.4),
                    ),
                  ),
                  isThreeLine: true,
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete_forever,
                      color: Colors.redAccent,
                    ),
                    onPressed: () => iptalOnayDialog(randevu),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void iptalOnayDialog(Map<String, dynamic> randevu) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Randevu İptali"),
        content: Text(
          "${randevu['secilenHizmet']} randevusunu iptal etmek istediğinize emin misiniz?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Vazgeç"),
          ),
          TextButton(
            onPressed: () async {
              await DatabaseHelper().randevuSil(randevu['id']);
              await DatabaseHelper().logKaydet(
                "${randevu['secilenHizmet']} randevusu ${widget.kullaniciRolu} tarafından iptal edildi",
                widget.kullaniciTelNo,
              );
              if (mounted) {
                Navigator.pop(context);
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Randevu başarıyla iptal edildi."),
                  ),
                );
              }
            },
            child: const Text("İptal Et", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
