import type { DataSource } from "./DataSource";
import type { Form } from "./Form";
import { Report } from "./Report";

export type NavigatorItem = Folder | Report;

export interface FolderProps {
  title: string;
  items: NavigatorItem[];
}

export class Folder {
  title: string;
  items: NavigatorItem[];
  constructor(props: FolderProps) {
    this.title = props.title;
    this.items = props.items;
  }
}
