-- Insertar Usuarios
INSERT INTO User (username, email, contrasenia) VALUES 
('juan', 'juan@gmail.com', 'pass1'),
('pedro', 'pedro@gmail.com', 'pass2'),
('susana', 'susana@gmail.com', 'pass3'),
('maria', 'maria@gmail.com', 'pass4'),
('carlos', 'carlos@gmail.com', 'pass5'),
('ana', 'ana@gmail.com', 'pass6'),
('luis', 'luis@gmail.com', 'pass7'),
('paula', 'paula@gmail.com', 'pass8'),
('diego', 'diego@gmail.com', 'pass9'),
('veronica', 'veronica@gmail.com', 'pass10');

-- Insertar Roles
INSERT INTO Role (role_name) VALUES 
('Admin'),
('Editor'),
('Viewer');

-- Asignar Roles
INSERT INTO User_role (user_id, role_id) VALUES 
(1, 1),  -- usuario1 -> Admin
(2, 2),  -- usuario2 -> Editor
(3, 3),  -- usuario3 -> Viewer
(4,2),	 -- usuario4 -> Editor
(5, 3),  -- usuario5 -> Viewer
(6, 3),  -- usuario6 -> Viewer
(7, 2),  -- usuario7 -> Editor
(8, 3),  -- usuario8 -> Viewer
(9, 2),  -- usuario9 -> Editor
(10, 3); -- usuario10 -> Viewer

-- Insertar Imagenes con stored procedure
CALL insertar_imagen_sp(1, 'http://example.com/imagen1.jpg', 'Primera Imagen', '2024-06-01');
CALL insertar_imagen_sp(2, 'http://example.com/imagen2.jpg', 'Segunda Imagen', '2024-06-02');
CALL insertar_imagen_sp(3, 'http://example.com/imagen3.jpg', 'Tercera Imagen', '2024-06-03'); 
CALL insertar_imagen_sp(4, 'http://example.com/imagen4.jpg', 'Cuarta Imagen', '2024-06-04');
CALL insertar_imagen_sp(5, 'http://example.com/imagen5.jpg', 'Quinta Imagen', '2024-06-05');
CALL insertar_imagen_sp(6, 'http://example.com/imagen6.jpg', 'Sexta Imagen', '2024-06-06');
CALL insertar_imagen_sp(7, 'http://example.com/imagen7.jpg', 'Séptima Imagen', '2024-06-07');
CALL insertar_imagen_sp(8, 'http://example.com/imagen8.jpg', 'Octava Imagen', '2024-06-08');
CALL insertar_imagen_sp(9, 'http://example.com/imagen9.jpg', 'Novena Imagen', '2024-06-09');
CALL insertar_imagen_sp(10, 'http://example.com/imagen10.jpg', 'Décima Imagen', '2024-06-10');
CALL insertar_imagen_sp(2, 'http://example.com/imagen11.jpg', 'Undécima Imagen', '2024-06-10');
CALL insertar_imagen_sp(2, 'http://example.com/imagen12.jpg', 'Duodécima Imagen', '2024-06-10');
CALL insertar_imagen_sp(2, 'http://example.com/imagen13.jpg', 'Treceava Imagen', '2024-06-10');
CALL insertar_imagen_sp(8, 'http://example.com/imagen14.jpg', 'Catorceava Imagen', '2024-06-10');
CALL insertar_imagen_sp(5, 'http://example.com/imagen15.jpg', 'Quinceava Imagen', '2024-06-10');


-- Insertar Likes y Dislikes
INSERT INTO Like_dislike (is_like, image_id, user_id) VALUES 
(TRUE, 1, 2),   -- usuario2 le da like a imagen1
(FALSE, 1, 3),  -- usuario3 le da dislike a imagen1
(TRUE, 2, 1),   -- usuario1 le da like a imagen2
(TRUE, 3, 2),   -- usuario2 le da like a imagen3
(FALSE, 4, 4),  -- usuario4 le da dislike a imagen4
(TRUE, 5, 5),   -- usuario5 le da dislike a imagen5
(TRUE, 5, 6),   -- usuario6 le da dislike a imagen5
(FALSE, 5, 7),  -- usuario7 le da dislike a imagen5
(TRUE, 5, 8),   -- usuario8 le da dislike a imagen5
(TRUE, 5, 9),   -- usuario9 le da dislike a imagen5
(FALSE, 2, 10), -- usuario10 le da dislike a imagen2
(FALSE, 11, 10), -- usuario10 le da dislike a imagen11
(FALSE, 13, 4), -- usuario4 le da dislike a imagen13
(FALSE, 14, 1), -- usuario1 le da dislike a imagen14
(TRUE, 15, 3), -- usuario3 le da like a imagen15
(TRUE, 12, 8); -- usuario8 le da like a imagen12

