import { Schema } from "../../../classes/Schema";
import procedures from "./procedures";
import tables from "./tables";

export default [
  new Schema({
    fileName: __filename,
    createStatement: /*sql*/ `CREATE SCHEMA report_stg`,
  }),
  ...tables,
  ...procedures,
];
