import 'package:flutter/material.dart';
import '../models/data_bocor.dart';
import '../services/firestore_service.dart';
import 'form_screen.dart';

class HomeScreen extends StatelessWidget {
  final FirestoreService _service = FirestoreService();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("IndoLeaks Market")),
      body: StreamBuilder<List<DataBocor>>(
        stream: _service.getData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          final dataList = snapshot.data!;
          return ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              final data = dataList[index];
              return ListTile(
                title: Text(data.judul),
                subtitle: Text("${data.kategori} - Rp${data.harga}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FormScreen(existingData: data),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _service.deleteData(data.id),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => FormScreen()),
        ),
      ),
    );
  }
}
