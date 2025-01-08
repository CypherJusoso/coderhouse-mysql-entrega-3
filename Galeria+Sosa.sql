CREATE DATABASE db_coderhouse_gallery;
USE db_coderhouse_gallery;

CREATE TABLE User (
user_id INT AUTO_INCREMENT,
username VARCHAR(50) NOT NULL UNIQUE,
email VARCHAR(50) NOT NULL UNIQUE,
contrasenia VARCHAR(50) NOT NULL, 
total_images INT DEFAULT 0,
PRIMARY KEY (user_id)
);

CREATE TABLE Role (
role_id INT AUTO_INCREMENT,
role_name VARCHAR(50) NOT NULL UNIQUE,
PRIMARY KEY (role_id)
);

CREATE TABLE User_role (
user_id INT,
role_id INT,

CONSTRAINT fk_user_user_roles
	FOREIGN KEY (user_id)
    REFERENCES User(user_id)
    ON DELETE CASCADE,
    
CONSTRAINT fk_role_user_roles
	FOREIGN KEY (role_id)
    REFERENCES Role(role_id)
    ON DELETE CASCADE
);

CREATE TABLE Image (
image_id INT AUTO_INCREMENT,
user_id INT,
image_url VARCHAR(255) NOT NULL,
title VARCHAR(100),
upload_date DATE,

PRIMARY KEY (image_id),
CONSTRAINT fk_user_image
	FOREIGN KEY (user_id)
    REFERENCES User(user_id)
    ON DELETE CASCADE
);

CREATE TABLE Comment (
comment_id INT AUTO_INCREMENT,
user_id INT,
image_id INT,
content VARCHAR(255) NOT NULL,
upload_date DATE,

PRIMARY KEY (comment_id),
CONSTRAINT fk_user_comment
	FOREIGN KEY (user_id)
    REFERENCES User(user_id),
CONSTRAINT fk_image_comment
	FOREIGN KEY (image_id)
    REFERENCES Image(image_id)
    ON DELETE CASCADE
);

CREATE TABLE Tag (
tag_id INT AUTO_INCREMENT,
tag_name VARCHAR(255) UNIQUE NOT NULL,

PRIMARY KEY (tag_id)
);

CREATE TABLE Image_tag (
tag_id INT,
image_id INT,

CONSTRAINT fk_tag_image_tag
	FOREIGN KEY(tag_id)
    REFERENCES Tag(tag_id),
CONSTRAINT  fk_image_image_tag
	FOREIGN KEY(image_id)
    REFERENCES Image(image_id)
);

CREATE TABLE Like_dislike (
like_dislike_id INT AUTO_INCREMENT,
is_like BOOL,
image_id INT,
user_id INT,

PRIMARY KEY(like_dislike_id),
CONSTRAINT fk_image_like_dislike
	FOREIGN KEY(image_id)
    REFERENCES Image(image_id)
    ON DELETE CASCADE,
CONSTRAINT fk_user_like_dislike
	FOREIGN KEY(user_id)
    REFERENCES User(user_id)
);

