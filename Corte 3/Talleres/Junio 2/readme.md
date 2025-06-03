# Junio 2

## Investigar el tema de Disparadores

- **¿Qué son y para qué sirven?**  
  Los disparadores (triggers) son procedimientos que se ejecutan automáticamente en respuesta a ciertos eventos en una tabla o vista, como inserciones (`INSERT`), actualizaciones (`UPDATE`) o eliminaciones (`DELETE`).  
  Sirven para aplicar reglas de negocio, mantener la integridad de los datos o auditar acciones sin necesidad de que el usuario los dispare manualmente.

- **Ventajas y desventajas**  
  **Ventajas:**  
  - Automatizan tareas dentro de la base de datos.  
  - Aseguran la integridad y consistencia de los datos.  
  - Permiten auditorías automáticas (por ejemplo, registro de cambios).  

  **Desventajas:**  
  - Pueden hacer más difícil depurar errores.  
  - Su mal uso puede generar problemas de rendimiento.  
  - Pueden complicar el mantenimiento si hay muchos disparadores interrelacionados.

- **Sintaxis y cómo se utilizan**  
  En PostgreSQL, un ejemplo básico sería:

  ```sql
  CREATE OR REPLACE FUNCTION ejemplo_funcion()
  RETURNS trigger AS $$
  BEGIN
    -- Código a ejecutar
    RETURN NEW;
  END;
  $$ LANGUAGE plpgsql;

  CREATE TRIGGER ejemplo_trigger
  AFTER INSERT ON nombre_tabla
  FOR EACH ROW
  EXECUTE FUNCTION ejemplo_funcion();