-- Insertar Comentarios con stored procedure userId, imageId
CALL insertar_comentario_sp(2, 1, '¡Me encanta esta imagen!', '2024-06-04');
CALL insertar_comentario_sp(3, 1, 'No está mal.', '2024-06-05');
CALL insertar_comentario_sp(1, 2, '¡Excelente!', '2024-06-06');
CALL insertar_comentario_sp(4, 3, 'Buen trabajo.', '2024-06-07');
CALL insertar_comentario_sp(5, 4, 'Impresionante.', '2024-06-08');
CALL insertar_comentario_sp(6, 5, 'Increíble imagen.', '2024-06-09');
CALL insertar_comentario_sp(7, 6, 'Muy buena toma.', '2024-06-10');
CALL insertar_comentario_sp(8, 7, 'Gran trabajo.', '2024-06-11');
CALL insertar_comentario_sp(9, 8, 'Hermoso paisaje.', '2024-06-12');
CALL insertar_comentario_sp(10, 9, 'Fascinante.', '2024-06-13');
CALL insertar_comentario_sp(1, 11, 'Buenisimo.', '2024-06-13');
CALL insertar_comentario_sp(1, 14, 'No me gustó ):.', '2024-06-14');
CALL insertar_comentario_sp(8, 12, 'Like!', '2024-06-14');
CALL insertar_comentario_sp(4, 13, 'Hay mejores...', '2024-06-14');
CALL insertar_comentario_sp(3, 15, 'Eres muy bueno!', '2024-06-14');
-- Insertar Tags
INSERT INTO Tag (tag_name) VALUES 
('Naturaleza'),
('Arte'),
('Tecnología'),
('Viajes'),
('Deportes'),
('Animales'),
('Comida'),
('Arquitectura'),
('Moda'),
('Música');

-- Relacionar Tags con Imagenes

-- Image 1 -> Naturaleza, Viajes, Animales, Comida, Arquitectura
INSERT INTO Image_tag (image_id, tag_id) VALUES (1, 1), (1, 4), (1, 6), (1, 7), (1, 8);

-- Image 2 -> Arte, Teconología, Arquitectura, Moda, Musica
INSERT INTO Image_tag (image_id, tag_id) VALUES (2, 2), (2, 3), (2, 8), (2, 9), (2, 10);

-- Image 3 -> Teconología, Viajes, Deportes, Comida, Musica
INSERT INTO Image_tag (image_id, tag_id) VALUES (3, 3), (3, 4), (3, 5), (3, 7), (3, 10);

-- Image 4 -> Naturaleza, Viajes, Animales, Arquitectura, Moda
INSERT INTO Image_tag (image_id, tag_id) VALUES (4, 1), (4, 4), (4, 6), (4, 8), (4, 9);

-- Image 5 -> Deportes, Animales, Tecnología, Comida, Música
INSERT INTO Image_tag (image_id, tag_id) VALUES (5, 5), (5, 6), (5, 3), (5, 7), (5, 10);

-- Image 6 -> Naturaleza, Animales, Moda, Deportes, Arte
INSERT INTO Image_tag (image_id, tag_id) VALUES (6, 1), (6, 6), (6, 9), (6, 5), (6, 2);

-- Image 7 -> Comida, Moda, Viajes, Arquitectura, Arte
INSERT INTO Image_tag (image_id, tag_id) VALUES (7, 7), (7, 9), (7, 4), (7, 8), (7, 2);

-- Image 8 -> Arquitectura, Arte, Teconología, Animales, Naturaleza
INSERT INTO Image_tag (image_id, tag_id) VALUES (8, 8), (8, 2), (8, 3), (8, 6), (8, 1);

-- Imagen9 -> Moda, Música, Deportes, Arte, Viajes
INSERT INTO Image_tag (image_id, tag_id) VALUES (9, 9), (9, 10), (9, 5), (9, 2), (9, 4);

-- Imagen10 -> Música, Tecnología, Viajes, Animales, Comida
INSERT INTO Image_tag (image_id, tag_id) VALUES (10, 10), (10, 3), (10, 4), (10, 6), (10, 7);

