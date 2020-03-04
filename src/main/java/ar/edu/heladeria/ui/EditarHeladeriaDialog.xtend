package ar.edu.heladeria.ui

import ar.edu.heladeria.appModel.EditarHeladeria
import java.awt.Color
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.NumericField
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.RadioSelector

class EditarHeladeriaDialog extends Dialog<EditarHeladeria> {
	
	new(WindowOwner owner, EditarHeladeria model) {
		super(owner, model)
	}
	
	override protected createFormPanel(Panel mainPanel) {
		title = "Editar Heladeria"
		
		val firstPanel = new Panel(mainPanel)
		firstPanel.layout = new HorizontalLayout
		
		val panelIzquierdo = new Panel(firstPanel)
		new Label(panelIzquierdo) => [
			text = "Nombre"
		]
		new TextBox(panelIzquierdo) => [
			value <=> "heladeria.nombre"
			width = 150
		]
		
		new RadioSelector(panelIzquierdo) => [
			items <=> "tiposHeladeria"
			value <=> "heladeria.tipoHeladeria"
		]
		
		val panelDerecho = new Panel(firstPanel)

		new Label(panelDerecho) => [
			text = "Dueño"
			foreground = Color.DARK_GRAY
		]

		new Selector(panelDerecho) => [
			items <=> "duenios"
			value <=> "heladeria.duenio"
		]

		val panelDuenio = new Panel(panelDerecho)
		panelDuenio.layout = new HorizontalLayout
		new TextBox(panelDuenio) => [
			value <=> "duenioNuevo"
			width = 200
		]
		new Button(panelDuenio) => [
			caption = "Agregar dueño"
			onClick [ | this.modelObject.agregarDuenio ]
			enabled <=> "puedeAgregarDuenio"
		]

		val panelAgregarGustos = new Panel(mainPanel)
		panelAgregarGustos.layout = new HorizontalLayout
		
		val panelGustosIzquierdo = new Panel(panelAgregarGustos)
		new Label(panelGustosIzquierdo) => [
			text = "Gusto"
		]
		new TextBox(panelGustosIzquierdo) => [
			value <=> "gustoNuevo"
			width = 200
		]
		new Label(panelGustosIzquierdo) => [
			text = "Dificultad (1 al 10)"
		]
		new NumericField(panelGustosIzquierdo) => [
			value <=> "dificultad"
			width = 30
		]
		new Button(panelGustosIzquierdo) => [
			caption = "Agregar gusto"
			onClick [ | this.modelObject.agregarGusto ]
			enabled <=> "puedeAgregarGusto"
		]
		
		val panelGustosDerecho = new Panel(panelAgregarGustos)
		new List(panelGustosDerecho) => [
			items <=> "heladeria.gustosQueOfrece"
			value <=> "gustoSeleccionado"
			width = 300
		]
		new Button(panelGustosDerecho) => [
			caption = "Eliminar gusto"
			enabled <=> "puedeEliminarGusto"
			onClick [ | 
				this.modelObject.eliminarGusto 
			]
		]
		
		new Button(mainPanel) => [
			caption = "Actualizar Heladería"
			onClick [ | 
				this.modelObject.actualizar
				this.accept 
			]
		]
		
	}
	
}
