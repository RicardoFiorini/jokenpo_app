import 'package:flutter/material.dart';
import 'dart:math'; // Precisamos disso para a escolha aleatória do CPU

//
// CORREÇÃO: O enum foi movido para cá (nível superior)
//
enum Opcao { pedra, papel, tesoura }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jokenpô',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: const GamePage(),
    );
  }
}

// Usamos um StatefulWidget pois a tela mudará (escolhas, placar)
class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  //
  // O enum foi REMOVIDO daqui de dentro.
  //

  // Caminhos das imagens
  String _imagemPadrao = 'assets/images/padrao.png';
  String _imagemCpu = 'assets/images/padrao.png';

  // Variáveis de estado
  String _mensagemResultado = 'Escolha uma opção abaixo';
  int _placarUsuario = 0;
  int _placarCpu = 0;

  // Função para processar a jogada do usuário
  // Agora o tipo 'Opcao' será reconhecido
  void _jogar(Opcao escolhaUsuario) {
    // 1. Gerar a escolha do CPU
    Opcao escolhaCpu = _gerarEscolhaCpu();

    // Atualiza a imagem da CPU na tela
    setState(() {
      // Usamos .name para converter o enum (ex: Opcao.pedra) para a string "pedra"
      _imagemCpu = 'assets/images/${escolhaCpu.name}.png';
    });

    // 2. Determinar o vencedor
    _determinarVencedor(escolhaUsuario, escolhaCpu);
  }

  // Gera uma escolha aleatória para o CPU
  Opcao _gerarEscolhaCpu() {
    int indiceAleatorio = Random().nextInt(Opcao.values.length); // Gera 0, 1 ou 2
    return Opcao.values[indiceAleatorio];
  }

  // Lógica principal do jogo
  void _determinarVencedor(Opcao usuario, Opcao cpu) {
    String mensagem = '';
    bool usuarioVenceu = false;
    bool empate = false;

    // Lógica do Jokenpô
    if (usuario == cpu) {
      empate = true;
      mensagem = 'Empatou!';
    } else if ((usuario == Opcao.pedra && cpu == Opcao.tesoura) ||
        (usuario == Opcao.papel && cpu == Opcao.pedra) ||
        (usuario == Opcao.tesoura && cpu == Opcao.papel)) {
      usuarioVenceu = true;
      mensagem = 'Você Venceu! :)';
    } else {
      usuarioVenceu = false;
      mensagem = 'Você Perdeu! :(';
    }

    // 3. Atualizar o estado (setState) para redesenhar a tela
    setState(() {
      _mensagemResultado = mensagem;
      if (empate == false) {
        if (usuarioVenceu) {
          _placarUsuario++;
        } else {
          _placarCpu++;
        }
      }
    });
  }

  // Reseta o jogo
  void _resetar() {
    setState(() {
      _imagemCpu = _imagemPadrao;
      _mensagemResultado = 'Escolha uma opção abaixo';
      _placarUsuario = 0;
      _placarCpu = 0;
    });
  }

  // Constrói a interface
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jokenpô'),
        actions: [
          // Botão de Reset
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetar,
            tooltip: 'Resetar Placar',
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Placar
              Text(
                'Placar',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                'Você: $_placarUsuario  vs  CPU: $_placarCpu',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 30),

              // Escolha do App (CPU)
              const Text(
                'Escolha do CPU:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Image.asset(
                _imagemCpu,
                height: 120,
              ),
              const SizedBox(height: 10),

              // Mensagem de Resultado
              Text(
                _mensagemResultado,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Opções do Usuário (em uma linha)
              const Text(
                'Sua escolha:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // Usamos GestureDetector para tornar a imagem clicável
                  GestureDetector(
                    onTap: () => _jogar(Opcao.pedra),
                    child: Image.asset('assets/images/pedra.png', height: 80),
                  ),
                  GestureDetector(
                    onTap: () => _jogar(Opcao.papel),
                    child: Image.asset('assets/images/papel.png', height: 80),
                  ),
                  GestureDetector(
                    onTap: () => _jogar(Opcao.tesoura),
                    child: Image.asset('assets/images/tesoura.png', height: 80),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}