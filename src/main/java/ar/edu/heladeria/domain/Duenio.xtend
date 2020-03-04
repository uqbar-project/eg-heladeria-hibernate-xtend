package ar.edu.heladeria.domain

import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
@Entity
class Duenio {
	
	@Id
	@GeneratedValue
	Long id

	@Column(length=150)
	String nombreCompleto
	
	new() {	}
	
	override toString() {
		nombreCompleto
	}

	override hashCode() {
		if (id === null) return super.hashCode
		id.hashCode
	}
	
	override equals(Object obj) {
		try {
			val otro = obj as Duenio
			return otro.id !== null && id !== null && otro.id == id
		} catch (ClassCastException e) {
			return false
		}
	}
	
}
