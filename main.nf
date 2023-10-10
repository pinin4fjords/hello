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
    echo -e "$val" > foo.txt
    """
}

workflow {
  Channel.of('Bonjour', 'Ciao', 'Hello', 'Hola') | sayHello | view

  emit:
    results = writeHello.out.file
}
