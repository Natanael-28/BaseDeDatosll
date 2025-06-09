# 🧠 Base de Datos MongoDB – Operadores Lógicos y de Comparación

Este repositorio contiene un respaldo de una base de datos MongoDB con información detallada sobre el uso de:

- ✅ Operadores lógicos: `$and`, `$or`, `$nor`, `$not`, `$expr`
- 🔁 Combinaciones de operadores lógicos
- 📊 Operadores de comparación: `$gt`, `$lt`, `$eq`, `$ne`, `$gte`, `$lte`, `$in`, `$nin`
- 🧩 Combinaciones entre operadores de comparación



---

## 📦 Estructura del backup

Se incluyen archivos `.json` exportados desde MongoDB Compass para las siguientes colecciones:

- `operadores`: operadores lógicos individuales
- `operadoresCombinaciones`: combinaciones de operadores (lógicos y de comparación)

---

## 🔄 Restaurar la base de datos desde MongoDB Compass

### ✅ Pasos:

1. Abre **MongoDB Compass**
2. Conéctate a tu base de datos (local o Atlas)
3. Crea una nueva base de datos llamada, por ejemplo, `operadoresDB`
4. Crea las colecciones necesarias:  
   - `operadores`  
   - `operadoresCombinaciones`
5. En cada colección:
   - Haz clic en **"Import Data"**
   - Selecciona el archivo `.json` correspondiente
   - Asegúrate de que el tipo sea **JSON - Extended**
6. Repite para cada colección

---

## 🔍 Consultas de ejemplo

### 📌 1. Consultar un operador lógico específico

```js
db.operadores.findOne({ operador: "$and" })
```

---

### 📌 2. Consultar todos los operadores lógicos disponibles

```js
db.operadores.find({})
```

---

### 📌 3. Consultar una combinación específica de operadores lógicos

```js
db.operadoresCombinaciones.find({
  operadores: { $all: ["$and", "$or"] }
})
```

---

### 📌 4. Consultar combinaciones de comparación

```js
db.operadoresCombinaciones.find({
  operadores: { $all: ["$gt", "$lt"] }
})
```

---

### 📌 5. Ver todas las combinaciones existentes

```js
db.operadoresCombinaciones.find({}, { operadores: 1, _id: 0 })
```

---

## 💡 Ejemplo de documento en la colección `operadores`

```json
{
  "operador": "$and",
  "descripcion": "Devuelve true si TODOS los subcriterios se cumplen",
  "sintaxis": {
    "forma": "$and: [ <cond1>, <cond2>, ... ]"
  },
  "ejemplo": {
    "consulta": {
      "$and": [
        { "edad": { "$gt": 18 } },
        { "activo": true }
      ]
    },
    "explicación": "Personas mayores de 18 y activas"
  }
}
```

---

## 💡 Ejemplo de documento en la colección `operadoresCombinaciones`

```json
{
  "operadores": ["$gt", "$lt"],
  "descripcion": "Rango entre dos valores",
  "sintaxis": {
    "forma": "{ campo: { $gt: valor1, $lt: valor2 } }"
  },
  "ejemplo": {
    "consulta": { "edad": { "$gt": 18, "$lt": 30 } },
    "explicación": "Personas entre 19 y 29 años"
  }
}
```

---

## 🛠️ Requisitos

- MongoDB Compass instalado
- MongoDB Server local o cuenta en Atlas

---


