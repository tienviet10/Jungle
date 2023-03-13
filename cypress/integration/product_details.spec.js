/* eslint-disable no-undef */

describe('Homepage', () => {
  beforeEach(() => {
    cy.visit('/');
  });

  it("Navigate to product page by clicking on product", () => {
    cy.get("[alt='Giant Tea']").click();
  });


});
