//memasukkan package yang dibutuhkan oleh aplikasi
import 'package:english_words/english_words.dart'; //paket bahasa inggris
import 'package:flutter/material.dart'; //paket untuk tampilan UI (material UI)
import 'package:provider/provider.dart'; //paket untuk interaksi aplikasi

//fungsi main (fungsi utama)
void main() {
  runApp(
      MyApp()); //memanggil fungsi runApp (yg menjalankan keseluruhan aplikasi di dalam MyApp())
  //Karena MyApp adalah fungsi aplikasi mobile, maka haru dipanggil dari fungsi runApp()
}

//membuat abstrak aplikasi dari statelessWidget (template aplikasi), aplikasinya bernama MyApp
class MyApp extends StatelessWidget {
  const MyApp(
      {super.key}); //menunjukkan bahwa aplikasi ini akan tetap, tidak berubah setelah di-build

  @override //mengganti nilai lama yg sudah ada di template, dengan nilai-nilai yg baru (replace / overwrite)
  Widget build(BuildContext context) {
    //fungsi build adalah fungsi yg membangun UI (mengatur posisi widget, dst)
    //ChangeNotifierProvider mendengarkan/mendeteksi semua interaksi yang terjadi di aplikasi
    return ChangeNotifierProvider(
      create: (context) => MyAppState(), //membuat satu state bernama MyAppState
      child: MaterialApp(
        //pada state ini, menggunakan style desain MaterialUI
        title: 'Namer App', //diberi judul Namer App
        theme: ThemeData(
          //data tema aplikasi, diberi warna deepOrange
          useMaterial3: true, //versi materialUI yang dipakai versi 3
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        ),
        home:
            MyHomePage(), //nama halaman "MyHomePage" yang menggunakan state "MyAppState".
      ),
    );
  }
}

//mendefinisikan isi MyAppState
class MyAppState extends ChangeNotifier {
  //state MyAppState diisi dengan 2 kata random yang digabung. Kata random tsb disimpan di variable WordPair
  var current = WordPair.random();

  //membuat fungsi getNext untuk mengacak kata
  void getNext() {
    current = WordPair.random(); //acak kata
    notifyListeners(); //kirim kata yg diacak ke listener untuk ditampilkan di layar
  }
}

//membuat layout pada halaman HomePage
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState =
        context.watch<MyAppState>(); //widget menggunakan state MyAppState
    //di bawah ini adalah kode program untuk menyusun layout
    var pair = appState
        .current; //variabel pair menyimpan kata yang sedang tampil/aktif, yang diambil dari appState.current

    return Scaffold(
      //base (canvas) dari layout
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //di atas scaffold, ada body. Body-nya, diberi kolom
          children: [
            //di dalam kolom, diberi teks
            // Text('A random idea:'),
            BigCard(
                pair:
                    pair), //mengambil nilai dari variabel pair, lalu diubah menjadi huruf kecil semua, dan ditampilkan sebagai BigCard / kartu besar
            ElevatedButton(
              //membuat button timbul di dalam body
              onPressed: () {
                //fungsi getNext() dieksekusi ketika button ditekan
                appState.getNext();
              },
              child:
                  Text('Next'), //berikan teks 'Next' pada button (sebagai child)
            ),
          ],
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  //widget BigCard
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); //menambahkan tema pada card
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      //membungkus padding di dalam widget Card
      color: theme.colorScheme.primary, //menambahkan warna pada card
      child: Padding(
        padding:
            const EdgeInsets.all(20), //memberi jarak/padding di sekitar teks
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ), //membuat kata menjadi huruf kecil
      ),
    );
  }
}
