class Elemento {
  method esBueno() 
  method recibirAtaque(deUnaPlaga)

}

class Hogar inherits Elemento {
  var nivelDeMugre = 0
  var confortQueOfrece = 0
  override method esBueno(){
    return nivelDeMugre / 2 <= confortQueOfrece
  }
  override method recibirAtaque(deUnaPlaga){
    nivelDeMugre =nivelDeMugre + deUnaPlaga.nivelDeDaño()
  }
}

class Huerta inherits Elemento {
  var capacidadDeProduccion = 0
  var nivelFijo = 100

  override method esBueno(){
    return capacidadDeProduccion > nivelFijo
  }

  override method recibirAtaque(deUnaPlaga){
    if(not deUnaPlaga.transmiteEnfermedades()){
      capacidadDeProduccion =capacidadDeProduccion - deUnaPlaga.nivelDeDaño() * 0.10
    }else {
      capacidadDeProduccion =capacidadDeProduccion - deUnaPlaga.nivelDeDaño() * 0.10 - 10
    }
  }
}



class Mascota inherits Elemento {
  var nivelDeSalud = 0
  override method esBueno(){
    return nivelDeSalud > 250
  }
  override method recibirAtaque(deUnaPlaga){
    if(deUnaPlaga.transmiteEnfermedades()){
      nivelDeSalud = nivelDeSalud - deUnaPlaga.nivelDeDaño()
    }
  }
}

class Barrio {
  const elementos = []

  method esCopado() {
    return elementos.count({ elemento => elemento.esBueno() }) >
           elementos.count({ elemento => !elemento.esBueno() })
  }
}

class Plaga {
  var poblacion = 0
  method poblacion() = poblacion
  method transmiteEnfermedades(){
    return poblacion >= 10
  }
  method atacar(elemento){
    poblacion = poblacion + poblacion * 0.10
  }
}


class Cucarachas inherits Plaga {
  var peso = 8
  method nivelDeDaño() = self.poblacion() / 2
  override method transmiteEnfermedades(){
    return super() and peso >= 10
  }
  override method atacar(elemento){
      super()
     peso = peso + 2
  }
}

class Pulgas inherits Plaga {
  method nivelDeDaño() = self.poblacion() * 2
  
}

class Garrapatas inherits Pulgas {
 
  }

class Mosquitos inherits Plaga {
  method nivelDeDaño() = self.poblacion()
  override method transmiteEnfermedades(){
    return super() and self.poblacion() % 3 == 0
  }
}
