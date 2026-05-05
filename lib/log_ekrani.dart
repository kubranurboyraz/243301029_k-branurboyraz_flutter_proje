import 'package:flutter/material.dart';
import 'database_helper.dart';

class LogEkrani extends StatelessWidget {
  const LogEkrani({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sistem Logları")),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseHelper().loglariGetir(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Henüz hiç log kaydı yok."));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var log = snapshot.data![index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: const Icon(
                    Icons.history,
                    color: Color.fromARGB(255, 169, 209, 159),
                  ),
                  title: Text(log['islem'].toString()),
                  subtitle: Text("Kullanıcı: ${log['kullanici']}"),
                  trailing: Text(
                    log['tarih'].toString().substring(0, 16),
                    style: const TextStyle(fontSize: 10),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
