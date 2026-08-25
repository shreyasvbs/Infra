const express = require("express");
const { Pool } = require("pg");

const app = express();

const PORT = process.env.PORT || 8080;

app.use(express.json());

const pool = new Pool({
  connectionString: process.env.DATABASE_URL
});


app.get("/api/health", async (req, res) => {

  try {

    await pool.query("SELECT 1");

    res.json({
      status: "ok",
      service: "node-api",
      message: "Hello from Node.js API",
      database: "Connected"
    });

  } catch (error) {

    console.error(error);

    res.status(500).json({
      status: "error",
      service: "node-api",
      message: "API running but database unavailable",
      database: "Disconnected"
    });

  }

});


app.get("/api/users", async (req, res) => {

  try {

    const result = await pool.query(
      "SELECT id, name, email FROM users ORDER BY id"
    );

    res.json(result.rows);

  } catch (error) {

    console.error(error);

    res.status(500).json({
      error: "Failed to retrieve users"
    });

  }

});


app.get("/api/ready", async (req, res) => {

  try {

    await pool.query("SELECT 1");

    res.json({
      ready: true
    });

  } catch {

    res.status(503).json({
      ready: false
    });

  }

});


app.listen(PORT, "0.0.0.0", () => {

  console.log(
    `Node.js API listening on ${PORT}`
  );

});