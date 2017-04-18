package ar.edu.heladeria.ui

import ar.edu.heladeria.appModel.EditarHeladeria
import ar.edu.heladeria.appModel.ListaHeladerias
import ar.edu.heladeria.domain.Heladeria
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class ListaHeladeriasWindow extends SimpleWindow<ListaHeladerias> {
	
	new(WindowOwner parent) {
		super(parent, new ListaHeladerias)
	}
	
	override protected addActions(Panel actionsPanel) {
		new Button(actionsPanel) => [
			caption = "Editar heladeria"
			enabled <=> "puedeEditarHeladeria"
			onClick [ | 
				val heladeriaSeleccionada = this.modelObject.heladeriaSeleccionada
				new EditarHeladeriaDialog(this, new EditarHeladeria(heladeriaSeleccionada)) => [
					onAccept [ this.modelObject.buscar ]
					open
				]
			]
		]
	}
	
	override protected createFormPanel(Panel mainPanel) {
		title = "Lista de heladerias"
		
		new Label(mainPanel).text = "Buscar por nombre"
		new TextBox(mainPanel) => [
			value <=> "nombreHeladeria"
		]
		
		new Button(mainPanel) => [
			caption = "Buscar"
			onClick [ | this.modelObject.buscar	 ]
		]
		
		new Label(mainPanel).text = "Heladerias"
		val gridHeladerias = new Table(mainPanel, typeof(Heladeria)) => [
			items <=> "heladerias"
			value <=> "heladeriaSeleccionada"
		]
		
		// Columnas
		new Column<Heladeria>(gridHeladerias) => [
			title = "Nombre"
			bindContentsToProperty("nombre")
			fixedSize = 200
		]
		new Column<Heladeria>(gridHeladerias) => [
			title = "Dueño"
			bindContentsToProperty("duenio.nombreCompleto")
			fixedSize = 300
		]
	}
	
}
