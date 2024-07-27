import { DbObject, DpObjectProps } from "./DbObject";

export type SchemaProps = DpObjectProps;
export class Schema extends DbObject {
  constructor(props: SchemaProps) {
    super(props);
  }
}
