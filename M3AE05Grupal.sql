

/*
        ACTIVIDAD GRUPAL M3 AE5
            Integrantes Sala 1:
            Mangel Tort
            Etzel Mencias
            Ricardo Silva
            Diego Paredes
            Carlos Pizarro
*/

-- Parte 1: Crear entorno de trabajo
	-- Crear una base de datos
	CREATE DATABASE IF NOT EXISTS telovendo;
    
    -- Crear un usuario con todos los privilegios para trabajar con la base de datos recién creada.
    CREATE USER 'admingrupal5'@'localhost' IDENTIFIED WITH mysql_native_password BY '333333333';
	GRANT ALL PRIVILEGES ON telovendo.* TO 'admingrupal5'@'localhost';
    
-- Parte 2: Crear dos tablas.
	-- La primera almacena a los usuarios de la aplicación (id_usuario, nombre, apellido, contraseña, zona horaria (por defecto UTC-3), género y teléfono de contacto).
    CREATE TABLE IF NOT EXISTS telovendo.usuario (
		id_usuario INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
        nombre VARCHAR(39) NOT NULL,
        apellido VARCHAR(39) NOT NULL,
        contrasenna VARCHAR(300) NOT NULL,
        zona_horaria VARCHAR(9) NOT NULL DEFAULT 'UTC-3',
        genero VARCHAR(7) NOT NULL,
        telefono_contacto VARCHAR(13) UNIQUE NOT NULL,
        CONSTRAINT contrasenna CHECK (LENGTH(contrasenna) >= 8 AND contrasenna REGEXP '^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+-=]).*$'),
        CHECK (genero IN ('Mujer', 'MUJER', 'mujer', 'Hombre', 'HOMBRE', 'hombre'))
    );
    
    /* La segunda tabla almacena información relacionada a la fecha-hora de ingreso de los usuarios a la plataforma 
    (id_ingreso, id_usuario y la fecha-hora de ingreso (por defecto la fecha-hora actual)).*/
    CREATE TABLE IF NOT EXISTS telovendo.fecha_ingreso (
		id_fecha_ingreso INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
        id_fk_usuario INT NOT NULL,
        fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        CONSTRAINT fk_fechaingreso_usuario FOREIGN KEY (id_fk_usuario) REFERENCES telovendo.usuario (id_usuario)
    );
    
-- Parte 3: Modificación de la tabla
	-- Modifique el UTC por defecto.Desde UTC-3 a UTC-2.
    ALTER TABLE telovendo.usuario ALTER COLUMN zona_horaria SET DEFAULT 'UTC-2';

-- Parte 4: Creación de registros.
	-- Para cada tabla crea 8 registros.
    INSERT INTO telovendo.usuario (nombre, apellido, contrasenna, genero, telefono_contacto) VALUES 
	('Derek', 'Lambourne', 'ARpcBh+zb1V', 'HOMBRE', '918915590'),
	('Casandra', 'Hassall', 'A2tU+LLq1H', 'MUJER', '989403791'),
	('Lemar', 'Cordero', '738C+5sxJb', 'HOMBRE', '918410830'),
	('Bari', 'Mash', 'p4Jb+GkX', 'MUJER', '9359580622'),
	('Matthieu', 'Tarbox', 'Xxqip+L0W', 'HOMBRE', '953086267'),
	('Lora', 'MacCoveney', 'Ep6g+TxaDl', 'MUJER', '951132908'),
	('Kelsey', 'Raffon', 'f7pI+qpEf', 'HOMBRE', '992809353'),
	('Ailis', 'Pietron', 'aQMz+Z99Vy1j', 'MUJER', '985349297');
    
    INSERT INTO telovendo.fecha_ingreso (id_fk_usuario) VALUES 
    (1), (8), (3), (7), (1), (4), (4), (5);
    
-- Parte 5: Justifique cada tipo de dato utilizado. ¿Es el óptimo en cada caso?
	/*
    >>> En la tabla usuario:
    
	> El campo id_usuario utiliza el tipo de datos INT, que es un tipo de datos entero que puede almacenar valores numéricos en un rango adecuado para el propósito de un identificador de usuario. Se ha agregado la cláusula PRIMARY KEY para asegurarse de que este campo actúe como clave primaria de la tabla y no tenga valores duplicados. Además, se ha habilitado la opción AUTO_INCREMENT para que el sistema genere automáticamente valores únicos para este campo al insertar nuevas filas.

	> Los campos nombre y apellido utilizan el tipo de datos VARCHAR, que es un tipo de datos de longitud variable que puede almacenar cadenas de caracteres de longitud variable. En este caso, se ha elegido una longitud de 39, lo que debería ser suficiente para almacenar nombres y apellidos típicos.

	> El campo contrasenna utiliza el tipo de datos VARCHAR con una longitud de 300 caracteres, lo que debería ser suficiente para almacenar contraseñas seguras en formato de texto plano. Además, se ha agregado una restricción de CHECK que asegura que las contraseñas tengan al menos 8 caracteres de longitud y contengan una combinación de letras mayúsculas y minúsculas, números y caracteres especiales.

	> El campo zona_horaria utiliza el tipo de datos VARCHAR con una longitud de 9 caracteres, lo que debería ser suficiente para almacenar códigos de zona horaria típicos. Además, se ha agregado un valor predeterminado de 'UTC-3' para garantizar que todos los usuarios tengan una zona horaria predeterminada.

	> El campo genero utiliza el tipo de datos VARCHAR con una longitud de 7 caracteres, lo que debería ser suficiente para almacenar valores de género típicos. Además, se ha agregado una restricción CHECK que garantiza que solo se puedan almacenar los valores 'Mujer' o 'Hombre', en cualquier combinación de mayúsculas y minúsculas.

	> El campo telefono_contacto utiliza el tipo de datos VARCHAR con una longitud de 13 caracteres, que debería ser suficiente para almacenar números de teléfono típicos, incluyendo el código de país y la extensión, si es necesario. Además, se ha agregado una restricción UNIQUE para garantizar que no se puedan insertar valores duplicados en este campo.
    
    >>> En la tabla fecha_ingreso:
    
    > El campo id_fecha_ingreso es de tipo INT con PRIMARY KEY y AUTO_INCREMENT, lo que permite que el campo sea único y se genere un valor automáticamente al momento de insertar un nuevo registro.
    
	> El campo id_fk_usuario es de tipo INT y se utiliza como clave foránea para hacer referencia al campo id_usuario en la tabla usuario. Esto es importante para establecer una relación entre las dos tablas.
    
	> El campo fecha es de tipo TIMESTAMP y se utiliza el valor DEFAULT CURRENT_TIMESTAMP para que se guarde la fecha y hora actual en el momento en que se inserta un nuevo registro. Esto es útil para llevar un registro de cuándo se hizo el ingreso de información.
    */
    
-- Parte 6: Creen una nueva tabla llamada Contactos (id_contacto, id_usuario, numero de telefono, correo electronico).
	CREATE TABLE IF NOT EXISTS telovendo.contacto (
		id_contacto INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
		id_usuario INT NOT NULL,
		telefono VARCHAR(13) UNIQUE NOT NULL,
		email VARCHAR(70) NOT NULL
	);

-- Parte 7: Modifique la columna teléfono de contacto, para crear un vínculo entre la tabla Usuarios y la Contactos.
	ALTER TABLE telovendo.contacto
	ADD CONSTRAINT fk_contacto_usuario
	FOREIGN KEY (telefono) REFERENCES telovendo.usuario (telefono_contacto);