-- Imagen12 -> Música, Viajes, Comida, Moda, Arte
INSERT INTO Image_tag (image_id, tag_id) VALUES (12, 10), (12, 4), (12, 7), (12, 9), (12, 2);

-- Imagen13 -> Arte, Tecnología, Animales, Naturaleza, Arquitectura
INSERT INTO Image_tag (image_id, tag_id) VALUES (13, 2), (13, 3), (13, 6), (13, 1), (13, 8);

-- Imagen14 -> Viajes, Comida, Deportes, Música, Moda
INSERT INTO Image_tag (image_id, tag_id) VALUES (14, 4), (14, 7), (14, 5), (14, 10), (14, 9);

-- Imagen15 -> Moda, Animales, Arte, Tecnología, Viajes
INSERT INTO Image_tag (image_id, tag_id) VALUES (15, 9), (15, 6), (15, 2), (15, 3), (15, 4);

-- Insertar Categorías
INSERT INTO Categories (category_name) VALUES 
('Paisajes'),
('Retratos'),
('Eventos'),
('Arte Abstracto'),
('Tecnología'),
('Animales'),
('Comida'),
('Arquitectura'),
('Moda'),
('Música');

-- Relacionar Imagenes con Categorías
INSERT INTO Image_category (image_id, category_id) VALUES 
(1, 1),  -- Imagen1 -> Paisajes
(2, 2),  -- Imagen2 -> Retratos
(3, 3),  -- Imagen3 -> Eventos
(4, 4),  -- Imagen4 -> Arte Abstracto
(5, 5),  -- Imagen5 -> Tecnología
(6, 6),  -- Imagen6 -> Animales
(7, 7),  -- Imagen7 -> Comida
(8, 8),  -- Imagen8 -> Arquitectura
(9, 9),  -- Imagen9 -> Moda
(10, 10),-- Imagen10 -> Música
(11, 10),-- Imagen11 -> Música
(12, 10),-- Imagen12 -> Música
(13, 2), -- Imagen13 -> Retratos
(14, 7),-- Imagen14 -> Comida
(15, 9);-- Imagen15 -> Moda

-- Insertar Reportes
INSERT INTO Reports (reporter_id, reported_user_id, reported_image_id, report_reason, report_date) VALUES 
(1, 2, 3, 'Contenido ofensivo', '2024-01-15 10:34:00'),
(2, 1, 1, 'Violación de derechos de autor', '2024-02-10 14:21:00'),
(4, 2, 11, 'Spam', '2024-03-05 09:45:00'),
(6, 5, 15, 'Incitación al odio', '2024-04-20 16:30:00'),
(7, 8, 14, 'Desinformación', '2024-05-12 11:50:00'),
(9, 8, 2, 'Contenido inapropiado', '2024-06-18 13:15:00'),
(10, 9, 9, 'Publicidad no solicitada', '2024-07-22 08:05:00'),
(3, 1, 1, 'Información falsa', '2024-08-05 17:40:00'),
(5, 1, 1, 'Violencia gráfica', '2024-09-14 12:00:00'),
(8, 7, 7, 'Acoso', '2024-10-10 19:25:00');

-- Insertar Seguidores
INSERT INTO Followers (follower_id, followed_id) VALUES 
(1, 2), -- Usuario1 sigue a usuario 2
(2, 3), -- Usuario2 sigue a usuario 3
(3, 4), -- Usuario3 sigue a usuario 4
(4, 5), -- Usuario4 sigue a usuario 5
(5, 1), -- Usuario5 sigue a usuario 1
(6, 1), -- Usuario6 sigue a usuario 1 
(7, 2), -- Usuario7 sigue a usuario 2
(8, 2), -- Usuario8 sigue a usuario 2
(9, 10),-- Usuario9 sigue a usuario 10
(10, 3);-- Usuario10 sigue a usuario 3

-- Insertar Notificaciones
INSERT INTO Notifications (user_id, message) VALUES 
(1, 'Has recibido un nuevo seguidor.'),
(2, 'Tu imagen ha recibido un like.'),
(3, 'Tienes un nuevo comentario en tu imagen.'),
(4, 'Tu reporte ha sido revisado.'),
(5, 'Has sido mencionado en un comentario.'),
(6, 'Tienes una nueva notificación.'),
(7, 'Tu imagen ha sido destacada.'),
(8, 'Un usuario te ha enviado un mensaje.'),
(9, 'Has ganado un nuevo seguidor.'),
(10, 'Se ha actualizado tu perfil.');

