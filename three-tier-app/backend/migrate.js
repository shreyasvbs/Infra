const { Client } = require("pg");

async function migrate() {

  const client = new Client({
    connectionString: process.env.DATABASE_URL
  });

  try {

    await client.connect();

    console.log("Connected to PostgreSQL");

    await client.query(`
      CREATE TABLE IF NOT EXISTS users (
        id SERIAL PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        email VARCHAR(255) UNIQUE NOT NULL
      );
    `);

    await client.query(`
      INSERT INTO users (name, email)
      VALUES
        ('Alice', 'alice@example.com'),
        ('Bob', 'bob@example.com')
      ON CONFLICT (email) DO NOTHING;
    `);

    console.log(
      "Database migration completed successfully"
    );

  } finally {

    await client.end();

  }
}

migrate().catch(error => {

  console.error(
    "Database migration failed:",
    error
  );

  process.exit(1);

});