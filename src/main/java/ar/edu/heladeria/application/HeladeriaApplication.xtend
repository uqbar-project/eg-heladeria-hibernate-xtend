package ar.edu.heladeria.application

import ar.edu.heladeria.ui.ListaHeladeriasWindow
import org.uqbar.arena.Application

class HeladeriaApplication extends Application {

	new(HeladeriaBootstrap bootstrap) {
		super(bootstrap)
	}
	
	override protected createMainWindow() {
		new ListaHeladeriasWindow(this)
	}

	static def void main(String[] args) {
		new HeladeriaApplication(new HeladeriaBootstrap).start()
	}

}
