package ar.edu.heladeria.appModel

import ar.edu.heladeria.domain.Heladeria
import ar.edu.heladeria.repos.RepoHeladeria
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Dependencies
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class ListaHeladerias {

	List<Heladeria> heladerias
	Heladeria heladeriaSeleccionada	
	String nombreHeladeria
	
	def void buscar() {
		heladerias = RepoHeladeria.instance.searchByExample(new Heladeria(nombreHeladeria))
	}
	
	@Dependencies("heladeriaSeleccionada")
	def boolean getPuedeEditarHeladeria() {
		heladeriaSeleccionada != null
	}
	
}
