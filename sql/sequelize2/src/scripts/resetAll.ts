import path from "path";
import { Sequelize } from "sequelize";
import config from "../config";

const options: any = config;
const sequelize = new Sequelize(options);

sequelize
  .query('DROP TABLE IF EXISTS public."SequelizeMeta"')
  .then(() => {
    console.log("Query executed successfully");
  })
  .catch((err: Error) => {
    console.error(err);
  });
