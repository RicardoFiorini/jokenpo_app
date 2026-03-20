# Jokenpô App
Um aplicativo divertido e interativo para jogar o clássico **Pedra, Papel e Tesoura** contra o seu próprio celular. O projeto foi construído utilizando *Flutter* para exercitar a lógica de interface dinâmica e estados simples.
## Funcionalidades

- Escolha do usuário através de botões de imagem.
- Geração aleatória da escolha do computador.
- Atualização imediata do resultado (Vitória, Derrota ou Empate).
- Interface visual com troca dinâmica de imagens de acordo com a partida.

## Desenvolvimento
- [x] Configuração do layout principal
- [x] Implementação da lógica de escolha aleatória
- [x] Tratamento de estados (setState) para o resultado
- [x] Organização dos assets de imagens
- [ ] Adição de contador de pontuação (Placar)
## Tecnologias Utilizadas
| Tecnologia | Uso |
| --- | --- |
| Flutter | Framework de UI multiplataforma |
| Dart | Lógica de decisão e sorteio aleatório |
> [!TIP]
> O projeto utiliza a classe `Random()` do Dart para garantir que a escolha do computador seja imprevisível a cada rodada.
## Como rodar o projeto
Clone o repositório e execute os comandos abaixo com o emulador aberto:
`flutter pub get`
```bash

Para iniciar o aplicativo
flutter run

```
