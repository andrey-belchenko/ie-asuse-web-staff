// import { Sequelize, QueryTypes, Options } from 'sequelize';

// const options: Options = {
//   username: 'asuse',
//   password: 'kl0pik',
//   database: 'asuse',
//   host: 'asuse-ai-dev.infoenergo.loc',
//   port: 5432,
//   dialect: 'postgres',
// };

// const sequelize = new Sequelize(options);

// export const execFunction = async (functionName: string, params: any) => {
//   const results = await sequelize.query(
//     // "select * from report_util.get_оборотная_ведомость('2021-03-01','2021-03-31',ARRAY [1210,1172]) limit 1",
//     "select cast(123.12 as decimal) as value",
//     { type: QueryTypes.SELECT },
//   );

//   return results;
// };

import { Pool, types } from 'pg';
import { replaceDateStrings } from './mongo';

types.setTypeParser(1700, 'text', parseFloat);

const pool = new Pool({
  connectionString: `postgres://asuse:kl0pik@asuse-ai-dev.infoenergo.loc:5432/asuse`,
});

export const execFunction = async (functionName: string, params: any) => {
  const client = await pool.connect();
  try {
    let v = [{ qq: '1' }];
    params = replaceDateStrings(params);
    let paramsStr = '';
    let q = '';
    let i = 0;
    const paramsArray = [];
    for (let name in params) {
      i++;
      let value = params[name];
      if (value instanceof Date) {
        value = value.toISOString().split('T')[0];
      }
      paramsStr += q + name + ' => ' + '$' + i;
      q = ', ';
      paramsArray.push(value);
    }
    // const res = await client.query("select * from report_util.get_оборотная_ведомость('2021-03-01','2021-03-31',ARRAY [1210,1172])");
    const query = `select * from ${functionName}(${paramsStr})`;
    const res = await client.query(query, paramsArray);
    return res.rows as any[];
    return v;
  } finally {
    client.release();
  }
};
