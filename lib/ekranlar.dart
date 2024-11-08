
//************************
//ÖDEVİN 1. MADDESİ
//******************
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final TextEditingController firstController = TextEditingController();
  final TextEditingController secondController = TextEditingController();
  String result = "";

  void calculateSum() {
    final int? firstNumber = int.tryParse(firstController.text);
    final int? secondNumber = int.tryParse(secondController.text);

    if (firstNumber != null && secondNumber != null) {
      setState(() {
        result = (firstNumber + secondNumber).toString();
      });
    } else {
      setState(() {
        result = "Lütfen geçerli sayılar girin";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hesaplama"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: firstController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Birinci Sayı"),
            ),
            TextField(
              controller: secondController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "İkinci Sayı"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateSum,
              child: Text("Toplamı Sonucu"),
            ),
            SizedBox(height: 20),
            Text(
              "Sonuç: $result",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondPage()),
                );
              },
              child: Text("İkinci Sayfaya Git"),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  void showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Uyarı"),
          content: Text("Bu bir uyarıdır."),
          actions: [
            TextButton(
              child: Text("Kapat"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showPopup(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Bu bir popup'tır.")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("İkinci Sayfa"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => showAlert(context),
              child: Text("Uyarı Göster"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => showPopup(context),
              child: Text("Popup Göster"),
            ),
          ],
        ),
      ),
    );
  }
}
