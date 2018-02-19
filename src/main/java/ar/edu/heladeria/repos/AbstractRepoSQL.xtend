package ar.edu.heladeria.repos

import java.util.List
import javax.persistence.EntityManagerFactory
import javax.persistence.Persistence
import javax.persistence.PersistenceException
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root

abstract class AbstractRepoSQL<T> {

	private static final EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("Heladeria")

	def getEntityManager() {
		entityManagerFactory.createEntityManager
	}

	def List<T> allInstances() {
		val criteria = entityManager.criteriaBuilder
		try {
			val query = criteria.createQuery as CriteriaQuery<T>
			val from = query.from(entityType)
			query.select(from)
			entityManager.createQuery(query).resultList
		} finally {
			entityManager.close
		}
	}

	def Class<T> getEntityType()

	def List<T> searchByExample(T t) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery as CriteriaQuery<T>
			val from = query.from(entityType)
			query.select(from)
			generateWhere(criteria, query, from, t)
			entityManager.createQuery(query).resultList
		} finally {
			entityManager.close
		}
	}

	abstract def void generateWhere(CriteriaBuilder criteria, CriteriaQuery<T> query, Root<T> camposCandidato,T t)

	def void createOrUpdate(T t) {
		val entityManager = this.entityManager
		try {
			entityManager => [
				transaction.begin
				merge(t)
				transaction.commit
			]
		} catch (PersistenceException e) {
			e.printStackTrace
			entityManager.transaction.rollback
			throw new RuntimeException("Ha ocurrido un error. La operación no puede completarse.", e)
		} finally {
			entityManager.close
		}
	}

}
