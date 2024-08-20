import { Sequelize, QueryTypes, Options } from 'sequelize';

const options: Options = {
  username: 'asuse',
  password: 'kl0pik',
  database: 'asuse',
  host: 'asuse-ai-dev.infoenergo.loc',
  port: 5432,
  dialect: 'postgres',
};

const sequelize = new Sequelize(options);

export const execFunction = async () => {
  const results = await sequelize.query(
    'select * from report_dm.dim_отделение',
    { type: QueryTypes.SELECT },
  );
  return results
};
