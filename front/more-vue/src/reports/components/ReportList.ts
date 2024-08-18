import nav10 from "../config/navigators/nav10";
import { Folder, type NavigatorItem } from "../types/Folder";

export default [
  {
    id: "1",
    text: "Отчеты по задолженности",
    expanded: true,
    items: [
      {
        id: "1_1",
        text: "Сверхнормативная задолженность",
        expanded: true,
      },
      {
        id: "1_2",
        text: "Задолженность по договору",
      },
    ],
  },
];

export const navigator = nav10;

type TreeItem = {
  data: NavigatorItem;
  id: number;
  parentId?: number;
  title: string;
};

export function getTreeItems() {
  const treeItems: TreeItem[] = [];
  let id = 0;
  const getNext = (items: NavigatorItem[], parentId?: number) => {
    for (let item of items) {
      id++;
      const treeItem: TreeItem = {
        id: id,
        data: item,
        title: item.title,
      };
      if (parentId) {
        treeItem.parentId = parentId;
      }
      treeItems.push(treeItem);
      if (item instanceof Folder) {
        getNext(item.items, id);
      }
    }
  };
  getNext(navigator.items);
  debugger;
  return treeItems;
}
