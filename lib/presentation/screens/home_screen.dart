import 'package:api_ap/data/models/jokes_model.dart';
import 'package:api_ap/presentation/widgets/custom_button.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String joke = '';
  final translator = GoogleTranslator();

  @override
  void initState() {
    randomJokes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Jokes',
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: const Color(0xff45FFCA),
      ),
      backgroundColor: Colors.black12,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text(
              joke,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color(0xff45FFCA)),
            )),
            const SizedBox(height: 20),
            CustomButton(
              onPressed: () => randomJokes(),
              btnTitle: 'Шутки про Чака',
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  btnTitle: 'Перевести на рус',
                  onPressed: () => translateJoke('ru'),
                ),
                CustomButton(
                  onPressed: () => translateJoke('ky'),
                  btnTitle: 'Перевести на кыр',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> randomJokes() async {
    final Dio dio = Dio();
    try {
      final Response response =
          await dio.get('https://api.chucknorris.io/jokes/random');

      final JokesModel model = JokesModel.fromJson(response.data);
      joke = model.value ?? '';
      setState(() {});
    } catch (e) {
      print('Ошибка: $e');
    }
  }

  Future<void> translateJoke(String language) async {
    try {
      var translation = await translator
          .translate(joke, from: 'en', to: language)
          .then((value) => value.text);

      setState(() {
        joke = translation;
      });
    } catch (e) {
      print('Ошибка: $e');
    }
  }
}
