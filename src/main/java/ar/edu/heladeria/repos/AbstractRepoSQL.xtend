package ar.edu.heladeria.repos

import ar.edu.heladeria.domain.Duenio
import ar.edu.heladeria.domain.Heladeria
import java.util.List
import org.hibernate.Criteria
import org.hibernate.HibernateException
import org.hibernate.Session
import org.hibernate.SessionFactory
import org.hibernate.cfg.Configuration

abstract class AbstractRepoSQL<T> {
	
	Session session = openSession
	
	private static final SessionFactory sessionFactory = new Configuration()
			.configure()
			.addAnnotatedClass(Heladeria)
			.addAnnotatedClass(Duenio)
			.buildSessionFactory()

	def getSession() {
		session
	}

	
	def List<T> allInstances() {
		session.createCriteria(entityType).list()
	}
	
	def Class<T> getEntityType()

	def List<T> searchByExample(T t) {
		val session = sessionFactory.openSession
		try {
			val criteria = session.createCriteria(entityType)
			addCriteriaByExample(t, criteria)
			return criteria.list()
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}
	
	def Criteria addCriteriaByExample(T t, Criteria criteria)

	def void createOrUpdate(T t) {
		try {
			session => [
				beginTransaction
				saveOrUpdate(t)
				flush
				transaction.commit
			]
		} catch (HibernateException e) {
			session.transaction.rollback
			throw new RuntimeException(e)
		}
	}

	def openSession() {
		sessionFactory.openSession
	}
	
	def closeSession() {
		session.close
	}

}
