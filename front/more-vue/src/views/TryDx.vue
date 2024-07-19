<template>
  <DxDataGrid
    :data-source="store"
    :show-borders="true"
    :remote-operations="true"
  >
  </DxDataGrid>
</template>
<script setup lang="ts">
import {
  DxDataGrid, DxColumn, DxPaging, DxPager,
} from 'devextreme-vue/data-grid';
import CustomStore from 'devextreme/data/custom_store';
// import 'whatwg-fetch';

const isNotEmpty = (value: any) => value !== undefined && value !== null && value !== '';

const store = new CustomStore({
  key: 'OrderNumber',
  async load(loadOptions) {
    const paramNames = [
      'skip', 'take', 'requireTotalCount', 'requireGroupCount',
      'sort', 'filter', 'totalSummary', 'group', 'groupSummary',
    ] as const;

    const queryString = paramNames
      .filter((paramName) => isNotEmpty(loadOptions[paramName]))
      .map((paramName) => `${paramName}=${JSON.stringify(loadOptions[paramName])}`)
      .join('&');

    try {
      const response = await fetch(`https://js.devexpress.com/Demos/WidgetsGalleryDataService/api/orders?${queryString}`);

      const result = await response.json();

      return {
        data: result.data,
        totalCount: result.totalCount,
        summary: result.summary,
        groupCount: result.groupCount,
      };
    } catch (err) {
      throw new Error('Data Loading Error');
    }
  },
});
</script>