CREATE TABLE Categories (
	category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

CREATE TABLE Image_category (
	image_id INT,
    category_id INT,
    PRIMARY KEY (image_id, category_id),
    FOREIGN KEY (image_id) REFERENCES Image(image_id),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

CREATE TABLE Reports (
	report_id INT AUTO_INCREMENT PRIMARY KEY,
    reporter_id INT,
    reported_user_id INT,
    reported_image_id INT,
    report_reason VARCHAR(255),
    report_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (reporter_id) REFERENCES User(user_id),
	FOREIGN KEY (reported_user_id) REFERENCES User(user_id),
    FOREIGN KEY (reported_image_id) REFERENCES Image(image_id)
);

CREATE TABLE Followers (
	follower_id INT,
    followed_id INT,
    followed_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (follower_id, followed_id),
    FOREIGN KEY (follower_id) REFERENCES User(user_id),
	FOREIGN KEY (followed_id) REFERENCES User(user_id)
);

CREATE TABLE Notifications (
	notification_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    message VARCHAR(255),
    notification_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

CREATE TABLE Image_metadata (
	image_id INT,
    resolution VARCHAR(50),
    size_in_kb INT,
    format VARCHAR(20),
    PRIMARY KEY (image_id),
    FOREIGN KEY (image_id) REFERENCES Image(image_id)
);

CREATE TABLE Events (
	event_id INT AUTO_INCREMENT PRIMARY KEY,
    event_name VARCHAR(100),
    event_description TEXT,
    event_date DATE
);

CREATE TABLE Image_events (
	image_id INT,
    event_id INT,
    PRIMARY KEY (image_id, event_id),
	FOREIGN KEY (image_id) REFERENCES Image(image_id),
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
);

CREATE TABLE Messages (
	message_id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id INT,
    receiver_id INT,
    message_content TEXT,
    message_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES User(user_id),
	FOREIGN KEY (receiver_id) REFERENCES User(user_id)
);

CREATE TABLE Albums (
	album_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    album_name VARCHAR(100) NOT NULL,
    creation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

CREATE TABLE Album_images (
	album_id INT,
    image_id INT,
    PRIMARY KEY (album_id, image_id),
    FOREIGN KEY (album_id) REFERENCES Albums(album_id),
    FOREIGN KEY (image_id) REFERENCES Image(image_id)
);



-- Vista para ver imagenes con su información y el nombre del usuario

CREATE VIEW imagenes_con_usuario_vista AS
SELECT 
i.image_id, 
i.title,
i.image_url,
i.upload_date, 
u.username AS uploaded_by
FROM Image i 
JOIN User u ON i.user_id = u.user_id;

-- Vista para ver comentarios con el nombre del usuario y titulo de la imagen

CREATE VIEW comentarios_con_usuario_y_imagen AS 
SELECT
c.comment_id,
c.content,
c.upload_date,
u.username AS commented_by,
i.title
FROM Comment c
JOIN User u ON c.user_id = u.user_id
JOIN Image i ON c.image_id = i.image_id;

-- Vista para ver imagenes con cantidad de likes y dislikes

CREATE VIEW imagenes_con_likes_y_dislikes AS
SELECT
i.image_id,
i.title,
COUNT(CASE WHEN ld.is_like = TRUE THEN 1 END) AS likes,
COUNT(CASE WHEN ld.is_like = FALSE THEN 1 END) AS dislikes
FROM Image i
LEFT JOIN Like_dislike ld ON i.image_id = ld.image_id
GROUP BY i.image_id, i.title;

-- Vista para ver usuarios con roles asignados

CREATE VIEW usuarios_con_roles AS
SELECT
u.user_id,
u.username,
r.role_name
FROM User u
JOIN User_role ur ON u.user_id = ur.user_id
JOIN Role r ON ur.role_id = r.role_id;

SELECT * FROM usuarios_con_roles;

-- Vista para ver imagenes con sus etiquetas

CREATE VIEW imagenes_con_tags AS
SELECT
i.image_id,
i.title,
t.tag_name
FROM Image i
JOIN Image_tag it ON i.image_id = it.image_id
JOIN Tag t ON it.tag_id = t.tag_id;

SELECT * FROM imagenes_con_tags;

-- Vista para ver a los usuarios que subieron más imágenes

CREATE VIEW usuarios_con_mas_imagenes AS
SELECT u.username, COUNT(i.image_id) AS total_images
FROM User u
JOIN Image i ON u.user_id = i.user_id
GROUP BY u.username
ORDER BY total_images DESC;

-- Vista para ver los tags más utlizados en imágenes

CREATE VIEW tags_mas_usados AS
SELECT t.tag_name, COUNT(it.image_id) AS total_images
FROM Tag t
JOIN Image_tag it ON t.tag_id = it.tag_id
GROUP BY t.tag_name
ORDER BY total_images DESC;

-- Vista para ver las imágenes con mas likes y dislikes

CREATE VIEW mas_likes_y_dislikes AS
SELECT i.title,
	SUM(CASE WHEN ld.is_like = TRUE THEN 1 ELSE 0 END) AS total_likes,
    SUM(CASE WHEN ld.is_like = FALSE THEN 1 ELSE 0 END) AS total_dislikes
FROM Image i
JOIN Like_dislike ld ON i.image_id = ld.image_id
GROUP BY i.title
ORDER BY total_likes DESC;

-- Vista para ver los usuarios con más reportes recibidos

CREATE VIEW usuarios_con_mas_reportes AS
SELECT u.username, COUNT(r.report_id) AS total_reports,
GROUP_CONCAT(DATE_FORMAT(r.report_date, "%Y-%m-%d") ORDER BY r.report_date ASC) AS report_dates
FROM User u
JOIN Reports r ON u.user_id = r.reported_user_id
GROUP BY u.username
ORDER BY total_reports DESC;

-- Función para contar la cantidad de comentarios por imagen

DELIMITER //
CREATE FUNCTION contar_comentarios_por_imagen_fn(imageID INT)
RETURNS INT
DETERMINISTIC
BEGIN
DECLARE comment_count INT;
SELECT COUNT(*) INTO comment_count
FROM Comment
WHERE image_id = imageID;
RETURN comment_count;
END;
//
 
 SELECT contar_comentarios_por_imagen_fn(5) AS total_comments;
 
 -- Función para verificar si un usuario le dio like o dislike a una imagen
 
 DELIMITER //
 CREATE FUNCTION usuario_interactuo_fn(userID INT, imageID INT)
 RETURNS BOOLEAN
 DETERMINISTIC
 BEGIN
 DECLARE exists_interaction BOOLEAN;
 SELECT EXISTS (
 SELECT 1 FROM Like_dislike
 WHERE user_id = userID and image_id = imageID
 ) INTO exists_interaction;
 RETURN exists_interaction;
 END;
//

 -- Función para obtener el total de likes de un usuario
 
 DELIMITER //
 CREATE FUNCTION cantidad_de_likes_de_usuario_fn(userID INT)
 RETURNS INT 
 DETERMINISTIC 
 BEGIN
 DECLARE cantidad_likes INT;
 SELECT COUNT(*) INTO cantidad_likes
 FROM Like_dislike ld
 WHERE ld.user_id = userID AND ld.is_like = TRUE;
 RETURN cantidad_likes;
 END;
 //

 -- Procedure para insertar una imagen
 
 DELIMITER //
 CREATE PROCEDURE insertar_imagen_sp
 (
IN p_user_id INT,
IN p_image_url VARCHAR(255),
IN p_title VARCHAR(100),
in p_upload_date DATE
 )
 BEGIN
 INSERT INTO Image (user_id, image_url, title, upload_date)
 VALUES (p_user_id, p_image_url, p_title, p_upload_date);
 END//
 DELIMITER ; 

 -- Procedure para insertar un comentario

 DELIMITER //
 CREATE PROCEDURE insertar_comentario_sp
 (
 IN p_user_id INT,
 IN p_image_id INT,
 IN p_content VARCHAR(255),
 IN p_upload_date DATE
 )
BEGIN
INSERT INTO Comment (user_id, image_id, content, upload_date)
VALUES (p_user_id, p_image_id, p_content, p_upload_date);
END //
DELIMITER ;

 -- Trigger para evitar comentarios vacios
 DELIMITER //
 CREATE TRIGGER evitar_comentario_vacio_tr
 BEFORE INSERT ON Comment
 FOR EACH ROW
 BEGIN
 IF TRIM(NEW.content) = '' THEN
 SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "EL COMENTARIO NO PUEDE ESTAR VACIO";
 END IF;
 END //;
 DELIMITER ;
 
  -- Trigger para actualizar total_images de un usuario despues de un insert en images
 DELIMITER //
 CREATE TRIGGER actualizar_total_images_tr
 AFTER INSERT ON Image
 FOR EACH ROW
 BEGIN
	UPDATE User u
    SET u.total_images = u.total_images + 1
    WHERE u.user_id = NEW.user_id;
 END //;
 DELIMITER ;
 
 -- Pruebas para vistas
SELECT * FROM imagenes_con_usuario_vista;
SELECT * FROM comentarios_con_usuario_y_imagen;
SELECT * FROM imagenes_con_likes_y_dislikes;
SELECT * FROM usuarios_con_roles;
SELECT * FROM imagenes_con_tags;
SELECT * FROM usuarios_con_mas_imagenes;
SELECT * FROM tags_mas_usados;
SELECT * FROM mas_likes_y_dislikes;
SELECT * FROM usuarios_con_mas_reportes;

  -- Pruebas para funciones
SELECT contar_comentarios_por_imagen_fn(1) AS total_comentarios_imagen1;
SELECT contar_comentarios_por_imagen_fn(2) AS total_comentarios_imagen2;

SELECT usuario_interactuo_fn(2, 1) AS usuario2_interactuo_con_imagen1; -- Debe retornar 1 (true)
SELECT usuario_interactuo_fn(3, 3) AS usuario3_interactuo_con_imagen3; -- Debe retornar 0 (false)

SELECT cantidad_de_likes_de_usuario_fn(2) AS total_likes_usuario2;
SELECT cantidad_de_likes_de_usuario_fn(1) AS total_likes_usuario1;

  -- Pruebas para triggers
SELECT username, total_images FROM User; -- total_images debe incrementarse si el usuario subio una foto
CALL insertar_comentario_sp(1, 1, '', '2024-06-07'); -- Esto deberia dar un error.


