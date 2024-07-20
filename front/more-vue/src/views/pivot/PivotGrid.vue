<template>
    <div>
        <div class="long-title">
            <h3>Sales Amount by Region</h3>
        </div>
        <DxPivotGrid id="sales" :allow-sorting-by-summary="true" :allow-sorting="true" :allow-filtering="true"
            :allow-expand-all="true" :height="440" :show-borders="true" :data-source="dataSource">
          
        </DxPivotGrid>
    </div>
</template>
<script setup lang="ts">
import DxPivotGrid, {
    DxFieldChooser,
} from 'devextreme-vue/pivot-grid';
import PivotGridDataSource from 'devextreme/ui/pivot_grid/data_source';
import { sales } from './data';
import { createDataSource } from "../../api-client/query/query.js";
const dataStore = createDataSource({
      database: "bav_sample",
      collectionName: "financial_facts"
    })

const dataSource = new PivotGridDataSource({
    // "company": random.choice(companies),
    //     "product_type": random.choice(product_types),
    //     "revenue": random.randint(1, 100) * 1000,
    //     "expenses": random.randint(1, 100) * 500,
    //     "date": datetime.now()
    fields: [
        {
            caption: 'company',
            dataField: 'company',
            area: 'row',
        },
        {
            caption: 'product_type',
            dataField: 'product_type',
            area: 'row',
        },
        {
            dataField: 'date',
            dataType: 'date',
            area: 'column',
        },
        {
            caption: 'revenue',
            dataField: 'revenue',
            dataType: 'number',
            summaryType: 'sum',
            format: 'currency',
            area: 'data',
        },
        {
            caption: 'expenses',
            dataField: 'expenses',
            dataType: 'number',
            summaryType: 'sum',
            format: 'currency',
            area: 'data',
        },
    ],
    remoteOperations: true,
    store: dataStore,
});


</script>
<style scoped>
#sales {
    margin-top: 80px;
}

.long-title h3 {
    font-family:
        "Segoe UI Light",
        "Helvetica Neue Light",
        "Segoe UI",
        "Helvetica Neue",
        "Trebuchet MS",
        Verdana;
    font-weight: 200;
    font-size: 28px;
    text-align: center;
    margin-bottom: 20px;
}
</style>