package ar.edu.heladeria.repos

import ar.edu.heladeria.domain.Heladeria
import org.hibernate.Criteria
import org.hibernate.FetchMode
import org.hibernate.criterion.Restrictions

class RepoHeladeria extends AbstractRepoSQL<Heladeria> {

	static RepoHeladeria instance
	
	static def getInstance() {
		if (instance == null) {
			instance = new RepoHeladeria()
		}
		return instance
	}
		
	override getEntityType() {
		typeof(Heladeria)
	}

	override addCriteriaByExample(Heladeria heladeria, Criteria criteria) {
		if (heladeria.nombre != null) {
			criteria.add(Restrictions.ilike("nombre", "%" + heladeria.nombre + "%"))
		}
	}
	
	def Heladeria get(Long id) {
		return session.createCriteria(typeof(Heladeria))
				.setFetchMode("gustos", FetchMode.JOIN)
				.add(Restrictions.idEq(id))
				.uniqueResult() as Heladeria
	}
	
	def Heladeria get(Heladeria heladeria) {
		session.evict(heladeria)
		return get(heladeria.id)
	}

}
