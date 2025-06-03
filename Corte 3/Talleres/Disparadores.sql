/*Caso 1: Registro automático de fecha en book_authors
Problema:
Cuando se inserta un nuevo registro en la tabla book_authors, el campo created_at no siempre se llena, lo que puede dificultar saber cuándo se vinculó un autor a un libro.

 Solución:
Crear un trigger que automáticamente llene created_at con la fecha y hora actual si el campo no fue especificado.

 Disparador:
 */
CREATE OR REPLACE FUNCTION set_created_at_book_authors()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.created_at IS NULL THEN
        NEW.created_at := CURRENT_TIMESTAMP;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_set_created_at
BEFORE INSERT ON book_authors
FOR EACH ROW
EXECUTE FUNCTION set_created_at_book_authors();
--prueba
INSERT INTO book_authors (book_id, author_id) VALUES (1, 2);
--verificar
SELECT * FROM book_authors WHERE book_id = 1 AND author_id = 2;


/*
 Caso 2: Validar monto positivo en sanctions
 Problema:
Un usuario o sistema puede insertar una sanción con un valor negativo por error, lo que provocaría inconsistencias financieras.

 Solución:
Crear un trigger que verifique antes de insertar o actualizar que el amount sea mayor o igual a cero. Si no lo es, lanza una excepción.

 Disparador:
 */
CREATE OR REPLACE FUNCTION check_sanction_amount()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.amount < 0 THEN
        RAISE EXCEPTION 'El monto de la sanción no puede ser negativo';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_sanction_amount
BEFORE INSERT OR UPDATE ON sanctions
FOR EACH ROW
EXECUTE FUNCTION check_sanction_amount();
--prueba
INSERT INTO sanctions (reason, amount, date, loan_id) 
VALUES ('Error de prueba', -10.00, CURRENT_TIMESTAMP, 1);


/*
 Caso 3: Notificar préstamo con devolución vencida
 Problema:
Se necesita registrar automáticamente una advertencia cuando se inserta un préstamo cuya return_date ya está en el pasado (quizás por un error manual).

 Solución:
Crear un trigger que registre una advertencia en una tabla loan_alerts si la fecha de devolución es anterior a la fecha actual al momento del registro.

 Disparador:
 */
CREATE OR REPLACE FUNCTION set_loan_date_if_null()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.loan_date IS NULL THEN
        NEW.loan_date := CURRENT_TIMESTAMP;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_set_loan_date
BEFORE INSERT ON loans
FOR EACH ROW
EXECUTE FUNCTION set_loan_date_if_null();
--prueba
INSERT INTO loans (return_date, book_id, student_id, employee_id)
VALUES (CURRENT_TIMESTAMP + INTERVAL '7 days', 2, 3, 4);
--verificar
SELECT * FROM loans WHERE book_id = 2 AND student_id = 3 ORDER BY id DESC LIMIT 1;


