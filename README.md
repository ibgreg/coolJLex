# coolJLex - Analisador léxico da linguagem COOL
Atividade Compiladores 3 (UNIFACS) - Elaborar o analisador léxico no flex ou jlex
<br/>
<br/>
<strong>Componentes do grupo:</strong>
<br/>
 Caio Vinícius (@CaioVinicius)
<br/>
 Danilo Augusto (@AugsutoDC)
<br/>
 Danilo Quadros (@daniloba)
<br/>
 Ítalo Gregório (@ibgreg)
<br/>
<br/>
<strong> Requisitos para compilação e execução: </strong>
<br/>
<ul>
  <li><a href="https://www.virtualbox.org/wiki/Downloads">Oracle VM VirtualBox</a></li>
  <li><a href="https://s3-us-west-1.amazonaws.com/prod-edx/Compilers/VM/compilers-vm.zip">Ambiente Linux fornecido pelo Stanford Online Lagunita</a></li>
</ul>
<br/>
<p>Após instalar o VirtualBox, extraia o <strong>compilers-vm.zip</strong> e execute o arquivo <strong>Compilers.vbox</strong> para executar a máquina virtual</p>
<br/>
Crie uma pasta para o projeto, abra o terminal dentro do diretório criado e execute o comando para importar os arquivos necessários para execução e compilação:
<br/>
<code>make -f /usr/class/cs143/assignments/PA2J/Makefile</code>
<br/>
<br/>
<strong>Comando para compilação do analisador léxico (arquivo cool.lex): </strong>
<br/>
<code>make lexer</code>
<br/>
<br/>
<strong>Comando para testar o analisador compilado com o arquivo "test.cl": </strong>
<br/>
<code>make dotest</code>