-- Insertar Metadatos de Imagenes
INSERT INTO Image_metadata (image_id, resolution, size_in_kb, format) VALUES 
(1, '1920x1080', 2048, 'JPEG'),
(2, '1280x720', 1024, 'PNG'),
(3, '800x600', 512, 'GIF'),
(4, '640x480', 256, 'BMP'),
(5, '1024x768', 1536, 'TIFF');

-- Insertar Eventos
INSERT INTO Events (event_name, event_description, event_date) VALUES 
('Exposición de Arte', 'Una exposición de arte local.', '2025-03-01'),
('Concurso de Fotografía', 'Participa en el concurso anual de fotografía.', '2025-05-15'),
('Charla sobre Tecnología', 'Una charla sobre las últimas tendencias en tecnología.', '2025-06-10');

-- Relacionar Imagenes con Eventos
INSERT INTO Image_events (image_id, event_id) VALUES 
(1, 1),  -- Imagen1 -> Exposición de Arte
(2, 2),  -- Imagen2 -> Concurso de Fotografía
(3, 3);  -- Imagen3 -> Charla sobre Tecnología

-- Insertar Mensajes
INSERT INTO Messages (sender_id, receiver_id, message_content) VALUES 
(1, 2, 'Hola, ¿cómo estás?'),
(2, 3, '¿Te gustó la imagen?'),
(3, 4, 'Gracias por seguirme.'),
(4, 5, '¡Nos vemos en el evento!'),
(5, 1, '¿Cuándo subes una nueva imagen?'),
(6, 1, '¿Que estas haciendo?'),
(7, 4, '¿Vas a entrar al evento?');


-- Insertar Álbumes
INSERT INTO Albums (user_id, album_name) VALUES 
(1, 'Paisajes'),
(2, 'Retratos'),
(3, 'Viajes'),
(4, 'Tecnología'),
(5, 'Arte Abstracto');

INSERT INTO Album_images (album_id, image_id) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- Insertar users activities
INSERT INTO User_activity (user_id, activity_type, target_id, activity_date) VALUES
(1, 'report', 3, '2024-01-15 10:34:00'),
(2, 'report', 1, '2024-02-10 14:21:00'),
(4, 'report', 11, '2024-03-05 09:45:00'),
(6, 'report', 15, '2024-04-20 16:30:00'),
(7, 'report', 14, '2024-05-12 11:50:00'),
(9, 'report', 2, '2024-06-18 13:15:00'),
(10, 'report', 9, '2024-07-22 08:05:00'),
(3, 'report', 1, '2024-08-05 17:40:00'),
(5, 'report', 1, '2024-09-14 12:00:00'),
(8, 'report', 7, '2024-10-10 19:25:00'),

(2, 'comment', 1, '2024-06-04 10:00:00'),
(3, 'comment', 1, '2024-06-05 11:00:00'),
(1, 'comment', 2, '2024-06-06 12:00:00'),
(4, 'comment', 3, '2024-06-07 13:00:00'),
(5, 'comment', 4, '2024-06-08 14:00:00'),
(6, 'comment', 5, '2024-06-09 15:00:00'),
(7, 'comment', 6, '2024-06-10 16:00:00'),
(8, 'comment', 7, '2024-06-11 17:00:00'),
(9, 'comment', 8, '2024-06-12 18:00:00'),
(10, 'comment', 9, '2024-06-13 19:00:00'),

(2, 'like', 1, '2024-06-01 12:00:00'),
(3, 'dislike', 1, '2024-06-02 13:00:00'),
(1, 'like', 2, '2024-06-03 14:00:00'),
(2, 'like', 3, '2024-06-04 15:00:00'),
(4, 'dislike', 4, '2024-06-05 16:00:00'),
(5, 'like', 5, '2024-06-06 17:00:00'),
(6, 'like', 5, '2024-06-07 18:00:00'),
(7, 'dislike', 5, '2024-06-08 19:00:00'),
(8, 'like', 5, '2024-06-09 20:00:00'),
(9, 'like', 5, '2024-06-10 21:00:00'),
(10, 'dislike', 2, '2024-06-11 22:00:00'),
(10, 'dislike', 11, '2024-06-12 23:00:00'),
(4, 'dislike', 13, '2024-06-13 10:00:00'),
(1, 'dislike', 14, '2024-06-14 11:00:00'),
(3, 'like', 15, '2024-06-15 12:00:00'),
(8, 'like', 12, '2024-06-16 13:00:00');