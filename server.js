/**
 * Created by hernandez on 05/05/2016.
 */
(function () {
	var express = require('express');
	var bodyParser = require('body-parser');
	var mysql = require('mysql');
	var morgan = require('morgan');
	var Sequelize = require('sequelize');

	var sequelize = new Sequelize('db_Turismo_2014008','root', '',{
		host: 'localhost',
		dialect: 'mysql',
		port: 3000,
		pool: {
			max: 20,
			min: 0
		}
	});

	/*
	 Declaraciones de los modelos
	 */
	var Rol = sequelize.define('rol', {
		id_rol: { type: Sequelize.INTEGER, primaryKey: true, autoIncrement: true},
		rol: { type: Sequelize.STRING, allowNull: false}
	});

	var Usuario = sequelize.define('usuario', {
		id_usuario: {type: Sequelize.INTEGER, primaryKey: true, autoIncrement: true},
		nombre: {type: Sequelize.STRING, allowNull: false},
		correo: {type: Sequelize.STRING, allowNull: false},
		contrasena: {type: Sequelize.STRING, allowNull: false},
		id_rol: {type: Sequelize.INTEGER, references: {
			model: Rol,
			key: 'id_rol'
		}}
	});

	var TipoHotel = sequelize.define('tipohotel', {
		id_tipohotel: {type: Sequelize.INTEGER, primaryKey: true, autoIncrement: true},
		tipohotel: {type: Sequelize.STRING, allowNull: false}
	});

	var Hotel = sequelize.define('hotel', {
		id_hotel: {type: Sequelize.INTEGER, primaryKey: true, autoIncrement: true},
		nombre: {type: Sequelize.STRING, allowNull: false},
		direccion: {type: Sequelize.STRING, allowNull: false},
		id_tipohotel: {type: Sequelize.INTEGER, references: {
			model: TipoHotel,
			key: 'id_tipohotel'
		}}
	});

	var Restaurante = sequelize.define('restaurante', {
		id_restaurante: {type: Sequelize.INTEGER, primaryKey: true, autoIncremente: true},
		nombre: {type: Sequelize.STRING, allowNull: false},
		direccion: {type: Sequelize.STRING, allowNull: false},
	});

	var Mapa = sequelize.define('mapa', {
		id_mapa: {type: Sequelize.INTEGER, primaryKey: true, autoIncrement: true},
		ubicacion: {type: Sequelize.STRING, allowNull: false}
	});

	var Bitacora = sequelize.define('bitacora', {
		id_bitacora: {type: Sequelize.INTEGER, primaryKey: true, autoIncrement: true},
		descripcion: {type: Sequelize.STRING, allowNull:false}
	});

	var Alerta = sequelize.define('alerta', {
		id_alerta: {type: Sequelize.INTEGER, primaryKey:true, autoIncrement:true},
		descripcion: {type: Sequelize.STRING, allowNull:false},
		id_bitacora: {type: Sequelize.INTEGER, references: {
			model: Bitacora,
			key: 'id_bitacora'
		}}
	});

	var SitioTuristico = sequelize.define('sitioturistico', {
		id_sitioturistico: {type: Sequelize.INTEGER, primaryKey:true, autoIncrement:true},
		nombre: {type: Sequelize.STRING, allowNull:false},
		descripcion: {type: Sequelize.STRING, allowNull:false},
		id_mapa: {type: Sequelize.INTEGER, references: {
			model: Mapa,
			key: 'id_mapa'
		}},
		id_hotel: {type: Sequelize.INTEGER, references: {
			model: Hotel,
			key: 'id_hotel'
		}},
		id_restaurante: {type: Sequelize.INTEGER, references: {
			model: Restaurante,
			key: 'id_restaurante'
		}},
		id_alerta: {type: Sequelize.INTEGER, references: {
			model: Alerta,
			key: 'id_alerta'
		}}
	});

	var AdminSitioTuristico = sequelize.define('adminsitioturistico', {
		id_adminsitioturistico: {type: Sequelize.INTEGER, primaryKey:true, autoIncrement:true},
		id_Usuario: {type: Sequelize.INTEGER, references: {
			model: Usuario,
			key: 'id_usuario'
		}},
		id_sitioturistico: {type: Sequelize.INTEGER, references: {
			model: SitioTuristico,
			key: 'id_sitioturistico'
		}}
	});

	sequelize.sync({ force: true});
	var puerto=3000;
	var conf=require('./config');
	var app=express();
	app.use(bodyParser.urlencoded({
		extended: true
	}));
	app.use(bodyParser.json());
	app.use('/api/v1',require('./routes')(app));
	app.set('rol', Rol);
	app.set('usuario', Usuario);
	app.set('tipohotel', TipoHotel);
	app.set('hotel', Hotel);
	app.set('restaurante', Restaurante);
	app.set('mapa', Mapa);
	app.set('bitacora', Bitacora);
	app.set('alerta', Alerta);
	app.set('sitioturistico', SitioTuristico);
	app.set('adminsitioturistico', AdminSitioTuristico);
	app.listen(puerto,function () {
		console.log("Servidor iniciado en el puerto: " + puerto);
		console.log("Debug del server: ");
	});
})();
