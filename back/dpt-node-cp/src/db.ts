const { Pool } = require("pg");

const pool = new Pool({
  user: "asuse",
  host: "asuse-ai-dev.infoenergo.loc",
  database: "asuse",
  password: "kl0pik",
  port: 5432,
});

// const pool = new Pool({
//   user: "postgres",
//   host: "localhost",
//   database: "postgres",
//   password: "1",
//   port: 5432,
// });
export const getData = async () => {
  const client = await pool.connect();
  try {
    // const res = await client.query("select * from months");
    const res = await client.query("select * from kk_tipdog");
    return res.rows;
  } catch (err) {
    console.error(err);
  } finally {
    client.release();
  }
};
