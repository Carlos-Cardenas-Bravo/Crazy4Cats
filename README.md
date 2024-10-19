
# DESARROLLO RUBY ON RAILS PARA EMPRENDIMIENTOS DE TIPO STARTUP

Desafío - Desafío - Relaciones N a N en los modelos






## Autor

- [@Carlos-Cardenas-Bravo](https://github.com/Carlos-Cardenas-Bravo)


## Lógica utilizada

Se generó una app según lo indicado del tipo blog para amantes de los gatos.

Se generaron roles dentro de los usuarios manejados con devise, de forma que el administrador (Editor) fuera el único que puede borrar cualquier comentario realizado a las publicaciones, además de poder borrarlas y editarla aunque el no sea el creador.

Los usuarios normales (registrados) pueden postear historias y comentar cualquier historia además de reaccionar (1 sola vez) a ellas. También pueden borrar o editar las publicaciones que ellos hayan creado.

Los visitantes (usuarios no registrados) pueden ver el listado de publicaciones, entrar a ellas, ver los comentarios, comentar las publicaciones, pero no pueden reaccionar a las publicaciones de forma de evitar las reacciones masivas.

Además el Administrador puede listar todos los usuarios y cambiar el rol del que desee de usuario normal a administrador, asi como puede cambiar el rol de otro administrador a usuario normal.
Lo que no puede hacer es cambiarse el mismo su rol de administrador a usuario normal.

Las claves de base de datos y Mailtrap (con el cual se probó la restitución de contraseña) se manejan con Figaro.

Se incluyo dentro de los contenidos que acepta una publicación (además del título y descripción) el poder cargar una imagen. Para esto se utilizó Active Storage. Y se utilizó la gema ImageProcessing para conservar la relación ancho, alto de las imagenes pero adecuarlas a un formato máximo de 300x300 pixeles.

Se uso la gema httparty para poder enlazar a la API de https://thecatapi.com/ y asi a través de seed poder asignarle una foto de gatos a cada publicación. Las publicaciones y usuarios se poblaron con seed usando faker.

Se paginó con la gema pagy.

Se documentaron los modelos con la gema annotate.

Para probar la app con el rol de Administrador se debe usar:

email: admin@admin.com

password: 123456

Se ocupó el framework de css Bulma para darle estilo a la aplicación.


## Versiones Utilizadas

Para tener una funcionalidad completa de la aplicación debes tener las siguientes versiones de los softwares utilizados.

`Ruby 3.3.3`

`Rails 7.2.1 `


## 🚀 About Me
I'm a human apprentice


