# Exemplo de decodificador: display de 7 segmentos

Muitos eletrodomésticos exibem números para serem lidos por nós, humanos.
Exemplos desses eletrodomésticos incluem relógios, fornos micro-ondas, geladeiras etc.
Um dispositivo muito popular e simples, capaz de exibir um número de um único dígito é o
display de sete segmentos, como mostrado na figura.

//colocar imagem


Um display de sete segmentos funciona da seguinte forma:
● Quando deseja-se mostrar o número 1, apaga-se os pinos: 0, 3, 4, 5 e 6, deixando
ligados apenas os pinos 1 e 2;
● Quando deseja-se mostrar o número 2, apaga-se os pinos: 2 e 5, deixando os
restantes ligados.
● Por convenção, para os pinos de saída 0 a 6, adota-se nível lógico ‘1’ para indicar
que o pino está apagado e nível lógico ‘0’ para indicar que o pino está aceso.
Pode-se projetar um decodificador BCD (Binary-coded decimal) que é responsável
por receber comandos externos (representação binária) e mostrar o número em decimal no
display de sete segmentos.