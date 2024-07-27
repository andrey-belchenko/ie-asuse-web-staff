import declaration from "../declaration";
import { resetDbObject } from "../utils/management";


const run = async () => {
  for (let item of declaration) {
    resetDbObject(item);
  }
};

run();
