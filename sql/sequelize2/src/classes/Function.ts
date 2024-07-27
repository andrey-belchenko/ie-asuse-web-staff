import { DbObject, DpObjectProps } from "./DbObject";

export type FunctionProps = DpObjectProps;
export class Function extends DbObject {
  constructor(props: FunctionProps) {
    super(props);
  }
}
