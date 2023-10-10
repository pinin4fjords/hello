#!/usr/bin/env nextflow
nextflow.enable.dsl=2 

process sayHello {
  input: 
    val x
  output:
    stdout
  script:
    """
    echo '$x world!'
    """
}

process writeHello {
  input:
    val x
  output:
    path "*.txt", emit: file
  script:
    """
    echo -e "$x" > foo.txt
    """
}

workflow {
  ch_hello = Channel.of('Bonjour', 'Ciao', 'Hello', 'Hola')

  sayHello(ch_hello)
  writeHello(sayHello.out)

  emit:
    results = writeHello.out.file
}
