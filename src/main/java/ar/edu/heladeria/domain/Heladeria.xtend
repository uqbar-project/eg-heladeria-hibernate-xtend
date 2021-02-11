package ar.edu.heladeria.domain

import java.util.Map
import javax.persistence.CascadeType
import javax.persistence.CollectionTable
import javax.persistence.Column
import javax.persistence.ElementCollection
import javax.persistence.Entity
import javax.persistence.EnumType
import javax.persistence.Enumerated
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.JoinColumn
import javax.persistence.ManyToOne
import javax.persistence.MapKeyColumn
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.exceptions.UserException
import org.uqbar.commons.model.utils.ObservableUtils

@Observable
@Accessors
@Entity
class Heladeria {

	@Id
	@GeneratedValue
	Long id

	@Column(length=150)
	String nombre

	@Enumerated(EnumType.ORDINAL) // o EnumType.STRING
	TipoHeladeria tipoHeladeria

	@ManyToOne(fetch=FetchType.EAGER, cascade=CascadeType.ALL)
	Duenio duenio

	@ElementCollection
	@CollectionTable(
		name="Heladeria_Gustos", 
		joinColumns=@JoinColumn(name="heladeria_id")
	)
	@Column(name="dificultad")
	@MapKeyColumn(name="gusto")
	Map<String, Integer> gustos
		// el mapa se compone de gusto, dificultad

	new() {
		gustos = newHashMap
	}
	
	def void validar() {
		if (nombre === null || nombre.trim.empty) {
			throw new UserException("Debe cargar el nombre")
		}
		if (duenio === null) {
			throw new UserException("Debe elegir el dueño")
		}
		if (gustos.isEmpty) {
			throw new UserException("Debe seleccionar al menos un gusto")
		}
	}

	override toString() {
		nombre
	}

	def agregarGusto(String gusto, int dificultad) {
		gustos.put(gusto, dificultad)
		ObservableUtils.firePropertyChanged(this, "gustos", gustos)
		ObservableUtils.firePropertyChanged(this, "gustosQueOfrece", gustosQueOfrece)
	}

	@Dependencies("gustos")	
	def gustosQueOfrece() {
		gustos.keySet.map [ gusto | gusto + " -> " + gustos.get(gusto) ].toList
	}
	
	def eliminarGusto(String gusto) {
		gustos.remove(gusto)
		ObservableUtils.firePropertyChanged(this, "gustos", gustos)
		ObservableUtils.firePropertyChanged(this, "gustosQueOfrece", gustosQueOfrece)
	}

}

enum TipoHeladeria {
	ECONOMICA,
	ARTESANAL,
	INDUSTRIAL
}
