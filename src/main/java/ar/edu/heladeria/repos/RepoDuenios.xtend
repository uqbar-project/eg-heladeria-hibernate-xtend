package ar.edu.heladeria.repos

import ar.edu.heladeria.domain.Duenio
import org.hibernate.Criteria
import org.hibernate.criterion.Restrictions

class RepoDuenios extends AbstractRepoSQL<Duenio> {
	
	static RepoDuenios instance
	
	static def getInstance() {
		if (instance == null) {
			instance = new RepoDuenios()
		}
		return instance
	}
	
	override getEntityType() {
		typeof(Duenio)
	}
	
	override addCriteriaByExample(Duenio duenio, Criteria criteria) {
		if (duenio.nombreCompleto != null) {
			criteria.add(Restrictions.ilike("nombre", "%" + duenio.nombreCompleto + "%"))
		}
	}
	
}