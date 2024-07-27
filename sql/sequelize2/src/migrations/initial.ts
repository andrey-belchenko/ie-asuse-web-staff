import { QueryInterface } from 'sequelize';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface:QueryInterface) {
    await queryInterface.sequelize.query(`
      DROP VIEW IF EXISTS public.sales_view CASCADE;
      CREATE OR REPLACE VIEW public.sales_view
      AS select sale from  public.sales s;
    `);
  },
};