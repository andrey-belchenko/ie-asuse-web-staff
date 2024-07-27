'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.sequelize.query(`
      DROP VIEW IF EXISTS public.sales_view CASCADE;
      CREATE OR REPLACE VIEW public.sales_view
      AS select product from  public.sales s;
    `);
  },
};