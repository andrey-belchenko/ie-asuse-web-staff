import type { DataSource } from "./DataSource";
import type { NavigatorItem } from "./Folder";
import type { Form } from "./Form";
import { Report } from "./Report";

export interface NavigatorProps {
  items: NavigatorItem[];
}

export class Navigator {
  items: NavigatorItem[];
  constructor(props: NavigatorProps) {
    this.items = props.items;
  }
}
