import { Sequelize } from "sequelize";
import options from "../config";
import { DbObject } from "../classes/DbObject";

const sequelize = new Sequelize(options);

export const resetDbObject = async (dbObject: DbObject) => {
  await sequelize.query(dbObject.deleteSql());
  await sequelize.query(dbObject.createSql());
};
