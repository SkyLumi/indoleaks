import 'package:flutter/material.dart';
import '../models/data_bocor.dart';
import '../services/firestore_service.dart';

class FormScreen extends StatefulWidget {
  final DataBocor? existingData;

  const FormScreen({super.key, this.existingData});

  @override
  FormScreenState createState() => FormScreenState();
}

class FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String judul, kategori, ukuran, sumber, status, keterangan;
  late int harga;

  @override
  void initState() {
    super.initState();
    final d = widget.existingData;
    judul = d?.judul ?? '';
    kategori = d?.kategori ?? '';
    ukuran = d?.ukuran ?? '';
    sumber = d?.sumber ?? '';
    status = d?.status ?? '';
    keterangan = d?.keterangan ?? '';
    harga = d?.harga ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existingData != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? "Edit Data" : "Tambah Data")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildField("Judul", (v) => judul = v),
              buildField("Kategori", (v) => kategori = v),
              buildField("Ukuran", (v) => ukuran = v),
              buildField("Sumber", (v) => sumber = v),
              buildField("Status", (v) => status = v),
              buildField("Harga (Angka)", (v) => harga = int.parse(v)),
              buildField("Keterangan", (v) => keterangan = v),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text(isEditing ? "Update" : "Simpan"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final data = DataBocor(
                      id: widget.existingData?.id ?? '',
                      judul: judul,
                      kategori: kategori,
                      ukuran: ukuran,
                      sumber: sumber,
                      status: status,
                      harga: harga,
                      keterangan: keterangan,
                    );
                    if (isEditing) {
                      FirestoreService().updateData(data);
                    } else {
                      FirestoreService().addData(data);
                    }
                    Navigator.pop(context);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildField(String label, Function(String) onSaved) {
    return TextFormField(
      initialValue: label == "Harga (Angka)" && harga != 0 ? "$harga" : null,
      decoration: InputDecoration(labelText: label),
      validator: (value) => value == null || value.isEmpty ? 'Wajib diisi' : null,
      onChanged: onSaved,
    );
  }
}
