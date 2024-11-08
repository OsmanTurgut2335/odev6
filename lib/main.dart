import 'package:flutter/material.dart';
import 'database_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personel Veritabanı',
      home: PersonelScreen(),
    );
  }
}

class PersonelScreen extends StatefulWidget {
  @override
  _PersonelScreenState createState() => _PersonelScreenState();
}

class _PersonelScreenState extends State<PersonelScreen> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> personelList = [];

  @override
  void initState() {
    super.initState();
    _refreshPersonelList();
  }

  Future<void> _refreshPersonelList() async {
    final data = await dbHelper.getPersonelList();
    setState(() {
      personelList = data;
    });
  }

  Future<void> _addPersonel() async {
    await dbHelper.insertPersonel({
      'ad': 'Sinan',
      'soyad': 'Başarslan',
      'departman': 'IT',
      'maas': 5000,
    });
    _refreshPersonelList();
  }

  Future<void> _updatePersonel(int id) async {
    await dbHelper.updatePersonel(id, {
      'ad': 'Mehmet',
      'soyad': 'Demir',
      'departman': 'Finance',
      'maas': 5800,
    });
    _refreshPersonelList();
  }

  Future<void> _deletePersonel(int id) async {
    await dbHelper.deletePersonel(id);
    _refreshPersonelList();
  }

  Future<void> _showAverageSalaryByDepartment() async {
    final data = await dbHelper.getAverageSalaryByDepartment();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Departmana Göre Ortalama Maaş'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: data.map((e) => Text('${e['departman']}: ${e['avg_maas']}')).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('Kapat'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personel Veritabanı'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addPersonel,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: personelList.length,
        itemBuilder: (ctx, index) {
          final personel = personelList[index];
          return ListTile(
            title: Text('${personel['ad']} ${personel['soyad']}'),
            subtitle: Text('${personel['departman']} - Maaş: ${personel['maas']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _updatePersonel(personel['id']),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deletePersonel(personel['id']),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.bar_chart),
        onPressed: _showAverageSalaryByDepartment,
      ),
    );
  }
}
